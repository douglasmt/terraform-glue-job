data "aws_iam_policy_document" "glue_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["glue.amazonaws.com"]
    }
  }
}

# resource "aws_iam_role" "glue_service_role" {
#   name = "glue_service_role_${var.project_suffix}"
#   assume_role_policy = data.aws_iam_policy_document.glue_assume_role.json
# }

# resource "aws_iam_role_policy_attachment" "glue_service_policy" {
#   role       = aws_iam_role.glue_service_role.name
#   policy_arn = "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"
# }

# Não criamos a role, apenas anexamos permissão ao grupo existente
resource "aws_iam_group_policy_attachment" "glue_group_policy" {
  group      = "glue-doug-user-group"
  policy_arn = "arn:aws:iam::aws:policy/AWSGlueConsoleFullAccess"
}

# resource "aws_iam_policy" "glue_s3_access" {
#   name = "glue-s3-full-access"
#   policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [
#       {
#         Effect = "Allow",
#         Action = [
#           "s3:PutObject",
#           "s3:GetObject",
#           "s3:DeleteObject",
#           "s3:ListBucket"
#         ],
#         Resource = [
#           "arn:aws:s3:::douglasmaiatomebucket",
#           "arn:aws:s3:::douglasmaiatomebucket/*"
#         ]
#       }
#     ]
#   })
# }

# resource "aws_iam_role_policy_attachment" "glue_attach_s3_access" {
#   role       = "glue_service_role_doug-proj-1"
#   policy_arn = aws_iam_policy.glue_s3_access.arn
# }

# resource "aws_iam_policy" "glue_cloudwatch_logs" {
#   name = "glue-cloudwatch-logs-access-doug"
#   policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [
#       {
#         Effect = "Allow",
#         Action = [
#           "logs:CreateLogGroup",
#           "logs:CreateLogStream",
#           "logs:PutLogEvents",
#           "logs:DescribeLogStreams",
#           "logs:DescribeLogGroups"
#         ],
#         Resource = "arn:aws:logs:*:*:*"
#       }
#     ]
#   })
# }

# resource "aws_iam_role_policy_attachment" "glue_attach_cloudwatch_logs" {
#   role       = "glue_service_role_doug-proj-1"
#   policy_arn = aws_iam_policy.glue_cloudwatch_logs.arn
# }