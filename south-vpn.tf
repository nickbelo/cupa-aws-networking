# Autralia Remote Office Gateway (Remote office in the South)
resource "aws_customer_gateway" "sydneyOffice_gateway" {
  bgp_asn    = 65001 #Replace with Sydney Office ISP BGP ASN
  ip_address = "101.191.135.146" # Replace with actual Sydney Office ISP Public IP
  type       = "ipsec.1"
}

# Site-to-Site VPN Connection using Transit Gateway for the South
resource "aws_vpn_connection" "sydney_vpn_connection" {
  customer_gateway_id = aws_customer_gateway.sydneyOffice_gateway.id
  transit_gateway_id  = aws_ec2_transit_gateway.cupa_tgw.id
  type                = "ipsec.1"
  static_routes_only  = true

  tags = {
    Name = "sydneyVPNConnection"
  }
}

# Associate VPN Connection with TGW Route Table
resource "aws_ec2_transit_gateway_route_table_association" "sydney_vpn_association" {
  transit_gateway_attachment_id  = aws_vpn_connection.sydney_vpn_connection.transit_gateway_attachment_id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.cupa_tgw_route_table.id
}