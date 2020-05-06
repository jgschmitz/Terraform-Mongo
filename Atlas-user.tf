resource "mongodbatlas_database_user" "test" {
  username           = "test-acc-username"
  password           = "test-acc-password"
  project_id         = "<PROJECT-ID>"
  auth_database_name = "admin"

  roles {
    role_name     = "readWrite"
    database_name = "admin"
  }

  roles {
    role_name     = "atlasAdmin"
    database_name = "admin"
  }

  labels {
    key   = "key 1"
    value = "value 1"
  }
  labels {
    key   = "key 2"
    value = "value 2"
  }
}

data "mongodbatlas_database_user" "test" {
  project_id = mongodbatlas_database_user.test.project_id
  username   = mongodbatlas_database_user.test.username
}
