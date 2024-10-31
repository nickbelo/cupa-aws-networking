# Russia Remote Office Gateway (Remote office in the West)
resource "aws_customer_gateway" "moscowOffice_gateway" {
  bgp_asn    = 65003
  ip_address = "91.218.114.206" # Replace with your actual on-prem gateway IP for Moscow Office
  type       = "ipsec.1"
}

# Site-to-Site VPN Connection using Transit Gateway for the North site
resource "aws_vpn_connection" "moscow_vpn_connection" {
  customer_gateway_id = aws_customer_gateway.moscowOffice_gateway.id
  transit_gateway_id  = aws_ec2_transit_gateway.cupa_tgw.id
  type                = "ipsec.1"
  static_routes_only  = true

  tags = {
    Name = "MoscowVPNConnection"
  }
}

# Associate VPN Connection for Moscow Office with TGW Route Table
resource "aws_ec2_transit_gateway_route_table_association" "north_vpn_association" {
  transit_gateway_attachment_id  = aws_vpn_connection.moscow_vpn_connection.transit_gateway_attachment_id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.cupa_tgw_route_table.id
}
