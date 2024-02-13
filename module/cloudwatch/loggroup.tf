resource "aws_cloudwatch_log_group" "flowlog_loggroup" {
  name = var.log_group_name
  tags = {
    application = "umbrella"
  }
}