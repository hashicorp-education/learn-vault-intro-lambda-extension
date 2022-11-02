
# Vault Client (Lambda function) IAM Config
resource "aws_iam_instance_profile" "lambda" {
  name = "${var.environment_name}-lambda-instance-profile"
  role = aws_iam_role.lambda.name
}

resource "aws_iam_role" "lambda" {
  name               = "${var.environment_name}-lambda-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role_lambda.json
}

resource "aws_iam_role_policy" "lambda" {
  name   = "${var.environment_name}-lambda-policy"
  role   = aws_iam_role.lambda.id
  policy = data.aws_iam_policy_document.lambda.json
}

data "aws_iam_policy_document" "assume_role_lambda" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "lambda" {
  statement {
    sid    = "LambdaLogs"
    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]

    resources = ["*"]
  }
}



resource "aws_lambda_function" "function" {
  function_name = "${var.environment_name}-function"
  description   = "Demo Vault AWS Lambda extension"
  role          = aws_iam_role.lambda.arn
  filename      = "./demo-function/demo-function.zip"
  handler       = "handler.lambda_handler"
  runtime       = "python3.9"
  layers        = ["arn:aws:lambda:${var.aws_region}:634166935893:layer:vault-lambda-extension:14"]

  environment {
    variables = {
      // this will need to be updated for HCP vault
      VAULT_ADDR          = "${hcp_vault_cluster.primary_cluster.vault_public_endpoint_url}",
      VAULT_AUTH_ROLE     = "vault-role-for-aws-lambdarole" # aws_iam_role.lambda.name,
      VAULT_AUTH_PROVIDER = "aws",
      VAULT_SECRET_PATH_  = "kv/data/test/lambda"
      VAULT_SECRET_FILE   = "/tmp/vault_secret.json",
      VAULT_NAMESPACE     = "admin",
    }
  }
}