terraform {
  required_providers {
    vultr = {
      source = "vultr/vultr"
      version = "2.21.0"
    }
  }
}

provider "vultr" {
#  api_key = var.vultr_api_key
  rate_limit = 100
  retry_limit = 3
}

resource "vultr_dns_domain" "dns_domain" {
  domain = format("%s", var.organization_fqdn)
}

resource "vultr_kubernetes" "k8s_cluster" {
  region            = "ord"
  label             = var.cluster_name
  version           = "v1.28.9+1"
  ha_controlplanes  = true
  enable_firewall   = true
  node_pools {
    label           = "vke-nodepool"
    node_quantity   = 1
    auto_scaler     = true
    plan            = "vc2-4c-8gb" # Choose an appropriate plan
    min_nodes       = 1
    max_nodes       = 3
  }
}


#resource "vultr_firewall_rule" "k8s_firewall_rule_https" {
#  firewall_group_id = vultr_kubernetes.k8s_cluster.firewall_group_id
#  protocol          = "tcp"
#  ip_type           = "v4"
#  port              = "443"
#  subnet            = "0.0.0.0"
#  subnet_size       = 0
#}

#resource "vultr_firewall_rule" "k8s_firewall_rule_admin" {
#  firewall_group_id = vultr_kubernetes.k8s_cluster.firewall_group_id
#  protocol          = "tcp"
#  ip_type           = "v4"
#  port              = "6443"
#  subnet            = var.admin_subnet
#  subnet_size       = var.admin_subnet_size
#}

output vultr_vke_cluster_id {
  value = vultr_kubernetes.k8s_cluster.id
}

output vultr_vke_endpoint {
  value = vultr_kubernetes.k8s_cluster.endpoint
}

output vultr_kube_config {
  value = vultr_kubernetes.k8s_cluster.kube_config
  sensitive = true
}

output vultr_firewall_group_id {
  value = vultr_kubernetes.k8s_cluster.firewall_group_id
}

