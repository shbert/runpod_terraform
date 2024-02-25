variable "runpodApiEndpoint" {
    type = string
    default = "https://api.runpod.io/graphql"
}

variable "runpodApiKey" {
    description = "<sensitive information> Use your read/write API key generated on runpod.io->settings->API Keys"
    type = string
    sensitive = true
}

variable "name" {
    description = "Name of the pod"
    type = string
    default = "Terraform_Managed_POD"
}

variable "cloudType" {
    type = string
    default = "\"COMMUNITY\""
    validation {
        condition     = contains(["\"COMMUNITY\"", "\"SECURE\"", "\"ALL\""], var.cloudType)
        error_message = "Allowed values for input_parameter are \"COMMUNITY\", \"SECURE\", or \"ALL\"."
    }
}

variable "ports" {
    type = string
    default = "3000/http"
}

variable "gpuTypeId" {
    type = string
}

variable "gpuCount" {
    type = number
    default = 1
}

variable "imageName" {
    type = string
}
variable "containerDiskInGb" {
    type = number
    default = 5
}

variable "volumeInGb" {
    type = number
    default = 50
}
variable "volumePath" {
    type = string
    default = "/workspace"
}
variable "dockerArgs" {
  type = string
  default = ""
}

variable "proxyConnectUrl_template" {
  description = "Template used for returning the proper proxy url for connecting to pod application"
  type = string
  default = "%s://%s-%s.proxy.runpod.net"
}