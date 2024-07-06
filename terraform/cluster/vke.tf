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

