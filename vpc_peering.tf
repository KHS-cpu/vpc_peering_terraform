resource "aws_vpc_peering_connection" "srvr1_to_srvr2" {
  peer_vpc_id   = module.srvr-1.vpc_id
  vpc_id        = module.srvr-2.vpc_id
  auto_accept   = true
}

resource "aws_route" "srvr1_to_srvr2" {
  route_table_id            = module.srvr-1.route_table_id
  destination_cidr_block    = module.srvr-2.vpc_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.srvr1_to_srvr2.id
}

resource "aws_route" "srvr2_to_srvr1" {
  route_table_id            = module.srvr-2.route_table_id
  destination_cidr_block    = module.srvr-1.vpc_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.srvr1_to_srvr2.id
}