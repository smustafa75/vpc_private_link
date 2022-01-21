# generate random id
resource "random_id" "tf_bucket_id" {
  byte_length = 2
}

# generate S3 bucket
resource "aws_s3_bucket" "tf_code_bucket" {
  bucket        = "${var.project_name}-${random_id.tf_bucket_id.dec}"
  acl           = "private"
  force_destroy = true


  tags = {
    Name = "S3 - Demo Module"
  }
}

# Template

data "template_file" "s3_policy_work" {
  template = templatefile("${path.module}/policy_vpce.json", {
    bucket_arns = aws_s3_bucket.tf_code_bucket.arn
   # bucket_id = aws_s3_bucket.tf_code_bucket.id
    source_vpc = var.vpcendpoint

  })
  depends_on = [
    aws_s3_bucket.tf_code_bucket
  ]
}
# Bucket Policy
resource "aws_s3_bucket_policy" "bucket_policy_01" {
  bucket = aws_s3_bucket.tf_code_bucket.id

  policy = data.template_file.s3_policy_work.template
 }

