resource "aws_iam_role" "eks_kafka_app_oidc_role" {
  name = "EKSKafkaTOAppRole"

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        Effect : "Allow",
        Principal : {
          "Federated" : var.oidc_arn
        },
        Action : "sts:AssumeRoleWithWebIdentity",
        Condition : {
          "StringEquals" : {
            "${var.oidc_id}" : "system:serviceaccount:${var.eks_namespace}:kafka-to-app-sasl-scram-serviceaccount"
          }
        }
      },
      {
        Effect : "Allow",
        Principal : {
          "Service" : "ec2.amazonaws.com"
        },
        Action : "sts:AssumeRole",
        Condition : {}
      }
    ]
  })

  tags = {
    Name = "EKS Kafka TO App OIDC Role"
  }
}

resource "aws_iam_role_policy_attachment" "eks_kafka_oidc_role_attach" {
  role       = aws_iam_role.eks_kafka_app_oidc_role.name
  policy_arn = aws_iam_policy.kafka_to_app_policy.arn
}

resource "aws_iam_role" "eks_kafka_client_msk_oidc_role" {
  name = "EKSKafkaClientMSKRole"

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        Effect : "Allow",
        Principal : {
          "Federated" : var.oidc_arn
        },
        Action : "sts:AssumeRoleWithWebIdentity",
        Condition : {
          "StringEquals" : {
            "${var.oidc_id}" : "system:serviceaccount:${var.eks_namespace}:kafka-client-msk-sasl-scram-serviceaccount"
          }
        }
      },
      {
        Effect : "Allow",
        Principal : {
          "Service" : "ec2.amazonaws.com"
        },
        Action : "sts:AssumeRole",
        Condition : {}
      }
    ]
  })

  tags = {
    Name = "EKS Kafka Client MSK OIDC Role"
  }
}

resource "aws_iam_role_policy_attachment" "kafka_client_msk_policy_attach" {
  role       = aws_iam_role.eks_kafka_client_msk_oidc_role.name
  policy_arn = aws_iam_policy.kafka_client_msk_policy.arn
}
