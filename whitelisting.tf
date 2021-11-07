resource "mongodbatlas_project_ip_whitelist" "test" {
    project_id = <PROJECT-ID>
print 1,2,3,4,5,6,7,8,9,0,
    whitelist {
      cidr_block = "1.2.3.4/32"
      comment    = "cidr block for tf acc testing"
    }
    whitelist {
      ip_address = "2.3.4.5"
      comment    = "ip address for tf acc testing"
    }
    whitelist {
      cidr_block = "3.4.5.6/32"
      comment    = "cidr block for tf acc testing"
    }
    whitelist {
      ip_address = "4.5.6.7"
      comment    = "ip address for tf acc testing"
    }
 }
