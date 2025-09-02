variable "aws_region" {
  description = "The AWS region in use to spawn the resources"
  type        = string
  default     = "eu-west-1"
}

variable "tfe_instance_type" {
  description = "The ec2 instance type for TFE"
  type        = string
  default = "m5.large"
}

variable "hosted_zone_name" {
  description = "The zone ID of my doormat hosted route53 zone"
  type        = string
}

variable "tfe_license" {
  description = "your TFE license string"
  type        = string
}

variable "tfe_encryption_password" {
  description = "TFE encryption password"
  type        = string
  default     = "Password1#"
  sensitive   = true
}

variable "tfe_version_image" {
  description = "The desired TFE version, example value: v202410-1"
  type        = string
}

variable "tfe_host_path_to_certificates" {
  description = "The path on the host machine to store the certificate files"
  type        = string
  default     = "/etc/terraform-enterprise/certs"
}

variable "tfe_host_path_to_data" {
  description = "The path on the host machine to store tfe data"
  type        = string
  default     = "/var/lib/terraform-enterprise/data"
}

variable "tfe_host_path_to_scripts" {
  description = "The path on the host machine to store tfe data"
  type        = string
  default     = "/var/lib/terraform-enterprise/scripts"
}

variable "lets_encrypt_cert" {
  description = "value"
  type        = string
  default     = "fullchain1.pem"
}

variable "lets_encrypt_key" {
  description = "value"
  type        = string
  default     = "privkey1.pem"
}

variable "admin_email" {
  type    = string
  default = "admin@example.com"
}

variable "admin_username" {
  type    = string
  default = "admin"
}

variable "admin_password" {
  description = "Admin password for TFE"
  type        = string
  sensitive   = true
}

variable "tfe_org" {
  description = "The name of the Terraform Enterprise organization"
  type        = string
  default     = "my-org"
}