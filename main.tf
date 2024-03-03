terraform {
  required_providers {
    graphql = {
      source  = "sullivtr/graphql"
      version = ">=2.5.4"
    }
  }
}

provider "graphql" {
  url = "${var.runpodApiEndpoint}?api_key=${var.runpodApiKey}"
}

data "graphql_query" "selectGpuType"  {
    query_variables = {
      "gpuTypeFilter" = "${var.gpuTypeId}"
      "gpuLowestPriceInput" = var.gpuCount
    }

    query = file("${path.module}/queries/gpuTypesSelect.graphql")
}

data "graphql_query" "selectGpuType"  {
    query_variables = {
      "gpuTypeFilter" = "${var.gpuTypeId}"
      "gpuLowestPriceInput" = var.gpuCount
    }

    query = file("${path.module}/queries/gpuTypesSelect.graphql")
}

resource "graphql_mutation" "runpod_create_mutation" {
  mutation_variables = {
    #"cloudType" = var.cloudType
    "name"              = "${var.name}"
    "ports"             = "${var.ports}"
    "gpuTypeId"         = "${var.gpuTypeId}"
    "gpuCount"          = var.gpuCount
    "imageName"         = "${var.imageName}"
    "containerDiskInGb" = var.containerDiskInGb
    "volumeInGb"        = var.volumeInGb
    "dockerArgs"        = var.dockerArgs
    "volumeMountPath"   = "${var.volumeMountPath}"
  }

  compute_mutation_keys = {
    "podId" = "data.podFindAndDeployOnDemand.id"
  }

  compute_from_create = true

    create_mutation = file("${path.module}/queries/createMutation.graphql")
    update_mutation = file("${path.module}/queries/updateMutation.graphql")
    delete_mutation = file("${path.module}/queries/deleteMutation.graphql")
    read_query      = file("${path.module}/queries/readQuery.graphql")
}

