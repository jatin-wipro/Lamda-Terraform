locals {
 lambda_file_loc = "outputs/welcome.zip"
}

#used for archive the file to specific folder
data "archive_file" "welcome" {
 type = "zip"
 source_file = "welcome.py"
 output_path = "${local.lambda_file_loc}"
}

resource "aws_lambda_function" "test_lambda" {
   filename   = "${local.lambda_file_loc}"
   function_name = "welcome"
   role = "${aws_iam_role.lambda_role.arn}"
   handler = "welcome.hello"
   source_code_hash = "${filebase64sha256(local.lambda_file_loc)}"
   runtime = "python3.7"

}
