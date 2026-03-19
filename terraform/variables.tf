variable "region" {
  default = "eu-central-1"
}

variable "cluster_name" {
  default = "eksdeploy-cluster"
}

variable "node_instance_type" {
  default = "t3.medium"
}

variable "desired_nodes" {
  default = 2
}