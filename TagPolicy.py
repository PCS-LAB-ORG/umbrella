from checkov.common.models.enums import CheckResult, CheckCategories
from checkov.terraform.checks.resource.base_resource_check import BaseResourceCheck


class TagPolicy(BaseResourceCheck):
    def __init__(self):
        # This is the full description of your check
        description = "Make sure that aws resource have a tag ApplicationID"

        # This is the Unique ID for your check
        id = "CKV_AWS_366"

        # These are the terraform objects supported by this check (ex: aws_iam_policy_document)
        supported_resources = ['aws_instance']

        # Valid CheckCategories are defined in checkov/common/models/enums.py
        categories = [CheckCategories.APPLICATION_SECURITY]
        super().__init__(name=description, id=id, categories=categories, supported_resources=supported_resources)

     def scan_resource_conf(self, conf):
     if 'tags' in conf.keys():
         tags = conf['tags'][0]
         if "Checkov" in tags:
             if tags["Checkov"] == "IsAwesome":
                 return CheckResult.PASSED

     return CheckResult.FAILED
check = TagPolicy()