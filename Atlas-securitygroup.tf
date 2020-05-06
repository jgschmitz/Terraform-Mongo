resource "mongodbatlas_project_ip_whitelist" "test" {
  project_id         = "<PROJECT-ID>"
  aws_security_group = "sg-0026348ec11780bd1"
  comment            = "TestAcc for awsSecurityGroup"

  depends_on = ["mongodbatlas_network_peering.test"]
}
