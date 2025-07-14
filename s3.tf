data "aws_s3_bucket" "glue_scripts" {
  bucket = "glue-job-scripts-doug-proj-1"
}

resource "aws_s3_object" "glue_script" {
  bucket = data.aws_s3_bucket.glue_scripts.id
  key    = "job_script.py"
  source = "${path.module}/script/job_script.py"
  etag   = filemd5("${path.module}/script/job_script.py")
}
