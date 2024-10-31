# Philippines Remote Office Gateway (Remote office in the East)
resource "aws_customer_gateway" "manilaOffice_gateway" {
  bgp_asn    = 65000 #Replace with Manila Office ISP BGP ASN
  ip_address = "136.158.24.117" # Replace with actual Manila Office ISP Public IP
  type       = "ipsec.1"
}

# Site-to-Site VPN Connection using Transit Gateway for the East
resource "aws_vpn_connection" "manila_vpn_connection" {
  customer_gateway_id = aws_customer_gateway.manilaOffice_gateway.id
  transit_gateway_id  = aws_ec2_transit_gateway.cupa_tgw.id
  type                = "ipsec.1"
  static_routes_only  = true

  tags = {
    Name = "ManilaVPNConnection"
  }
}

# Associate VPN Connection with TGW Route Table
resource "aws_ec2_transit_gateway_route_table_association" "manila_vpn_association" {
  transit_gateway_attachment_id  = aws_vpn_connection.manila_vpn_connection.transit_gateway_attachment_id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.cupa_tgw_route_table.id
}