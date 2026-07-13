# Domain Reference

Complete reference documentation for the Domain entity kind.

## Entity Declaration

| Field        | Value                   |
| ------------ | ----------------------- |
| `apiVersion` | `backstage.io/v1alpha1` |
| `kind`       | `Domain`                |

## What is a Domain?

A Domain groups a collection of systems that share terminology, domain models, business purpose, or documentation—forming a bounded context. Domains represent the highest organizational level in the catalog hierarchy. All OpenText PHT products, lines of business, and business units are represented as domains.

## Basic Structure

```yaml
apiVersion: backstage.io/v1alpha1
kind: Domain
metadata:
  namespace: product
  name: 35968b13-c250-48e8-8309-5e5759b8fbcb
  title: Backstage for Engineering
  description: The engineering platform providing developer tools and services
spec:
  type: product
  owner: group:pht-team/backstage-eng
  lineOfBusiness: domain:line-of-business/ancillary-services
  teams:
    - group:pht-team/backstage-eng
    - group:pht-team/common-engineering-tools
```

## Metadata Section

### namespace [required]

- Type: string
- Purpose: Organizational grouping
- Ensures combined uniqueness with `name`
- Typically: `product`, `line-of-business`, `business-unit`

### name [required]

- Type: string
- Purpose: Unique identifier within the namespace
- For products, often a UUID to maintain stability
- Example: `35968b13-c250-48e8-8309-5e5759b8fbcb`

### title [required]

- Type: string
- Purpose: Human-readable display name
- Shown in UI and listings
- Example: `Backstage for Engineering`

### description [optional]

- Type: string
- Purpose: Description of the domain's purpose and scope
- Supports markdown

### tags [optional]

- Type: array of strings
- Purpose: Keywords for categorization
- Example: `["platform", "engineering-tools"]`

### links [optional]

- Type: array of link objects
- Purpose: Important URLs for the domain

```yaml
links:
  - url: https://backstage.opentext.com
    title: Backstage Platform
    icon: dashboard
  - url: https://wiki.opentext.com/engineering
    title: Engineering Wiki
    icon: docs
```

## Spec Section

### type [required]

The category or type of domain.

**Well-known values:**

- `product` - A PHT product
- `line-of-business` - A line of business or business unit
- `business-unit` - A broader organizational unit

Custom types are accepted for organizational flexibility.

### owner [required]

Entity reference to the domain owner.

- Type: entity reference string
- Typically a Group (team lead or product team)
- Example: `group:pht-team/backstage-eng`
- Generated relationship: `ownerOf` (reverse `ownedBy`)

### lineOfBusiness [optional]

Entity reference to the parent line of business.

- Type: entity reference string (Domain)
- Indicates organizational hierarchy
- Example: `domain:line-of-business/ancillary-services`
- Generated relationship: `partOf` (and reverse `hasPart`)

### teams [optional]

Array of entity references to groups contributing to the domain.

```yaml
spec:
  teams:
    - group:pht-team/backstage-eng
    - group:pht-team/common-engineering-tools
    - group:pht-team/devx
```

These teams have vested interest or responsibility in the domain.

### manager [optional]

Entity reference to the domain manager or executive sponsor.

- Type: entity reference string
- Typically a User
- Example: `user:opentext/jsmith`
- The executive or manager responsible for the domain

### syncId [optional]

- Type: string
- Purpose: Identifier used for synchronization with external systems
- Used when domains are synced from enterprise systems

## Domain Hierarchy

Domains form the top organizational level:

```
Line of Business
  └── Domain (Product)
        ├── System 1
        │   ├── Component
        │   └── Resource
        └── System 2
            ├── Component
            └── Resource
```

## Relationships

Systems belong to domains through their optional `spec.domain` reference:

```yaml
# In a System entity
spec:
  domain: product/35968b13-c250-48e8-8309-5e5759b8fbcb
```

## Common Relationships

| Relationship | Generated From      | Target Kind | Notes                         |
| ------------ | ------------------- | ----------- | ----------------------------- |
| ownerOf      | spec.owner          | Domain      | Team/user owns this domain    |
| partOf       | spec.lineOfBusiness | Domain      | Domain belongs to LOB         |
| hasPart      | System spec.domain  | System      | Domain contains these systems |

## Typical Domain Creation Process

Most domains are pre-populated from the enterprise organization structure:

1. **Pre-populated** - Domains typically come from enterprise systems (LDAP, HR systems, etc.)
2. **Read-only** - Most developers don't create domains; they reference existing ones
3. **Organizational alignment** - Domains should match the actual product/LOB structure

## Example: Product Domain

```yaml
apiVersion: backstage.io/v1alpha1
kind: Domain
metadata:
  namespace: product
  name: 35968b13-c250-48e8-8309-5e5759b8fbcb
  title: Backstage for Engineering
  description: |
    The engineering platform providing developers with tools,
    services, and documentation to manage and discover software.
spec:
  type: product
  owner: group:pht-team/backstage-eng
  lineOfBusiness: domain:line-of-business/ancillary-services
  teams:
    - group:pht-team/backstage-eng
    - group:pht-team/platform-engineering
    - group:pht-team/developer-experience
```

## Tips

- Most developers reference existing domains rather than creating new ones
- Check the Backstage catalog for available domains before creating components
- Namespace and name combination must be unique
- Product domains typically use UUIDs for stable identification
- Line of Business references create organizational hierarchy
- Teams list shows which groups contribute to this domain
- Manager or executive sponsor helps with governance
