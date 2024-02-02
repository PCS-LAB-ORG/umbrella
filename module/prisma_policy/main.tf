resource "prismacloud_rql_search" "query_1" {
    search_type = var.search_type
    query = var.query
    time_range {
        relative {
            unit = var.unit
            amount = var.amount
        }
    }
}

resource "prismacloud_saved_search" "query" {
    name = var.savedsearch_name
    description = "made by terraform"
    search_id = prismacloud_rql_search.query_1.search_id
    query = prismacloud_rql_search.query_1.query
    time_range {
        relative {
            unit = prismacloud_rql_search.query_1.time_range.0.relative.0.unit
            amount = prismacloud_rql_search.query_1.time_range.0.relative.0.amount
        }
    }
}

resource "prismacloud_policy" "policy_01" {
    name = var.policy_name
    cloud_type  = var.cloud_type
    policy_type = var.policy_type
    severity    = "high"
    rule {
        name = var.rule_name
        rule_type = var.rule_type
        criteria = prismacloud_saved_search.query.search_id
        parameters = {
          savedSearch = false
          withIac     = false
        }
        
    }
}