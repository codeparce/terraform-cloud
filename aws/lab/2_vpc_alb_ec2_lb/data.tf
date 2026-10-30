data "http" "my_ip" {
  url = "https://checkip.amazonaws.com"
}


data "aws_lambda_function" "api" {
  function_name = "lambd-alb"
}
