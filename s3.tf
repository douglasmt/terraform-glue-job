resource "aws_s3_bucket" "glue_scripts" {
  bucket = "glue-job-scripts-${var.project_suffix}"
  force_destroy = true
}

resource "aws_s3_object" "glue_script" {
  bucket = aws_s3_bucket.glue_scripts.bucket
  key    = "job_script.py"
  source = "${path.module}/script/job_script.py"
  etag   = filemd5("${path.module}/script/job_script.py")
}
