# Configure the GCP provider
provider "google" {
  project = "your-gcp-project-id"
  region  = "us-central1"
}

# Create a VPC network
resource "google_compute_network" "private_network" {
  name                    = "mongodb-atlas-network"
  auto_create_subnetworks = false
}

# Create a subnet
resource "google_compute_subnetwork" "private_subnet" {
  name          = "mongodb-atlas-subnet"
  network       = google_compute_network.private_network.self_link
  ip_cidr_range = "10.0.0.0/24"
}

# Create a private service connect interface
resource "google_service_networking_connection" "private_service_connection" {
  provider = "google-beta"

  name                  = "mongodb-atlas-service-connection"
  network               = google_compute_network.private_network.self_link
  service               = "servicenetworking.googleapis.com"
  reserved_peering_ranges = ["google-managed-services-${var.region}"]
}

# Create a MongoDB Atlas cluster
resource "mongodbatlas_cluster" "example_cluster" {
  name                          = "example-cluster"
  provider_name                = "GCP"
  region_name                  = "US_CENTRAL1"
  instance_size_name           = "M10"
  mongodb_version              = "4.4"
  backup_enabled               = true
  auto_scaling_compute_enabled = false
  private_endpoint_enabled     = true
  num_shards                    = 1
  replication_factor            = 3

  project_id = "your-mongodb-atlas-project-id"

  # Connect the cluster to the private service connect interface
  provider_configuration {
    provider_name = "GCP"
    private_endpoint_mode = "PRIVATE_INTERFACE"

    network_peering {
      network_cidr_block = google_compute_network.private_network.ip_range
      service_network = google_service_networking_connection.private_service_connection.network
    }
  }

  # Specify the GCP private subnet for the cluster
  provider_settings {
    provider_name = "GCP"

    region_name = var.region

    gcp_network_name = google_compute_network.private_network.name
    gcp_subnet_name  = google_compute_subnetwork.private_subnet.name
  }
}
