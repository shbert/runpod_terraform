terraform {
    required_providers {
        graphql = {
            source = "sullivtr/graphql"
            version = ">=2.5.4"
        }
    }
}

variable "runpodApiEndpoint" {}
variable "runpodApiKey" {}

variable "name" {}
variable "cloudType" {
    type = string
    default = "COMMUNITY"
    validation {
        condition     = contains(["COMMUNITY", "SECURE", "ALL"], var.cloudType)
        error_message = "Allowed values for input_parameter are \"COMMUNITY\", \"SECURE\", or \"ALL\"."
    }
}
variable "ports" {}
variable "gpuTypeId" {}
variable "gpuCount" {}
variable "imageName" {}
variable "containerDiskInGb" {}
variable "volumeInGb" {}
variable "volumePath" {}
variable "dockerArgs" {
  type = string
  default = ""
}

provider "graphql" {
    url = "${var.runpodApiEndpoint}?api_key=${var.runpodApiKey}"
}

resource "graphql_mutation" "basic_mutation" {
    mutation_variables = {
        #"cloudType" = var.cloudType
        "name" = "${var.name}"
        "ports" = "${var.ports}"
        "gpuTypeId" = "${var.gpuTypeId}"
        "gpuCount" = var.gpuCount
        "imageName" = "${var.imageName}"
        "containerDiskInGb" = var.containerDiskInGb
        "volumeInGb" = var.volumeInGb
        "dockerArgs" = var.dockerArgs
        #"volumePath" = "${var.volumePath}"
    }

    compute_mutation_keys = {
        "podId" = "data.podFindAndDeployOnDemand.id"
    }

    compute_from_create = true

    create_mutation = file("./queries/createMutation.graphql")
    update_mutation = file("./queries/updateMutation.graphql")
    delete_mutation = file("./queries/deleteMutation.graphql")
    read_query      = file("./queries/readQuery.graphql")
}