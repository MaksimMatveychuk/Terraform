output "id" {
  value = data.aws_caller_identity.current.account_id
}

# output "db_instance_endpoint" {
#   value = aws_db_instance.postgres.address
# }

output "aws_identity" {
  value = data.aws_region.current.name
}

# output "web_lb_url" {
#   value = aws_elb.back_load_balancer.dns_name
# }