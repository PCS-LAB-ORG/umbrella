resource "aws_cloudwatch_log_group" "flowlog_loggroup" {
  name = var.log_group_name
  tags = {
    application = "umbrella"
    yor_trace   = "6b8e3c67-9143-407a-8615-fd9071ca2803"
  }
}