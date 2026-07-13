# Backstage Catalog Skill - Complete Index

A comprehensive skill for working with the OpenText Backstage Software Catalog. This skill provides
structured guidance and reference documentation for all entity types.

## Skill Structure

```
backstage-catalog/
├── SKILL.md                          # Main skill overview
├── entities/
│   ├── components/
│   │   ├── SKILL.md                  # Components subskill
│   │   └── references/
│   │       └── component.md          # Complete reference
│   ├── apis/
│   │   ├── SKILL.md                  # APIs subskill
│   │   └── references/
│   │       └── api.md                # Complete reference
│   ├── systems/
│   │   ├── SKILL.md                  # Systems subskill
│   │   └── references/
│   │       └── system.md             # Complete reference
│   ├── domains/
│   │   ├── SKILL.md                  # Domains subskill
│   │   └── references/
│   │       └── domain.md             # Complete reference
│   ├── groups-and-users/
│   │   ├── SKILL.md                  # Groups & Users subskill
│   │   └── references/
│   │       └── group.md              # Complete reference
│   ├── resources/
│   │   ├── SKILL.md                  # Resources subskill
│   │   └── references/
│   │       ├── resource.md           # Resource overview
│   │       ├── cluster.md            # Cluster resource type
│   │       ├── database.md           # Database resource type
│   │       ├── server.md             # Server resource type
│   │       └── service-account.md    # Service account resource type
│   ├── locations/
│   │   ├── SKILL.md                  # Locations subskill
│   │   └── references/
│   ├── advanced/
│   │   ├── SKILL.md                  # Advanced concepts subskill
│   │   └── references/
│   │       ├── entity-references.md  # How to link entities
│   │       ├── relations.md          # Relationship types
│   │       └── annotations.md        # Metadata annotations
│   └── INDEX.md                      # This file
```

## Quick Navigation

### By Use Case

**Creating a Component**
→ [Components Subskill](./components/SKILL.md)
→ [Component Reference](./components/references/component.md)

**Documenting an API**
→ [APIs Subskill](./apis/SKILL.md)
→ [API Reference](./apis/references/api.md)

**Organizing Systems**
→ [Systems Subskill](./systems/SKILL.md)
→ [System Reference](./systems/references/system.md)

**Understanding Ownership & Teams**
→ [Groups & Users Subskill](./groups-and-users/SKILL.md)
→ [Groups & Users Reference](./groups-and-users/references/group.md)

**Cataloging Infrastructure**
→ [Resources Subskill](./resources/SKILL.md)
→ [Resource Reference](./resources/references/resource.md)

**Linking Infrastructure**
→ [Clusters](./resources/references/cluster.md)
→ [Databases](./resources/references/database.md)
→ [Servers](./resources/references/server.md)
→ [Service Accounts](./resources/references/service-account.md)

**Linking Entities Together**
→ [Entity References](./advanced/references/entity-references.md)

**Understanding Relationships**
→ [Relations](./advanced/references/relations.md)

**Adding Metadata**
→ [Annotations](./advanced/references/annotations.md)

**Using OpenText Well-Known Attributes**
→ [Advanced Concepts](./advanced/SKILL.md)
→ [Annotations](./advanced/references/annotations.md)

## Reference Matrix

| Entity Type        | Subskill                                               | Full Reference                                                           |
| ------------------ | ------------------------------------------------------ | ------------------------------------------------------------------------ |
| Component          | [Components](./components/SKILL.md)           | [component.md](./components/references/component.md)            |
| API                | [APIs](./apis/SKILL.md)                       | [api.md](./apis/references/api.md)                              |
| System             | [Systems](./systems/SKILL.md)                 | [system.md](./systems/references/system.md)                     |
| Domain             | [Domains](./domains/SKILL.md)                 | [domain.md](./domains/references/domain.md)                     |
| Group              | [Groups & Users](./groups-and-users/SKILL.md) | [group.md](./groups-and-users/references/group.md)              |
| Resource (general) | [Resources](./resources/SKILL.md)             | [resource.md](./resources/references/resource.md)               |
| Cluster            |                                               | [cluster.md](./resources/references/cluster.md)                 |
| Database           |                                               | [database.md](./resources/references/database.md)               |
| Server             |                                               | [server.md](./resources/references/server.md)                   |
| Service Account    |                                               | [service-account.md](./resources/references/service-account.md) |
| Location           | [Locations](./locations/SKILL.md)             |                                                                  |

## Advanced Topics

| Topic                | Reference                                                                |
| -------------------- | ------------------------------------------------------------------------ |
| Linking entities        | [Entity References](./advanced/references/entity-references.md) |
| Relationship types      | [Relations](./advanced/references/relations.md)                 |
| Metadata annotations    | [Annotations](./advanced/references/annotations.md)             |
| OT well-known attributes | [Annotations](./advanced/references/annotations.md)            |

## Common Tasks

### Task: Create a catalog-info.yaml for a new service

1. Read: [Components Subskill](./components/SKILL.md)
2. Reference: [Component Reference](./components/references/component.md)
3. Reference: [Entity References](./advanced/references/entity-references.md) (for owner,
   system, domain)
