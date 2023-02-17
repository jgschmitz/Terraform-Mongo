# Configure the MongoDB Atlas provider
provider "mongodbatlas" {
  public_key = "YOUR_PUBLIC_KEY"
  private_key = "YOUR_PRIVATE_KEY"
}

# Define variables for the MongoDB Atlas cluster
variable "cluster_name" {
  type = string
  default = "my-atlas-cluster"
}

variable "region" {
  type = string
  default = "US_EAST_1"
}

variable "instance_size" {
  type = string
  default = "M10"
}

# Define variables for the AWS PrivateLink connection
variable "aws_vpc_id" {
  type = string
  default = "vpc-12345"
}

variable "aws_subnet_ids" {
  type = list(string)
  default = ["subnet-12345", "subnet-67890"]
}

variable "aws_security_group_ids" {
  type = list(string)
  default = ["sg-12345"]
}

# Create the MongoDB Atlas cluster
resource "mongodbatlas_cluster" "my_cluster" {
  name                     = var.cluster_name
  num_shards               = 1
  replication_factor       = 3
  provider_name            = "AWS"
  region_name              = var.region
  instance_size_name       = var.instance_size
  auto_scaling_disk_gb_enabled = true
  auto_scaling_compute_enabled = true
}

# Create the AWS PrivateLink connection
resource "mongodbatlas_aws_private_link" "my_plink" {
  cluster_id          = mongodbatlas_cluster.my_cluster.id
  aws_vpc_id          = var.aws_vpc_id
  aws_subnet_ids      = var.aws_subnet_ids
  aws_security_group_ids = var.aws_security_group_ids
  vpc_endpoint_service_name = "com.amazonaws.vpce.us-east-1.vpce-svc-12345"
}
