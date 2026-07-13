# Resource Reference

Complete reference documentation for the Resource entity kind.

## Entity Declaration

| Field        | Value                   |
| ------------ | ----------------------- |
| `apiVersion` | `backstage.io/v1alpha1` |
| `kind`       | `Resource`              |

## What is a Resource?

A Resource describes the infrastructure that a system needs to operate—such as databases, Kubernetes clusters, servers, service accounts, message queues, storage buckets, and other operational dependencies. Modeling resources alongside components allows visualization of your resource footprint and enables tooling around infrastructure.

## Basic Structure

```yaml
apiVersion: backstage.io/v1alpha1
kind: Resource
metadata:
  namespace: eng-tools
  name: backstage-prod-db
  title: Backstage Production Database
  description: Primary PostgreSQL database for Backstage
  tags:
    - postgresql
    - production
  links:
    - url: https://db-console.otxlab.net
      title: Database Console
      icon: database
spec:
  type: database
  owner: group:pht-team/backstage-eng
  system: eng-tools/backstage
  domain: product/35968b13-c250-48e8-8309-5e5759b8fbcb
```

## Metadata Section

### namespace [required]

- Type: string
- Purpose: Organizational grouping
- Ensures combined uniqueness with `name`
- Example: `eng-tools`, `platform`, `infrastructure`

### name [required]

- Type: string
- Purpose: Unique identifier within the namespace
- Often matches infrastructure naming
- Example: `backstage-prod-db`, `kubernetes-prod-1`

### title [optional]

- Type: string
- Purpose: Human-readable display name
- Example: `Backstage Production Database`

### description [optional]

- Type: string
- Purpose: Description of the resource
- Supports markdown

### tags [optional]

- Type: array of strings
- Purpose: Keywords for categorization
- Example: `["postgresql", "production", "critical"]`

### links [optional]

- Type: array of link objects
- Purpose: Important URLs for the resource

```yaml
links:
  - url: https://db-console.otxlab.net
    title: Database Console
    icon: database
  - url: https://monitoring.otxlab.net/dashboard/db
    title: Monitoring Dashboard
    icon: dashboard
```

## Spec Section

### type [required]

The category of resource.

**Well-known values:**

- `cluster` - Kubernetes cluster (see [Cluster Reference](./cluster.md))
- `database` - Database system (see [Database Reference](./database.md))
- `server` - Physical/virtual server (see [Server Reference](./server.md))
- `service-account` - System authentication account (see [Service Account Reference](./service-account.md))

Each type has additional type-specific fields documented in its own reference.

### owner [required]

Entity reference to the resource owner.

- Type: entity reference string
- Typically a Group (infrastructure or ops team)
- Example: `group:pht-team/backstage-eng`
- Generated relationship: `ownerOf` (reverse `ownedBy`)

### system [optional]

Entity reference to the system that depends on this resource.

- Type: entity reference string
- Example: `eng-tools/backstage`
- Generated relationship: `partOf` (reverse `hasPart`)

### domain [optional]

Entity reference to the domain (product or business unit).

- Type: entity reference string
- Example: `product/35968b13-c250-48e8-8309-5e5759b8fbcb`
- Generated relationship: `partOf` (reverse `hasPart`)

### supportContact [optional]

Support information for the resource.

**String formats (auto-detected):**

- Email: `infrastructure-support@opentext.com`
- URL: `https://support.opentext.com`
- Entity reference: `user:opentext/ops-lead`

**Object format (explicit):**

```yaml
spec:
  supportContact:
    email: infrastructure-support@opentext.com
    url: https://wiki.opentext.com/databases
    entity: user:opentext/ops-lead
```

## Resource Type-Specific References

### Cluster Resources

For Kubernetes or other clusters, see [Cluster Reference](./cluster.md) for:

- Node specifications
- Capacity information
- Network configuration

### Database Resources

For databases, see [Database Reference](./database.md) for:

- Database engine type (PostgreSQL, MySQL, etc.)
- Connection endpoints
- Capacity and performance specs

### Server Resources

For servers/VMs, see [Server Reference](./server.md) for:

- DNS configuration
- IP addresses
- Hardware specifications

### Service Account Resources

For authentication accounts, see [Service Account Reference](./service-account.md) for:

- Account type (service principal, robot account)
- Credential management
- Permissions and scope

## Common Relationships

| Relationship | Generated From           | Target Kind | Notes                              |
| ------------ | ------------------------ | ----------- | ---------------------------------- |
| ownerOf      | spec.owner               | Resource    | Team owns this resource            |
| partOf       | spec.system              | System      | Resource belongs to system         |
| partOf       | spec.domain              | Domain      | Resource belongs to domain         |
| dependencyOf | Component spec.dependsOn | Component   | Component depends on this resource |

## Using Resource Dependencies

Components reference resources through `dependsOn`:

```yaml
# In a Component entity
spec:
  dependsOn:
    - resource:eng-tools/backstage-prod-db
    - resource:infrastructure/load-balancer-1
    - resource:infrastructure/cache-cluster
```

This creates visualization of infrastructure dependencies.

## Example: Multi-Resource Setup

```yaml
# Main database
apiVersion: backstage.io/v1alpha1
kind: Resource
metadata:
  namespace: eng-tools
  name: backstage-db
spec:
  type: database
  owner: group:pht-team/backstage-eng
  system: eng-tools/backstage

---
# Cache
apiVersion: backstage.io/v1alpha1
kind: Resource
metadata:
  namespace: eng-tools
  name: backstage-cache
spec:
  type: service-account
  owner: group:pht-team/backstage-eng
  system: eng-tools/backstage

---
# Kubernetes cluster
apiVersion: backstage.io/v1alpha1
kind: Resource
metadata:
  namespace: infrastructure
  name: prod-cluster-1
spec:
  type: cluster
  owner: group:platform-engineering/infrastructure
  domain: product/platform

---
# Component that uses these resources
apiVersion: backstage.io/v1alpha1
kind: Component
metadata:
  namespace: eng-tools
  name: backstage-backend
spec:
  type: backend
  owner: group:pht-team/backstage-eng
  system: eng-tools/backstage
  dependsOn:
    - resource:eng-tools/backstage-db
    - resource:eng-tools/backstage-cache
    - resource:infrastructure/prod-cluster-1
```

## Tips

- Resources help visualize infrastructure footprint
- Use well-known types to enable specialized tooling
- Type-specific fields provide detailed infrastructure information
- Dependencies from components to resources are automatically visualized
- Tags help with filtering and categorization
- Support contact information aids operational troubleshooting
- Namespace typically groups resources by team or infrastructure area
