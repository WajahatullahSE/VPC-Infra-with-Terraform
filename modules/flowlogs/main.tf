resource "aws_cloudwatch_log_group" "vpc_flow" {
  name = "/vpc-flow-logs/${var.env_tag}"
  retention_in_days = 30
  tags = { Environment = var.env_tag }
}

resource "aws_iam_role" "flow_role" {
  name = "${var.env_tag}-flow-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = { Service = "vpc-flow-logs.amazonaws.com" }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "flow_attach" {
  role       = aws_iam_role.flow_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
}


data "aws_caller_identity" "current" {}

resource "aws_flow_log" "vpc_flow" {
  log_destination      = aws_cloudwatch_log_group.vpc_flow.arn
  log_destination_type = "cloud-watch-logs"
  traffic_type         = "ALL"
  vpc_id               = var.vpc_id
  iam_role_arn         = aws_iam_role.flow_role.arn

  tags = {
    Name = "${var.env_tag}-vpc-flow-log"
  }
}


