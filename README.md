# Prerequisites
Install
1. AWS CLI v2
2. eskctl
2. Terraform
3. Helm 3

## Setup

1. Deploy EKS cluster using eksctl;
2. Deploy MSK cluster and associated resources using Terraform
3. Create VPC Peering relationship between MSK and EKS VPCs;
4. Update routing tables for both VPCs and associated subnets to route traffic to CIDR range of opposite VPC;
5. Update default VPC security groups to allow traffic;
6. Create IAM Roles for Service Accounts (IRSA) - allows access to MSK from EKS
7. Deploy Tomcat-based Kafka client container using Helm
8. Configure Kafka client container
9. Deploy Conductor
9. Deploy Redis 
10. Deploy Envoy
11. Deploy Kafka Workers
12. Deploy Mothership
13. Deploy Monitor

## Deploy namespace 
cd helm/namespace.yaml
kubectl apply -f namespace

## Deploy Conductor
cd helm/conductor/templates
kubectl apply -f mongodb.yaml
kubectl apply -f conductor.yaml

## Deploy  Redis
cd redis
kubectl apply -f pv.yaml
kubectl apply -f service.yaml
kubectl apply -f deployment.yaml

## Deploy Envoy
cd enovy
kubectl apply -f service.yaml
kubectl apply -f deployment.yaml


## Deploy Kafka Workers
cd helm/kafka-workers
kubectl apply -f kafka-workers-deployment.yaml


## Deploy mothership 
kubectl apply -f service.yaml
kubectl apply -f deployment.yaml

## Deploy Monitor - !!!!! on monitor cluster !!!!
cd helm/monitor/templates
kubectl apply -f deployment.yaml
kubectl apply -f threatoptix-monitor-daemonset.yaml

## Helpful AWS CLI Commands for Amazon MSK

```shell
aws kafka list-clusters

aws kafka list-clusters --query 'ClusterInfoList[*].ClusterArn'

aws kafka describe-cluster --cluster-arn <YOUR_ARN_HERE>

# assuming cluster 0 (first or single cluster)
aws kafka describe-cluster --cluster-arn \
  $(aws kafka list-clusters --query 'ClusterInfoList[0].ClusterArn' --output text)
```

## Terraform

```shell
cd ./tf-msk

terraform validate

terraform plan

terraform apply
```