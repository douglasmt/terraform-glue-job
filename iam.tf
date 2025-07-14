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