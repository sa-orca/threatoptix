resource "aws_msk_configuration" "mks_config" {
  kafka_versions = [
    "2.6.1"
  ]
  name = "to-mks-config"

  server_properties = <<PROPERTIES
auto.create.topics.enable = true
delete.topic.enable = true
PROPERTIES
}

resource "aws_msk_cluster" "msk_cluster" {
  cluster_name           = var.cluster_name
  kafka_version          = "2.8.0"
  number_of_broker_nodes = 3
  configuration_info {
    arn      = aws_msk_configuration.mks_config.arn
    revision = 1
  }

  broker_node_group_info {
    instance_type   = "kafka.m5.large"
    ebs_volume_size = 120
    client_subnets = [
      aws_subnet.subnet_az1.id,
      aws_subnet.subnet_az2.id,
      aws_subnet.subnet_az3.id,
    ]
    security_groups = [
    aws_security_group.sg.id]
  }

  encryption_info {
    encryption_at_rest_kms_key_arn = aws_kms_key.kms.arn
  }

  tags = {
    Name = "Threat Optics MSK Cluster"
  }
}

resource "aws_ssm_parameter" "param_mks_access_none_zoo" {
  name  = "/msk/access-none/zookeeper"
  type  = "StringList"
  value = aws_msk_cluster.msk_cluster.zookeeper_connect_string
}

resource "aws_ssm_parameter" "param_mks_access_none_brokers" {
  name  = "/msk/access-none/brokers"
  type  = "StringList"
  value = aws_msk_cluster.msk_cluster.bootstrap_brokers_tls
}