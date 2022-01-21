output "bucketname" {
  value = aws_s3_bucket.tf_code_bucket.id
}

output "bucket_arn" {
  value = aws_s3_bucket.tf_code_bucket.arn
}