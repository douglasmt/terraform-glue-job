resource "aws_glue_job" "mock_job" {
  name     = "job-transform-test"
  role_arn = "arn:aws:iam::086720243261:role/glue_service_role_doug-proj-1"

  command {
    name            = "glueetl"
    script_location = "s3://${data.aws_s3_bucket.glue_scripts.bucket}/${aws_s3_object.glue_script.key}"
    python_version  = "3"
  }

  default_arguments = {
    "--JOB_NAME"   = "job-transform-test"
    "--INPUT_PATH" = "s3://douglasmaiatomebucket/dados/clientes.csv"
    "--enable-metrics"          = "true"
    "--enable-continuous-cloudwatch-log" = "true"
    "--enable-glue-datacatalog" = "true"
    "--enable-spark-ui"         = "true"
    "--spark-event-logs-path"   = "s3://douglasmaiatomebucket/logs/spark-events/"
  }

  glue_version        = "4.0"
  max_capacity        = 2
  timeout             = 10
  worker_type         = "G.1X"

}