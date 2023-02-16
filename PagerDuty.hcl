provider "mongodbatlas" {
  public_key = var.public_key
  private_key = var.private_key
}

resource "mongodbatlas_project" "example" {
  name = var.project_name
  org_id = var.org_id
}

resource "mongodbatlas_cluster" "example" {
  name = var.cluster_name
  project_id = mongodbatlas_project.example.id
  num_shards = var.num_shards
  mongo_db_major_version = var.mongo_version

  provider_backup_enabled = true
  provider_backup_provider_name = "AWS"
  provider_backup_snapshot_interval_hours = 24
  provider_backup_snapshot_retention_days = 7
}

resource "mongodbatlas_cluster_alert_configuration" "example" {
  project_id = mongodbatlas_project.example.id
  cluster_id = mongodbatlas_cluster.example.id

  alerts_enabled = true

  # PagerDuty Integration
  alert_configurations {
    event_type_name = "OUTSIDE_METRIC_THRESHOLD"
    integrations {
      integration_name = "PagerDuty"
      integration_type = "PAGER_DUTY"
      service_key = var.pagerduty_service_key
    }
  }

  # Set up alerts for high CPU usage
  metric_threshold {
    metric_name = "CPU_USER"
    operator = "GT"
    threshold = 80
    metric_type = "CPU"
    resolution = "PT1M"
  }
}

