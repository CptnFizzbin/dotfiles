---
name: backstage-catalog-components
description: Define and document Component entities in the Backstage Software Catalog. Use when creating catalog-info.yaml entries for backend services, frontends, websites, or libraries; when specifying component type, lifecycle, owner, system, API relationships, or build artifacts.
---

# Components

Subskill for defining software components in the Backstage catalog.

## What is a Component?

A Component describes a software component—a unit of software with a distinct deployable or linkable artifact. Examples include backend services, frontend applications, websites, and libraries.

## Use This Subskill When

- Creating `catalog-info.yaml` files for services, libraries, or frontend apps
- Modeling software dependencies and relationships
- Setting up component ownership and lifecycle
- Defining component types and specifications

## Quick Example

```yaml
apiVersion: backstage.io/v1alpha1
kind: Component
metadata:
  namespace: eng-tools
  name: backstage-dev
  description: OpenText Backstage Development Environment
  tags:
    - javascript
    - backstage
    - eng-tools
spec:
  type: website
  owner: group:pht-team/backstage-eng
  system: eng-tools/backstage
  domain: product/35968b13-c250-48e8-8309-5e5759b8fbcb
  lifecycle: development
  dependsOn:
    - resource:eng-tools/bp2-bkstdev-l001.otxlab.net
    - resource:eng-tools/backstage-dev-db
    - system:eng-tools/pht
```

## Common Component Types

- `backend` - Backend service, typically exposing an API
- `frontend` - Frontend client, typically consumes the backend API
- `website` - Website combining backend and frontend
- `library` - Software library (npm module, Java library, etc.)
- `artifact` - Artifact created by a build system

## Lifecycle States

- `experimental` - Early, non-production component
- `development` - Unstable, may change at any time
- `prerelease` - Stable form but low reliability guarantees
- `production` - Established, owned, maintained component
- `sunset` - Will be deprecated in the near future
- `deprecated` - End of lifecycle, may disappear later

## Key Relationships

- `owner` - The team responsible for this component
- `system` - The larger system this component belongs to
- `domain` - The product or business unit
- `subcomponentOf` - Another component this is part of
- `providesApis` - APIs this component provides
- `consumesApis` - APIs this component consumes
- `dependsOn` - Components or resources this depends on

## Reference Documentation

See [Component Reference](./references/component.md) for complete field specifications.

## Tips

- Namespace and name must be unique together
- Owner is required and typically a PHT team
- Use entity references to link to other entities
- Tags aid in discovery and categorization
- Support contacts can be email, URL, or entity reference
