# Route traffic from the VPN (East - Manila) to the VPC
resource "aws_ec2_transit_gateway_route" "east_vpn_to_vpc_route" {
  destination_cidr_block         = "10.0.0.0/16" # VPC CIDR block for the West VPC
  transit_gateway_attachment_id  = aws_vpn_connection.manila_vpn_connection.transit_gateway_attachment_id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.cupa_tgw_route_table.id
}

# Route traffic from the VPC to the VPN (East - Manila)
resource "aws_ec2_transit_gateway_route" "vpc_to_east_vpn_route" {
  destination_cidr_block         = "192.168.1.0/24" # Replace with the on-premises network's CIDR for Manila
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.cupa_tgw_west_vpc_attachment.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.cupa_tgw_route_table.id
}

# Route traffic from the VPN (South - Sydney) to the VPC
resource "aws_ec2_transit_gateway_route" "south_vpn_to_vpc_route" {
  destination_cidr_block         = "10.0.0.0/16" # VPC CIDR block for the West VPC
  transit_gateway_attachment_id  = aws_vpn_connection.sydney_vpn_connection.transit_gateway_attachment_id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.cupa_tgw_route_table.id
}

# Route traffic from the VPC to the VPN (South - Sydney)
resource "aws_ec2_transit_gateway_route" "vpc_to_south_vpn_route" {
  destination_cidr_block         = "192.168.2.0/24" # Replace with the on-premises network's CIDR for Sydney
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.cupa_tgw_west_vpc_attachment.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.cupa_tgw_route_table.id
}

# Route traffic from the VPN (West - London) to the VPC
resource "aws_ec2_transit_gateway_route" "west_vpn_to_vpc_route" {
  destination_cidr_block         = "10.0.0.0/16" # VPC CIDR block for the West VPC
  transit_gateway_attachment_id  = aws_vpn_connection.london_vpn_connection.transit_gateway_attachment_id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.cupa_tgw_route_table.id
}

# Route traffic from the VPC to the VPN (West - London)
resource "aws_ec2_transit_gateway_route" "vpc_to_west_vpn_route" {
  destination_cidr_block         = "192.168.3.0/24" # Replace with the on-premises network's CIDR for London
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.cupa_tgw_west_vpc_attachment.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.cupa_tgw_route_table.id
}

# Route traffic from the VPN (North - Moscow) to the VPC
resource "aws_ec2_transit_gateway_route" "north_vpn_to_vpc_route" {
  destination_cidr_block         = "10.0.0.0/16" # VPC CIDR block for the West VPC
  transit_gateway_attachment_id  = aws_vpn_connection.moscow_vpn_connection.transit_gateway_attachment_id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.cupa_tgw_route_table.id
}

# Route traffic from the VPC to the VPN (North - Moscow)
resource "aws_ec2_transit_gateway_route" "vpc_to_north_vpn_route" {
  destination_cidr_block         = "192.168.4.0/24" # Replace with the on-premises network's CIDR for Moscow
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.cupa_tgw_west_vpc_attachment.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.cupa_tgw_route_table.id
}

# Route traffic between Moscow and Sydney
resource "aws_ec2_transit_gateway_route" "north_to_south_route" {
  destination_cidr_block         = "192.168.2.0/24" # Sydney Office network CIDR
  transit_gateway_attachment_id  = aws_vpn_connection.moscow_vpn_connection.transit_gateway_attachment_id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.cupa_tgw_route_table.id
}

resource "aws_ec2_transit_gateway_route" "south_to_north_route" {
  destination_cidr_block         = "192.168.4.0/24" # Moscow Office network CIDR
  transit_gateway_attachment_id  = aws_vpn_connection.sydney_vpn_connection.transit_gateway_attachment_id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.cupa_tgw_route_table.id
}

# Route traffic between London and Manila
resource "aws_ec2_transit_gateway_route" "west_to_east_route" {
  destination_cidr_block         = "192.168.1.0/24" # Manila Office network CIDR
  transit_gateway_attachment_id  = aws_vpn_connection.london_vpn_connection.transit_gateway_attachment_id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.cupa_tgw_route_table.id
}

resource "aws_ec2_transit_gateway_route" "east_to_west_route" {
  destination_cidr_block         = "192.168.3.0/24" # London Office network CIDR
  transit_gateway_attachment_id  = aws_vpn_connection.manila_vpn_connection.transit_gateway_attachment_id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.cupa_tgw_route_table.id
}
