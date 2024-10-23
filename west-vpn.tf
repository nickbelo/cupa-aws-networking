# UK Remote Office Gateway (Remote office in the West)
resource "aws_customer_gateway" "londonOffice_gateway" {
  bgp_asn    = 65002 #Replace with London Office ISP BGP ASN
  ip_address = "178.238.11.6" # Replace with your actual on-prem gateway IP for London Office
  type       = "ipsec.1"
}

# Site-to-Site VPN Connection using Transit Gateway for the West site
resource "aws_vpn_connection" "london_vpn_connection" {
  customer_gateway_id = aws_customer_gateway.londonOffice_gateway.id
  transit_gateway_id  = aws_ec2_transit_gateway.cupa_tgw.id
  type                = "ipsec.1"
  static_routes_only  = true

  tags = {
    Name = "LondonVPNConnection"
  }
}

# Associate VPN Connection for London Office with TGW Route Table
resource "aws_ec2_transit_gateway_route_table_association" "west_vpn_association" {
  transit_gateway_attachment_id  = aws_vpn_connection.london_vpn_connection.transit_gateway_attachment_id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.cupa_tgw_route_table.id
}
