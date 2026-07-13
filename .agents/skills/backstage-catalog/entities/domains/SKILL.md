---
name: backstage-catalog-domains
description: Define Domain entities in the Backstage Software Catalog representing PHT products, lines of business, or business units. Use when grouping systems under a shared business context, referencing a product domain in a component or system, or navigating the PHT organizational hierarchy.
---

# Domains

Subskill for defining domains in the Backstage catalog.

## What is a Domain?

A Domain groups a collection of systems that share terminology, domain models, business purpose, or documentation—forming a bounded context. Domains represent the highest organizational level in the catalog hierarchy. All OpenText PHT products, lines of business, and business units are represented as domains.

## Use This Subskill When

- Organizing systems into higher-level business units
- Grouping related systems around shared terminology or business areas
- Mapping products to the catalog
- Understanding organizational structure

## Quick Example

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

## Domain Types

- `product` - A PHT product
- `line-of-business` - A line of business or business unit
- `business-unit` - A broader organizational unit

## Key Relationships

- `owner` - The team or manager responsible for the domain (required)
- `lineOfBusiness` - Reference to parent line of business (if applicable)
- `teams` - Teams that contribute to this domain
- Systems belong to domains via `spec.domain` reference

## Domain Hierarchy

Domains form the top organizational level:

```
Domain (Product or Business Unit)
  ├── System 1
  │   ├── Component
  │   └── Resource
  └── System 2
      ├── Component
      └── Resource
```

## Reference Documentation

See [Domain Reference](./references/domain.md) for complete field specifications.

## Tips

- Domains are typically pre-populated from the enterprise organization structure
- Most developers work within existing domains; creating new ones is rare
- Namespace and name combination must be unique
- Use descriptive titles for clarity in the catalog
- Line of business references help maintain organizational hierarchy
