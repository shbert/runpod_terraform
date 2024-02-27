output "imageName" {
  description = "Used image name for the pod creation"
  value       = graphql_mutation.runpod_create_mutation.mutation_variables.imageName
}

output "podId" {
  description = "PodId for the created container"
  value       = graphql_mutation.runpod_create_mutation.computed_read_operation_variables.podId
}

output "proxyConnectUrl" {
  description = "URL for connecting workload via runpod proxy"
  value       = format(var.proxyConnectUrl_template, split("/", var.ports)[1], graphql_mutation.runpod_create_mutation.computed_read_operation_variables.podId, split("/", var.ports)[0])
}