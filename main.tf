terraform {
    required_providers {
        graphql = {
            source = "sullivtr/graphql"
            version = ">=2.5.4"
        }
    }
}



provider "graphql" {
    url = "${var.runpodApiEndpoint}?api_key=${var.runpodApiKey}"
}

resource "graphql_mutation" "runpod_create_mutation" {
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
        "volumeMountPath" = "${var.volumeMountPath}"
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

