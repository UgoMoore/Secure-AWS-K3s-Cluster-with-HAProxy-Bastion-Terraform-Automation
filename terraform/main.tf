module "vpc" {
  source = "./modules/01-vpc"

  vpc_name            = "Silent_Night"
  vpc_cidr            = "10.0.0.0/16"
  public_subnet_cidr  = "10.0.1.0/24"
  private_subnet_cidr = "10.0.2.0/24"
  availability_zone   = "us-east-1a"
}

module "k3s_haproxy" {
  source = "./modules/02-k3s-haproxy"

  vpc_id            = module.vpc.vpc_id
  public_subnet_id  = module.vpc.public_subnet_id
  private_subnet_id = module.vpc.private_subnet_id

  ami_id                = "ami-020cba7c55df1f615"
  key_name              = "my-aws-key"
  haproxy_instance_type = "t2.micro"
  k3s_instance_type     = "t2.medium"

  ssh_private_key_path  = "~/.ssh/my-aws-key.pem"
}

 
  
