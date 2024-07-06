terraform {
  required_providers {
    vultr = {
      source  = "vultr/vultr"
      version = "2.21.0"
    }
  }

  # This would need some work if more than one cluster is needed
  backend "s3" {
    bucket                      = "tfstore"
    key                         = "terraform.tfstate"
    endpoints                   = { s3 = "https://ewr1.vultrobjects.com" }
    region                      = "us-east-1"
    skip_credentials_validation = true
    skip_requesting_account_id  = true
  }
}
