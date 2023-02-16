# Configure provider for MongoDB Atlas
provider "mongodbatlas" {
  public_key  = var.mongodbatlas_public_key
  private_key = var.mongodbatlas_private_key
}

# Configure provider for Prometheus
provider "prometheus" {
  url = var.prometheus_url
}

# Create a new MongoDB Atlas cluster
resource "mongodbatlas_cluster" "example" {
  name              = "example-cluster"
  provider_name     = "AWS"
  num_shards        = 3
  instance_size_name = "M10"
  mongodb_version   = "4.4"
}

# Create a Prometheus alert rule that monitors the MongoDB cluster
resource "prometheus_rule" "mongodb_cpu_usage" {
  rule {
    alert = "MongoDBHighCPUUsage"
    expr = "sum by (host) (rate(container_cpu_usage_seconds_total{container_name=\"mongodb\"}[5m])) > 0.8"
    for  = "5m"
    labels = {
      severity = "critical"
      cluster  = "${mongodbatlas_cluster.example.name}"
    }
    annotations = {
      summary = "High CPU usage in MongoDB cluster"
    }
  }
}
