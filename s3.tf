resource "aws_s3_bucket" "glue_scripts" {
  bucket = "glue-job-scripts-${var.project_suffix}"
  force_destroy = true
}