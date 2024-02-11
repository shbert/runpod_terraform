terraform {
    required_providers {
        graphql = {
            source = "sullivtr/graphql"
            version = "2.5.4"
        }
    }
}

variable "runpodApiEndpoint" {}
variable "runpodApiKey" {}

variable "name" {}
variable "cloudType" {}
variable "ports" {}
variable "gpuTypeId" {}
variable "gpuCount" {}
variable "imageName" {}
variable "containerDiskInGb" {}
variable "volumeInGb" {}
variable "volumePath" {}

provider "graphql" {
    url = "${var.runpodApiEndpoint}?api_key=${var.runpodApiKey}"
}


#data "graphql_query" "basic_query" {
#    query_variables = {}
#    query = file("./queries/gpuTypes.graphql")
#}

#locals {
#    gpu_data = jsondecode(data.graphql_query.basic_query.query_response)
#    all_gpuIds = [for l_gpuType in local.gpu_data.data.gpuTypes : l_gpuType.id]
#}

#output "graphql_query_out" {
#    value = local.all_gpuIds
#}

resource "graphql_mutation" "basic_mutation" {
    mutation_variables = {
        #"cloudType" = "${var.cloudType}"
        "name" = "${var.name}"
        "ports" = "${var.ports}"
        "gpuTypeId" = "${var.gpuTypeId}"
        "gpuCount" = var.gpuCount
        "imageName" = "${var.imageName}"
        "containerDiskInGb" = var.containerDiskInGb
        "volumeInGb" = var.volumeInGb
        #"volumePath" = "${var.volumePath}"
    }

    # read_query_variables = {
    #   "podId" = "afdsfsadfasdf"
    # }

    # delete_mutation_variables = {
    #   "podId" = "asdasd"
    # }

    compute_mutation_keys = {
        "podId" = "data.podFindAndDeployOnDemand.id"
    }

    compute_from_create = true

    create_mutation = file("./queries/createMutation.qraphql")
    update_mutation = file("./queries/updateMutation.graphql")
    delete_mutation = file("./queries/deleteMutation.graphql")
    read_query      = file("./queries/readQuery.graphql")
}