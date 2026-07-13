---
name: backstage-catalog-systems
description: Define System entities in the Backstage Software Catalog to group related components and resources. Use when organizing multiple components into a logical unit, defining system type and ownership, or linking a system to a domain.
---

# Systems

Subskill for defining systems in the Backstage catalog.

## What is a System?

A System is a collection of resources and components that work together to provide functionality. Systems represent an abstraction level that gives consumers insights into exposed features without needing detailed visibility into all components. A system may expose or consume one or several APIs.

## Use This Subskill When

- Grouping related components and resources into larger units
- Abstracting system-level concerns above individual components
- Defining system ownership and type
- Organizing components by product or business area

## Quick Example

```yaml
apiVersion: backstage.io/v1alpha1
kind: System
metadata:
  namespace: eng-tools
  name: backstage
  description: OpenText Backstage - The Engineering Portal
spec:
  type: application
  owner: group:pht-team/backstage-eng
  domain: product/35968b13-c250-48e8-8309-5e5759b8fbcb
```

## System Types

- `application` - A system that primarily provides a web application
- `service` - A system that primarily provides data to other systems via an API
- `reporting` - A system that primarily generates reports

## Key Relationships

- `owner` - The team responsible for this system (required)
- `domain` - The product or business unit this system belongs to
- Components belong to systems via `spec.system` reference

## System Hierarchy

Systems provide an organizational level between components and domains:

```
Domain (Product/Business Unit)
  └── System (Logical grouping of related components)
        ├── Component (Backend service)
        ├── Component (Frontend app)
        └── Resource (Database)
```

## Reference Documentation

See [System Reference](./references/system.md) for complete field specifications.

## Tips

- Systems are optional; simple projects may only need components
- Use systems to group logically related components
- A component can only belong to one system
- Multiple systems can belong to one domain
- Systems help consumers understand your software at a higher level
- Consider creating a system for each major product feature or capability
