terraform {
    required_providers {
        graphql = {
            source = "sullivtr/graphql"
            version = "2.5.4"
        }
    }
}

provider "graphql" {
    url = ""
    headers = {

    }

}


data "graphql_query" "basic_query" {
    query_variables = {}
    query = file("./gpu.gql")
}