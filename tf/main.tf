 provider "aws" {
  region = "ap-south-1"
}


resource "aws_iam_role" "lambda_role" {
  name = "tmdb_api_lambda_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
	Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}
data "archive_file" "helloworld_zip" {
  type        = "zip"
  source_dir  = "${path.module}/../python/"
  output_path = "${path.module}/helloworld.zip"
}

resource "aws_lambda_function" "example_lambda" {
  function_name = "my_tmbd_api_lambda_function"
  handler      = "helloworld.lambda_handler"
  runtime      = "python3.9"
  filename     = "${path.module}/../python/helloworld.zip"
  role         = aws_iam_role.lambda_role.arn
}

