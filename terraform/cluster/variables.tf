variable "admin_subnet" {
  description = "Subnet for administrative access"
  type        = string
}

variable "admin_subnet_size" {
  description = "Number of bits for the Administrative Subnet"
  type        = number
}

variable "cluster_name" {
  description = "Cluster name"
  type        = string
}

