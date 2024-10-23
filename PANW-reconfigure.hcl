provider "mongodbatlas" {
  public_key  = var.atlas_public_key
  private_key = var.atlas_private_key
}

resource "mongodbatlas_cluster" "example_cluster" {
  project_id   = var.atlas_project_id
  name         = "example-cluster"
  mongo_db_major_version = "6.0"

  // Primary settings
  cluster_type = "REPLICASET"
  replication_factor = 3

  provider_backup_enabled = true

  // Adjust region configuration
  // New configuration: 2 electable and 1 read-only in us-east-1, 1 electable in us-west-2
  replication_specs {
    region_configs {
      region_name     = "US_EAST_1"
      electable_nodes = 2
      read_only_nodes = 1
      priority        = 7  // Set higher priority to ensure primary is elected here
    }

    region_configs {
      region_name     = "US_WEST_2"
      electable_nodes = 1
      read_only_nodes = 0
      priority        = 5  // Lower priority so it doesn't take over unless needed
    }
  }
}
