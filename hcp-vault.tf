resource "time_sleep" "wait_30_primary" {
  depends_on      = [hcp_vault_cluster.primary_cluster]
  create_duration = "30s"
}

resource "hcp_hvn" "primary_cluster_hvn" {
  hvn_id         = var.primary_cluster_hvn
  cloud_provider = var.cloud_provider
  region         = var.primary_region
  cidr_block     = var.primary_cluster_hvn_cidr
}

resource "hcp_vault_cluster" "primary_cluster" {
  hvn_id          = hcp_hvn.primary_cluster_hvn.hvn_id
  cluster_id      = var.primary_cluster_id
  tier            = var.tier
  public_endpoint = true
}

resource "hcp_vault_cluster_admin_token" "primary_cluster_token" {
  cluster_id = var.primary_cluster_id
  depends_on = [time_sleep.wait_30_primary]
} 