---
name: backstage-catalog-resources
description: Define Resource entities in the Backstage Software Catalog representing infrastructure a system depends on. Use when cataloging Kubernetes clusters, databases, servers, or service accounts; when linking infrastructure to components via dependsOn; or when documenting resource ownership and type-specific attributes.
---

# Resources

Subskill for defining infrastructure resources in the Backstage catalog.

## What is a Resource?

A Resource describes the infrastructure that a system needs to operate—databases, clusters, servers, message queues, storage buckets, service accounts, and other operational dependencies. Modeling resources alongside components allows visualization of your resource footprint and enables tooling around infrastructure.

## Use This Subskill When

- Cataloging databases, clusters, and servers
- Tracking infrastructure dependencies
- Defining infrastructure ownership
- Setting up service accounts and credentials
- Understanding system deployment requirements

## Quick Example

```yaml
apiVersion: backstage.io/v1alpha1
kind: Resource
metadata:
  namespace: eng-tools
  name: backstage-prod-db
  title: Backstage Production Database
  description: Primary PostgreSQL database for Backstage
spec:
  type: database
  owner: group:pht-team/backstage-eng
  system: eng-tools/backstage
  domain: product/35968b13-c250-48e8-8309-5e5759b8fbcb
```

## Resource Types

### Core Types

- **`cluster`** - Kubernetes cluster hosting multiple services
- **`database`** - Postgres, MySQL, or other database
- **`server`** - Physical server, VM, or host computer
- **`service-account`** - Account for system-to-system communication

Each type has its own reference documentation with specific fields.

## Key Relationships

- `owner` - The team responsible for this resource (required)
- `system` - The system that depends on this resource
- `domain` - The product or business unit
- Components reference resources via `spec.dependsOn`

## Resource Subtypes

Click into the specific reference for detailed documentation:

- **[Cluster Resources](./references/cluster.md)** - Kubernetes clusters with node specs
- **[Database Resources](./references/database.md)** - Databases with connection info
- **[Server Resources](./references/server.md)** - Servers with DNS and IP info
- **[Service Account Resources](./references/service-account.md)** - Authentication accounts

## Reference Documentation

See [Resource Reference](./references/resource.md) for complete field specifications.

## Tips

- Resources help visualize infrastructure dependencies
- Use resource types to enable specialized tooling
- Service accounts model authentication for system-to-system communication
- DNS information for servers helps with service discovery
- Database connection information aids operational troubleshooting
- Tags help with filtering and categorization
