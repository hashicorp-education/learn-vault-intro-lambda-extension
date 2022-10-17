# AWS region and AZs in which to deploy
variable "aws_region" {
  default = "us-east-1"
}

# All resources will be tagged with this
variable "environment_name" {
  default = "vault-lambda-extension-demo"
}

# URL for Vault OSS binary
variable "vault_zip_file" {
  default = "https://releases.hashicorp.com/vault/1.6.0/vault_1.6.0_linux_amd64.zip"
}

# Instance size
variable "instance_type" {
  default = "t2.micro"
}

variable "cloud_provider" {
  description = "The cloud provider of the HCP HVN and Vault cluster."
  type        = string
  default     = "aws"
}

variable "tier" {
  description = "Tier of the HCP Vault cluster."
  type        = string
  default     = "dev"
}

variable "primary_region" {
  description = "The region of the primary cluster HCP HVN and Vault cluster."
  type        = string
  default     = "us-east-1"
}

variable "primary_cluster_hvn" {
  description = "The ID of the HCP HVN."
  type        = string
  default     = "hvn-aws-us-east-1"
}

variable "primary_cluster_hvn_cidr" {
  description = "The CIDR range of the HCP HVN."
  type        = string
  default     = "172.25.16.0/20"
}

variable "primary_cluster_id" {
  description = "The ID of the HCP Vault cluster."
  type        = string
  default     = "vault-cluster-primary"
}