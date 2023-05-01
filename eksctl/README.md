# Instructions

# Create Kafka Workers Cluster

```shell
export AWS_ACCOUNT=$(aws sts get-caller-identity --output text --query 'Account')
export EKS_REGION="us-east-1"
export CLUSTER_NAME="eks-to-kafka-workers"

eksctl create cluster -f ./workers_cluster.yaml
```

# Create BE Cluster

```shell
export AWS_ACCOUNT=$(aws sts get-caller-identity --output text --query 'Account')
export EKS_REGION="us-east-1"
export CLUSTER_NAME="eks-to-be"

eksctl create cluster -f ./to_be_cluster.yaml
```

# Create Monitor Cluster

```shell
export AWS_ACCOUNT=$(aws sts get-caller-identity --output text --query 'Account')
export EKS_REGION="us-east-1"
export CLUSTER_NAME="eks-to-monitor"

eksctl create cluster -f ./monitor_cluster.yaml
```

## Delete Cluster

```shell
eksctl delete cluster --region=us-east-1 --name=$CLUSTER_NAME
```