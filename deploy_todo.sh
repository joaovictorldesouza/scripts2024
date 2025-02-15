#!/bin/bash

# Definições
AMI_ID="ami-04b4f1a9cf54c11d0"
INSTANCE_TYPE="t2.micro"
KEY_NAME="labsuser.pem" 
SECURITY_GROUP="launch-wizard-2" 
SUBNET_ID="vpc-0fbccaa8996a4649b " 

echo "Criando instância EC2 na AWS..."
INSTANCE_ID=$(aws ec2 run-instances --image-id $AMI_ID --count 1 --instance-type $INSTANCE_TYPE --key-name $KEY_NAME --security-group-ids $SECURITY_GROUP --subnet-id $SUBNET_ID --query 'Instances[0].InstanceId' --output text)

echo "Aguardando a inicialização da instância..."
aws ec2 wait instance-running --instance-ids $INSTANCE_ID

echo "Obtendo IP público da instância..."
IP=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --query 'Reservations[0].Instances[0].PublicIpAddress' --output text)

echo "Acessando a instância via SSH e configurando o ambiente..."
ssh -o StrictHostKeyChecking=no -i ~/.ssh/$KEY_NAME.pem ubuntu@$IP << 'EOF'
    sudo apt-get update
    sudo apt-get -y install python3-venv python3-pip python3-dev build-essential libssl-dev libffi-dev python3-setuptools nginx git

    mkdir /todolist
    cd /todolist

    python3 -m venv venv
    source venv/bin/activate
    pip install wheel
    pip install gunicorn Flask Flask-SQLAlchemy
    deactivate

    git clone https://github.com/joaomarceloalencar/devops
    sudo chown ubuntu:www-data /todolist/devops/Laboratorios/01_Flask

    sudo cp /todolist/devops/Laboratorios/01_Flask/conf/todolist.service /etc/systemd/system/
    sudo systemctl start todolist
    sudo systemctl enable todolist

    sudo cp /todolist/devops/Laboratorios/01_Flask/conf/todolist /etc/nginx/sites-available/
    sudo ln -s /etc/nginx/sites-available/todolist /etc/nginx/sites-enabled/
    sudo rm /etc/nginx/sites-enabled/default
    sudo systemctl restart nginx
EOF

echo "Aplicação TODOLIST disponível em: http://$IP"

