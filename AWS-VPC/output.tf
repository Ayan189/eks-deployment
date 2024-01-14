output "vpc_id" {
  value       = aws_vpc.main.id
  description = "VPC ID"
  sensitive   = false
}

output "public_subnet_ids" {
  description = "The IDs of the public subnets"
  value       = [
    aws_subnet.public_1.id,
    aws_subnet.public_2.id
  ]
}

output "private_subnet_ids" {
  description = "The IDs of the private subnets"
  value       = [
    aws_subnet.private_1.id,
    aws_subnet.private_2.id
  ]
}

output "nat_gateway_ids" {
  description = "The IDs of the NAT Gateways"
  value       = [
    aws_nat_gateway.NatGateway1.id,
    aws_nat_gateway.NatGateway2.id
  ]
}

output "public_route_table_id" {
  description = "The ID of the public route table"
  value       = aws_route_table.Public_rt.id
}

output "private_route_table_ids" {
  description = "The IDs of the private route tables"
  value       = [
    aws_route_table.Private_rt1.id,
    aws_route_table.Private_rt2.id
  ]
}

