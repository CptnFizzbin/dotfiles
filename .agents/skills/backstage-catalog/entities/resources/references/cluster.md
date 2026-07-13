# Cluster Resource Reference

Complete reference documentation for Cluster resource type specifications.

## Entity Declaration

| Field        | Value                   |
| ------------ | ----------------------- |
| `apiVersion` | `backstage.io/v1alpha1` |
| `kind`       | `Resource`              |
| `spec.type`  | `cluster`               |

## What is a Cluster Resource?

A Cluster resource describes a Kubernetes cluster or other container orchestration cluster that can host multiple services and applications.

## Basic Structure

```yaml
apiVersion: backstage.io/v1alpha1
kind: Resource
metadata:
  namespace: infrastructure
  name: prod-cluster-1
  title: Production Kubernetes Cluster
  description: Primary production cluster hosting customer-facing services
spec:
  type: cluster
  owner: group:platform-engineering/infrastructure
  domain: product/platform
```

## Cluster-Specific Fields

Cluster resources support the following additional fields in `spec`:

### clusterType [optional]

- Type: string
- Purpose: Type of cluster platform
- Examples: `kubernetes`, `docker-swarm`, `nomad`

### clusterVersion [optional]

- Type: string
- Purpose: Version of the cluster platform
- Examples: `1.24.0`, `1.25.5`

### endpoint [optional]

- Type: string
- Purpose: API endpoint for the cluster
- Examples: `https://api.prod-1.cluster.local:6443`, `https://eks-prod.amazonaws.com`

### nodeSelector [optional]

- Type: object or array
- Purpose: Node selection criteria for workloads
- Example:

```yaml
spec:
  nodeSelector:
    zone: us-east-1a
    instance-type: compute-optimized
```

### nodes [optional]

- Type: array of node objects
- Purpose: Specifications of cluster nodes

```yaml
spec:
  nodes:
    - name: node-1
      capacity:
        cpu: '16'
        memory: '64Gi'
      labels:
        workload: general
    - name: node-2
      capacity:
        cpu: '32'
        memory: '128Gi'
      labels:
        workload: compute-intensive
```

### networkPolicy [optional]

- Type: string
- Purpose: Network policy enforcement level
- Examples: `strict`, `permissive`, `disabled`

### storageClasses [optional]

- Type: array of strings
- Purpose: Available storage classes in the cluster
- Examples: `["fast", "standard", "archive"]`

## Extended Example

```yaml
apiVersion: backstage.io/v1alpha1
kind: Resource
metadata:
  namespace: infrastructure
  name: prod-cluster-1
  title: Production Kubernetes Cluster
  description: |
    Primary production cluster hosted on AWS.
    Used for all customer-facing services.
  tags:
    - kubernetes
    - production
    - critical
  links:
    - url: https://console.prod-cluster-1.local
      title: Cluster Dashboard
      icon: dashboard
    - url: https://metrics.prod-cluster-1.local
      title: Prometheus Metrics
      icon: monitoring
spec:
  type: cluster
  owner: group:platform-engineering/infrastructure
  domain: product/platform
  clusterType: kubernetes
  clusterVersion: 1.25.5
  endpoint: https://api.prod-1.cluster.local:6443
  networkPolicy: strict
  storageClasses:
    - fast
    - standard
    - archive
  nodes:
    - name: node-1
      capacity:
        cpu: '16'
        memory: '64Gi'
      labels:
        workload: general
        zone: us-east-1a
    - name: node-2
      capacity:
        cpu: '32'
        memory: '128Gi'
      labels:
        workload: compute-intensive
        zone: us-east-1b
    - name: node-3
      capacity:
        cpu: '32'
        memory: '128Gi'
      labels:
        workload: compute-intensive
        zone: us-east-1c
```

## Related Resources

Clusters typically work with other resource types:

- **Services/Pods** - Run on clusters
- **Load Balancers** - Route traffic to clusters
- **Storage Resources** - Provide persistent storage for cluster workloads

## Tips

- Node capacity information helps with workload planning
- Storage classes indicate available persistent storage options
- Endpoint URL enables direct access to cluster management APIs
- Network policy level communicates security posture
- Node selectors help with workload scheduling and isolation
- Labels on nodes support workload affinity rules
