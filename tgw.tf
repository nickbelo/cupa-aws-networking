# AWS Transit Gateway (Global scope, no need to specify region)
resource "aws_ec2_transit_gateway" "cupa_tgw" {
  description = "Cupa Transit Gateway"
}

# VPC Attachment for West VPC to Transit Gateway
resource "aws_ec2_transit_gateway_vpc_attachment" "cupa_tgw_west_vpc_attachment" {
  transit_gateway_id = aws_ec2_transit_gateway.cupa_tgw.id
  vpc_id             = aws_vpc.west_vpc.id
  subnet_ids         = [aws_subnet.west_subnet.id] #add more subnet later for resources grouping or managements
}

# Transit Gateway Route Table
resource "aws_ec2_transit_gateway_route_table" "cupa_tgw_route_table" {
  transit_gateway_id = aws_ec2_transit_gateway.cupa_tgw.id
}

# Associate VPC Attachment with TGW Route Table
resource "aws_ec2_transit_gateway_route_table_association" "west_vpc_association" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.cupa_tgw_west_vpc_attachment.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.cupa_tgw_route_table.id
}
