#Definir o provider
provider "aws" {
#    version = "~> 2.0"  #Descontinuado
    region = "us-east-2"
    #profile = "terraform"
}

#Criar as instâncias
resource "aws_instance" "MinhaInstancia" { 
    count = 1 #Quantidade de instâncias
    ami = "ami-00399ec92321828f5" #Ubuntu 20.4
    #ami = "ami-0d8d212151031f51c" #Amazon Linux 2
    instance_type = "t2.micro"
    subnet_id = "subnet-057d208018104b01b"
    key_name = "ubuntu_aws_pfegueredo" #key pair

    #Vincula a instancia aos security groups com os Ids abaixo:
    vpc_security_group_ids = ["sg-0fa36cbc3f8524cf2"] #Default
    #, "aws_security_group.SG-Empresa-Acesso-SSH.id", "aws_security_group.SG-Empresa-Acesso-HTTP.id"
    user_data = "${file("userdata.txt")}"

    tags = {
        Name        = "servidor${count.index}"
        Environment = "Dev"
        ManagedBy   = "Terraform"
        Owner       = "Paulo Fegueredo"
        UpdateAt    = "2021-06-23"
      }
}

#Cria Security Group liberando a porta 22
resource "aws_security_group" "SG-Empresa-Acesso-SSH" {
  name        = "SG-Empresa-SSH"
  description = "Liberando acessos aos servidores via SSH"
  vpc_id = "vpc-0ed61a1b1b45d0a6a"

  ingress {

    from_port   = 22
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Acesso SSH"
  }
}

#Cria Security Group liberando a porta 80
resource "aws_security_group" "SG-Empresa-Acesso-HTTP" {
  name        = "SG-Empresa-HTTP"
  description = "Liberando acessos aos servidores via SSH"
  vpc_id = "vpc-0ed61a1b1b45d0a6a"

  ingress {

    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Acesso Http"
  }
}


