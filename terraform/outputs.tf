########################
# outputs.tf
########################

# --- Individual instance outputs ---
output "web_server_id" {
  value = aws_instance.web_server.id
}

output "web_server_private_ip" {
  value = aws_instance.web_server.private_ip
}

output "web_server_private_dns" {
  value = aws_instance.web_server.private_dns
}

output "web_server_public_ip" {
  value = aws_instance.web_server.public_ip
}

output "web_server_public_dns" {
  value = aws_instance.web_server.public_dns
}

output "web_server_availability_zone" {
  value = aws_instance.web_server.availability_zone
}

output "web_server_tags" {
  value = aws_instance.web_server.tags
}

# --- app instance ---
output "app_server_id" {
  value = aws_instance.app_server.id
}

output "app_server_private_ip" {
  value = aws_instance.app_server.private_ip
}

output "app_server_public_ip" {
  value = aws_instance.app_server.public_ip
}

output "app_server_tags" {
  value = aws_instance.app_server.tags
}

# --- db instance ---
output "db_server_id" {
  value = aws_instance.db_server.id
}

output "db_server_private_ip" {
  value = aws_instance.db_server.private_ip
}

output "db_server_public_ip" {
  value = aws_instance.db_server.public_ip
}

output "db_server_tags" {
  value = aws_instance.db_server.tags
}

# --- aggregated lists / maps (handy for automation) ---
output "all_instance_ids" {
  value = [
    aws_instance.web_server.id,
    aws_instance.app_server.id,
    aws_instance.db_server.id
  ]
}

output "all_private_ips" {
  value = [
    aws_instance.web_server.private_ip,
    aws_instance.app_server.private_ip,
    aws_instance.db_server.private_ip
  ]
}

output "instances_map" {
  value = {
    web  = aws_instance.web_server.id,
    app  = aws_instance.app_server.id,
    db   = aws_instance.db_server.id
  }
}

# --- Elastic IPs (one per instance) ---
output "web_server_eip_public_ip" {
  value = aws_eip.web_server_eip.public_ip
}

output "app_server_eip_public_ip" {
  value = aws_eip.app_server_eip.public_ip
}

# DB EIP only if you kept it — if you removed the db EIP, delete this block
output "db_server_eip_public_ip" {
  value = aws_eip.db_server_eip.public_ip
}
