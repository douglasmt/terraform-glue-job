output "bucket_name" {
  value = data.aws_s3_bucket.glue_scripts.bucket
}