resource "mongodbatlas_encryption_at_rest" "test" {
  project_id = "<PROJECT-ID>"

  aws_kms = {
    enabled                = true
    access_key_id          = "AKIAIOSFODNN7EXAMPLE"
    secret_access_key      = "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY"
    customer_master_key_id = "030gce02-586d-48d2-a966-05ea954fde0g"
    region                 = "US_EAST_1"
  }

  azure_key_vault = {
    enabled             = true
    client_id           = "g54f9e2-89e3-40fd-8188-EXAMPLEID"
    azure_environment   = "AZURE"
    subscription_id     = "0ec944e3-g725-44f9-a147-EXAMPLEID"
    resource_group_name = "ExampleRGName"
    key_vault_name      = "EXAMPLEKeyVault"
    key_identifier      = "https://EXAMPLEKeyVault.vault.azure.net/keys/EXAMPLEKey/d891821e3d364e9eb88fbd3d11807b86"
    secret              = "EXAMPLESECRET"
    tenant_id           = "e8e4b6ba-ff32-4c88-a9af-EXAMPLEID"
  }

  google_cloud_kms = {
    enabled                 = true
    service_account_key     = "{\"type\": \"service_account\",\"project_id\": \"my-project-common-0\",\"private_key_id\": \"e120598ea4f88249469fcdd75a9a785c1bb3\",\"private_key\": \"-----BEGIN PRIVATE KEY-----\\nMIIEuwIBA(truncated)SfecnS0mT94D9\\n-----END PRIVATE KEY-----\\n\",\"client_email\": \"my-email-kms-0@my-project-common-0.iam.gserviceaccount.com\",\"client_id\": \"10180967717292066\",\"auth_uri\": \"https://accounts.google.com/o/oauth2/auth\",\"token_uri\": \"https://accounts.google.com/o/oauth2/token\",\"auth_provider_x509_cert_url\": \"https://www.googleapis.com/oauth2/v1/certs\",\"client_x509_cert_url\": \"https://www.googleapis.com/robot/v1/metadata/x509/my-email-kms-0%40my-project-common-0.iam.gserviceaccount.com\"}"
    key_version_resource_id = "projects/my-project-common-0/locations/us-east4/keyRings/my-key-ring-0/cryptoKeys/my-key-0/cryptoKeyVersions/1"
  }
}
