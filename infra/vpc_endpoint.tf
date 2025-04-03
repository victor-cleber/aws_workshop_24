resource "aws_vpc_endpoint" "s3_vpc_endpoint" {
  vpc_id       = aws_vpc.main.id
  service_name = "com.amazonaws.us-east-1.s3"

}
# associate route table with VPC endpoint
resource "aws_vpc_endpoint_route_table_association" "private_route_table_association" {
  route_table_id  = aws_route_table.app_rt.id
  vpc_endpoint_id = aws_vpc_endpoint.s3_vpc_endpoint.id
}