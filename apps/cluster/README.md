## Synopsis

This part of the module is for clustering machines created by Terraform
When creating the stack, point to this module to use machines with their SG. Plus load balancer and its SG. 

## Code Example


```hcl-terraform
module "consul-cluster" {
  source = "git@github.com:albumprinter/eops_tf_modules.git//apps/cluster?ref={TAG_VERSION}" # for eg. {TAG_VERSION} = v0.7.0
    tags_team = "eops" //team name
    environment = "dev-nonprod-prod" 
    app_name = "eops-consul" //name of the application for cluster
    app_elb_name = "eops-consul_ELB" //name of the loadbalancer
    chef_run_list = "eops-consul::default" //chef runlist name
    description = "consul_cluster" //application description
    instance_count = "0" //how many instances needed in the cluster"
    key_name = "example key pair" //keypair being used in AWS
    user_keypath = "x:/example/example.pem" //path where keypair pem file remains, should be set by CI-pipeline
    private_keypath = "x:/example/example.pem" //path where chefkey pem file remains, should be set by CI-pipeline
    chef_serverurl = "https://chef.albelli.com/organizations/" //url to chef server
    SG_cidr_blocks = "ip-addresses" //cidrblocks to attach to (SG)
    SG_elb_cidr_blocks = "ip-addresses" //cidrblocks to attach to (LB)
    lb_port_outside = "80" //LB listening port
    lb_protocol_outside = "http" //LB listening protocol
    instance_port_inside = "8500" //application port to instances
    instance_protocol_inside = "http" //LB application protocol to instances
}
```