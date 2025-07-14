resource "aws_glue_job" "mock_job" {
  name     = "job-transform-test"
  role_arn = "arn:aws:iam::086720243261:role/glue_service_role_doug-proj-2"

  command {
    name            = "glueetl"
    script_location = "s3://aws-glue-assets-086720243261-us-east-1/scripts/job_script.py"
    python_version  = "3"
  }

  default_arguments = {
    "--JOB_NAME"   = "job-transform-test"
    "--INPUT_PATH" = "s3://douglasmaiatomebucket/dados/clientes.csv"
  }

  glue_version = "4.0"
  max_capacity = 2
  timeout      = 10
}