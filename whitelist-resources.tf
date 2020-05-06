resource "mongodbatlas_project_ip_whitelist" "test" {
    project_id = <PROJECT-ID>
    cidr_block = "1.2.3.4/32"
    comment    = "cidr block for tf acc testing"
}  
resource "mongodbatlas_project_ip_whitelist" "test2" {
    project_id = <PROJECT-ID>
    ip_address = "2.3.4.5"
    comment    = "ip address for tf acc testing"
}
resource "mongodbatlas_project_ip_whitelist" "test3" {
    project_id = <PROJECT-ID>
    cidr_block = "3.4.5.6/32"
    comment    = "cidr block for tf acc testing"
}
resource "mongodbatlas_project_ip_whitelist" "test4" {
    project_id = <PROJECT-ID>
    ip_address = "4.5.6.7"
    comment    = "ip address for tf acc testing"
}