4. Create your `catalog-info.yaml` with basic component definition
5. Add owner: `group:pht-team/your-team`
6. Add domain: Find your product domain in the catalog first
7. Optional: Link dependencies using `dependsOn`

### Task: Document an API provided by your service

1. Read: [APIs Subskill](./apis/SKILL.md)
2. Reference: [API Reference](./apis/references/api.md)
3. Add API entity to your `catalog-info.yaml`
4. Reference API definition file with `$text: ./openapi.yaml`
5. Link it to your component with `providesApis` on the component

### Task: Link infrastructure to your component

1. Read: [Resources Subskill](./resources/SKILL.md)
2. Choose resource
   type: [Cluster](./resources/references/cluster.md), [Database](./resources/references/database.md), [Server](./resources/references/server.md),
   or [Service Account](./resources/references/service-account.md)
3. Create resource entities
4. Link from component using `dependsOn: [resource:namespace/name]`

### Task: Understand relationships between entities

1. Read: [Entity References](./advanced/references/entity-references.md)
2. Read: [Relations](./advanced/references/relations.md)
3. Check your component's spec: owner, system, domain, providesApis, consumesApis, dependsOn
4. Each of these creates automatic relationships in the catalog

### Task: Add integrations to your entity

1. Read: [Annotations](./advanced/references/annotations.md)
2. Add annotations to metadata section
3. Examples: GitHub, GitLab, Slack, PagerDuty, etc.

### Task: Add OpenText well-known attributes to an entity

1. Read: [Advanced Concepts](./advanced/SKILL.md)
2. Reference: [Annotations](./advanced/references/annotations.md)
3. Add `opentext.com/repofile-readme` when the entity should expose its README
4. Add `opentext.com/repofile-changelog` when the entity should expose its changelog
5. Add `pht.opentext.com/pht-sync-id` when the entity should be linked to a PHT Product

## Entity Kind Summary

| Kind      | Purpose                          | Hierarchy Level | Reference                                                     |
| --------- | -------------------------------- | --------------- | ------------------------------------------------------------- |
| Domain    | Group of systems by product/LOB  | Level 1 (Top)   | [domain.md](./domains/references/domain.md)          |
| System    | Collection of related components | Level 2         | [system.md](./systems/references/system.md)          |
| Component | Unit of software                 | Level 3         | [component.md](./components/references/component.md) |
| API       | Interface exposed by components  | Cross-level     | [api.md](./apis/references/api.md)                   |
| Resource  | Infrastructure needed by systems | Cross-level     | [resource.md](./resources/references/resource.md)    |
| Group     | Team/organizational unit         | Org Structure   | [group.md](./groups-and-users/references/group.md)   |
| User      | Individual person                | Org Structure   | [group.md](./groups-and-users/references/group.md)   |
| Location  | Catalog entity source            | Administrative  |                                                               |

## Hierarchy Visualization

```
Domain (Product/Business Unit)
├── System (Logical grouping)
│   ├── Component (Actual software)
│   ├── Component
│   ├── API (Interfaces)
│   └── Resource (Infrastructure)
├── System
│   ├── Component
│   ├── Component
│   └── Resource

Organizational Structure (separate)
├── Group (Team/Department)
│   ├── User (Person)
│   ├── User
│   └── Subgroup
└── Group
    ├── User
    └── User
```

## Key Concepts

**Namespace** - Organizational grouping (e.g., team, product area); combined with name to create
unique entity

**Owner** - Responsible team or person (required field on most entities)

**Domain** - Product or business unit (typically pre-populated)

**Entity Reference** - Format to link entities: `kind:namespace/name`

**Relationships** - Automatically generated connections between entities based on spec fields

**Annotations** - Metadata for integrations with external systems

## Best Practices

1. **Always specify owner** - Clarifies accountability
2. **Use entity references** - Links entities into a graph
3. **Keep namespaces consistent** - Easier to navigate and maintain
4. **Document with TechDocs** - Use `backstage.io/techdocs-ref` annotation
5. **Link infrastructure** - Use resources to model operational dependencies
6. **Organize by system** - Group related components for clarity
7. **Use well-known annotations** - Enable Backstage integrations
8. **Keep catalog-info.yaml** - Check it into your repository

## Tips

- All references in catalog-info.yaml are case-sensitive
- Use abbreviated entity references within the same namespace
- Use full entity references when crossing namespaces
- Relationships are bidirectional (ownerOf ↔ ownedBy)
- The catalog UI uses these entities and relationships for navigation
- Dependencies help with impact analysis
- Support contacts are important for operational runbooks

## Related Files

The Backstage project documentation in `/docs/catalog/` contains:

- `getting-started.md` - Introduction to the catalog
- `entities/descriptor-format.md` - Detailed YAML schema
- `entities/well-known-kinds.md` - Standard entity types
- `entities/entity-references.md` - Reference format specification
- `entities/well-known-relations.md` - Standard relationships
- `entities/well-known-annotations.md` - Standard annotations
- `entities/well-known-types.md` - Standard type values

## Contact & Support

For questions about:

- Backstage in your organization → See your catalog support team
- Catalog entity definitions → Check [Main SKILL.md](./SKILL.md)
- Specific entity types → Refer to the appropriate subskill
- Technical details → Check the reference documents
