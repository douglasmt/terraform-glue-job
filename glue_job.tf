resource "aws_glue_job" "mock_job" {
  name     = "job-transform-test"
  role_arn = aws_iam_role.glue_service_role.arn

  command {
    name            = "glueetl"
    script_location = "s3://${aws_s3_bucket.glue_scripts.bucket}/job_script.py"
    python_version  = "3"
  }

  default_arguments = {
    "--JOB_NAME"   = "mock-glue-job"
    "--INPUT_PATH" = "s3://douglasmaiatomebucket/dados/clientes.csv"
  }

  glue_version = "4.0"
  max_capacity = 2
  timeout      = 10
}