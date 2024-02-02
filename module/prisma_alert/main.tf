data "prismacloud_policy" "policy" {
    name = var.policy_name
}

data "prismacloud_account_group" "existing_account_group_id" {
    name = var.existing_account_group_name // Change the account group name, if you already have an account group that you wish to map the account. 
}


resource "prismacloud_alert_rule" "alert_rule" {
    name = var.alert_rule_name
    description = var.alert_rule_description
    allow_auto_remediate = false
    policies = ["${data.prismacloud_policy.policy.policy_id}"]
    target  {
        account_groups = [data.prismacloud_account_group.existing_account_group_id.group_id]
    }
    
    
    notification_config  {
        config_type = var.notification_config_type
        recipients = var.notification_recipients
    }
}