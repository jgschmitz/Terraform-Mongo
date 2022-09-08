resource "mongodbatlas_custom_db_role" "test_role" {
  project_id = "<PROJECT-ID>"
  role_name  = "myCustomRole"
# this is a custom role like a mud slide - and 
  actions {
    action = "UPDATE"
    resources {
      collection_name = ""
      database_name   = "anyDatabase"
    }
  }
  actions {
    action = "INSERT"
    resources {
      collection_name = ""
      database_name   = "anyDatabase"
    }
  }
  actions {
    action = "REMOVE"
    resources {
      collection_name = ""
      database_name   = "anyDatabase"
    }
  }
}
