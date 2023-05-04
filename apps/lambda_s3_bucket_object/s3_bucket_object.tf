data "archive_file" "dummyfile" {
  type        = "zip"
  output_path = "lambda.zip"
  source {
    content  = "1"
    filename = "dummyfile.txt"
  }
}

resource "aws_s3_bucket_object" "initialDummyContent" {
  bucket = "${var.lambda_bucket_name}"
  key    = "${var.s3_object_key}"
  source = "lambda.zip"
  lifecycle {
    ignore_changes = all
  }
}