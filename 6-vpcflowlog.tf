resource "aws_flow_log" "vpcFlowLog" {
  iam_role_arn    = aws_iam_role.AwsIamRole.arn
  log_destination = aws_cloudwatch_log_group.LogGroup.arn
  traffic_type    = "ALL"
  vpc_id          = aws_vpc.AwsVPC.id

  tags = {
    "Name" = "backend.vpcFlowLog"
  }
}

resource "aws_cloudwatch_log_group" "LogGroup" {
  name = "backend-${var.environment}-vpcLogGroup"
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["vpc-flow-logs.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "AwsIamRole" {
  name               = "backend-${var.environment}-vpcFlowLog-Role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "aws_iam_policy_document" "AwsIamPolicy" {
  statement {
    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams",
    ]

    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "AwsIamRolePloicy" {
  name   = "AwsIamRolePloicy"
  role   = aws_iam_role.AwsIamRole.id
  policy = data.aws_iam_policy_document.AwsIamPolicy.json
}