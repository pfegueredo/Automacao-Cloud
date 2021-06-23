#Definir o provider
provider "aws" {
#    version = "~> 2.0"  #Descontinuado
    region = "us-east-2"
    profile = "terraform"
}

#Criar as instâncias
resource "aws_instance" "telemetria" { #com o nome telemetria
    count = 3 #Quantidade de instâncias
    ami = "ami-013de1b045799b282"
    instance_type = "t2.micro"
    key_name = "bootcamp" #key pair
    tags = {
        Name = "telemetria${count.index}"
    }
    #Vincula a instancia aos security groups com os Ids abaixo:
    #vpc_security_group_ids = ["sg-0d6a55fd885ce12fb","sg-0f1d3b4ab1b25ccc0"] 

}

#Cria Security Group liberando a porta 22
resource "aws_security_group" "acesso_ssh" {
  name        = "acesso_ssh"
  description = "Liberando acessos aos servidores via SSH"

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

#Cria Security Group liberando a porta 8080
resource "aws_security_group" "acesso_http" {
  name        = "acesso_http"
  description = "Liberando acessos aos servidores via SSH"

  ingress {

    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Acesso Http"
  }
}