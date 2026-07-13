---
name: backstage-catalog
description: Create and manage OpenText Backstage Software Catalog entities — components, APIs, systems, domains, groups, users, resources, and locations. Use when creating or updating catalog-info.yaml files, modeling software architecture, setting up entity ownership, or working with catalog entity relationships and annotations.
---

# Backstage Catalog

Master skill for the OpenText Backstage Software Catalog. The Backstage catalog is a centralized
system that keeps track of ownership and metadata for all software within the OpenText ecosystem.

## Overview

The Backstage Software Catalog is built around metadata YAML files (`catalog-info.yaml`) stored
together with source code, which are harvested and visualized in Backstage. The catalog enables
teams to:

- Manage and maintain their software with a uniform view across services, libraries, websites, and
  more
- Discover all software in the organization and understand who owns it
- Model relationships between components, systems, APIs, and infrastructure

## Use This Skill When

- Creating or updating `catalog-info.yaml` files for your projects
- Understanding how to structure catalog entities
- Modeling software architecture in the catalog
- Working with entity relationships and dependencies
- Setting up domains, systems, and components
- Adding OpenText well-known attributes to catalog entities

## Subskills

This skill includes specialized subskills for each entity type:

- **[Components](./entities/components/SKILL.md)**:
  Software units with distinct artifacts (services, libraries, websites)
- **[APIs](./entities/apis/SKILL.md)**:
  Interfaces exposed by components (OpenAPI, AsyncAPI, GraphQL, gRPC)
- **[Systems](./entities/systems/SKILL.md)**:
  Collections of components and resources that form a larger application
- **[Domains](./entities/domains/SKILL.md)**:
  Groups of systems sharing terminology and business purpose
- **[Groups & Users](./entities/groups-and-users/SKILL.md)**:
  Organizational entities and team membership
- **[Resources](./entities/resources/SKILL.md)**:
  Infrastructure needed by systems (clusters, databases, servers)
- **[Locations](./entities/locations/SKILL.md)**:
  References to files or endpoints that contain catalog entities
- **[Advanced Concepts](./entities/advanced/SKILL.md)**:
  Entity references, relationships, and annotations

## Quick Start

### Adding a Component

Create a `catalog-info.yaml` in your project root:

```yaml
apiVersion: backstage.io/v1alpha1
kind: Component
metadata:
  namespace: your-team
  name: your-component-name
  title: Human Readable Name
  description: Brief description of what this component does
  annotations:
    opentext.com/repofile-readme: README.md
    opentext.com/repofile-changelog: CHANGELOG.md
spec:
  type: backend # or: frontend, website, library
  owner: group:pht-team/your-team
  domain: product/your-product-id
  lifecycle: production # or: development, prerelease, experimental, sunset, deprecated
```

### Key Concepts

- **Namespace** - Helps avoid conflicts; typically your team name
- **Owner** - The team responsible for the entity (required)
- **Domain** - The product or business unit this entity belongs to
- **Type** - Categorizes the entity (e.g., backend service, frontend app)
- **Lifecycle** - Current stage of the entity (production, development, etc.)
- **Annotations** - Metadata used by Backstage plugins and OpenText-specific integrations

### OpenText Well-Known Attributes

OpenText extends standard Backstage annotations with a small set of well-known attributes that are
especially useful in `catalog-info.yaml` files:

- `opentext.com/repofile-readme` - Relative path to the entity README
- `opentext.com/repofile-changelog` - Relative path to the entity changelog
- `pht.opentext.com/pht-sync-id` - Sync ID that links the entity to a PHT Product

Example:

```yaml
metadata:
  annotations:
    opentext.com/repofile-readme: README.md
    opentext.com/repofile-changelog: CHANGELOG.md
    pht.opentext.com/pht-sync-id: b705ad7d-94ad-46e0-8342-03600718416a
```

Use the README and changelog annotations when those files live next to, or beneath, the
`catalog-info.yaml` file. Their values are repo-relative paths from the location of the
`catalog-info.yaml` file itself.

## Key Resources

- Main Getting Started Guide: `/docs/catalog/getting-started.md`
- Entity Descriptor Format: `/docs/catalog/entities/descriptor-format.md`
- Well-Known Annotations: `/docs/catalog/entities/well-known-annotations.md`
- Well-Known Kinds: `/docs/catalog/entities/well-known-kinds.md`
- Entity References: `/docs/catalog/entities/entity-references.md`
- Entity Relations: `/docs/catalog/entities/well-known-relations.md`

## Discover an Entity

Find entity references you need:

- **Find PHT Teams**:
  [Search Groups](https://backstage.opentext.com/catalog?filters%5Bkind%5D=group)
- **Find Products**:
  [Search Domains](https://backstage.opentext.com/catalog?filters%5Bkind%5D=domain&filters%5Btype%5D=product)
- **Browse Full Catalog**:
  [Catalog Search](https://backstage.opentext.com/catalog)

## Tips

- All `catalog-info.yaml` files in repo root directories are automatically scanned and imported
- Use entity references in the format `kind:namespace/name` to link between entities
- Support contacts can be email addresses, URLs, or entity references
- Tags help with discoverability and categorization
- Dependencies between components are automatically visualized
- OpenText README and changelog annotations should point to paths relative to `catalog-info.yaml`
