---
name: backstage-catalog-advanced
description: Master advanced Backstage catalog concepts including entity references, well-known relationships, annotations, and descriptor substitutions. Use when linking entities across namespaces, adding integration annotations (GitHub, GitLab, OpenText, PHT, Artifactory), loading external definitions via $text/$json/$yaml, or understanding how catalog relationships are generated.
---

# Advanced Concepts

Subskill for advanced Backstage catalog features: entity references, relationships, annotations, and substitutions.

## What Are Advanced Concepts?

Beyond basic entity definitions, the Backstage catalog supports sophisticated linking between entities through references and relationships, customization through annotations, and dynamic content through substitutions.

## Use This Subskill When

- Linking entities across namespaces
- Creating relationships between different entity types
- Using well-known annotations for specialized integrations
- Loading external files into catalog entities
- Understanding entity resolution and references

## Entity References

Entity references link one entity to another using a canonical format:

```
kind:namespace/name
```

Examples:

- `group:pht-team/backstage-eng` - The Backstage engineering team
- `component:eng-tools/backstage-dev` - The Backstage dev component
- `domain:product/35968b13-c250-48e8-8309-5e5759b8fbcb` - A product domain

## Basic Syntax

- `kind` - Entity kind (Component, API, System, Domain, Group, etc.)
- `namespace` - Organizational grouping (e.g., team name, product area)
- `name` - Unique identifier within that namespace

### Default Namespace

If you omit the namespace, the default is the same as the referencing entity:

```yaml
spec:
  owner: backstage-eng # Expands to: group:pht-team/backstage-eng
```

## Entity Relationships

Well-known relationships connect entities:

### Ownership

- `ownerOf` / `ownedBy` - Team or user owns a component, API, or system

### Composition

- `partOf` / `hasPart` - Component belongs to system; system belongs to domain
- `childOf` / `parentOf` - Group hierarchy

### Dependencies

- `dependsOn` / `dependencyOf` - Component depends on another component or resource
- `apiProvidedBy` / `providesApi` - Component provides an API
- `apiConsumedBy` / `consumesApi` - Component consumes an API

## Well-Known Annotations

Annotations add metadata and enable integrations:

```yaml
metadata:
  annotations:
    backstage.io/techdocs-ref: dir:.
    github.com/project-slug: org/repo
    backstage.io/view-url: https://...
```

Common annotations:

- `backstage.io/techdocs-ref` - TechDocs documentation location
- `github.com/project-slug` - GitHub repository reference
- `backstage.io/view-url` - Custom view URL
- `artifactory.com/project-key` - Artifactory integration

OpenText-specific well-known attributes:

- `opentext.com/repofile-readme` - Relative path to the README associated with the entity
- `opentext.com/repofile-changelog` - Relative path to the changelog associated with the entity
- `pht.opentext.com/pht-sync-id` - PHT SyncID that links the entity to a PHT Product

```yaml
metadata:
  annotations:
    opentext.com/repofile-readme: README.md
    opentext.com/repofile-changelog: CHANGELOG.md
    pht.opentext.com/pht-sync-id: b705ad7d-94ad-46e0-8342-03600718416a
```

See [Well-Known Annotations Reference](./references/annotations.md) for complete list.

## Entity Substitutions

Substitutions load external content into catalog entities:

```yaml
spec:
  definition:
    $text: ./openapi.yaml
```

This loads the OpenAPI definition from an external file into the entity.

## Complete Reference Documentation

- [Entity References](./references/entity-references.md)
- [Well-Known Relations](./references/relations.md)
- [Well-Known Annotations](./references/annotations.md)
- [Entity Substitutions](./references/substitutions.md)

## Tips

- Entity references are case-sensitive
- Default namespace makes references more concise within an organization unit
- Relationships are automatically inferred from entity specifications
- Annotations enable Backstage plugins and integrations
- Use entity substitutions to keep `catalog-info.yaml` files clean and maintainable
- OpenText repo file annotations use paths relative to the `catalog-info.yaml` location
