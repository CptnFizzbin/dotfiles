# Entity References

Complete reference documentation for entity references in the Backstage catalog.

## What is an Entity Reference?

An entity reference is a canonical way to uniquely identify and link to a catalog entity. Entity references enable cross-linking between entities, creating the relationship graph that powers the catalog.

## Reference Format

```
kind:namespace/name
```

### Components

- **kind** - The entity kind (Component, API, System, Domain, Group, User, Resource, Location)
- **namespace** - Organizational grouping (e.g., team name, product area)
- **name** - Unique identifier within that namespace

### Examples

```
component:eng-tools/backstage-dev
api:eng-tools/backstage-api
system:eng-tools/backstage
domain:product/35968b13-c250-48e8-8309-5e5759b8fbcb
group:pht-team/backstage-eng
user:opentext/dserres
resource:eng-tools/backstage-db
resource:infrastructure/prod-cluster-1
```

## Full Reference vs. Default Namespace

### Full Reference

When referencing an entity outside your namespace, use the complete reference:

```yaml
spec:
  owner: group:pht-team/backstage-eng
  system: eng-tools/backstage
  domain: product/35968b13-c250-48e8-8309-5e5759b8fbcb
  dependsOn:
    - resource:infrastructure/prod-cluster-1
```

### Default Namespace (Abbreviated)

When referencing within the same namespace, you can omit the namespace:

```yaml
# In a component with namespace: eng-tools
spec:
  owner: backstage-eng # Expands to: group:pht-team/backstage-eng (only within default namespace)
  subcomponentOf: backstage-core
  dependsOn:
    - backstage-db # Same namespace
```

The default namespace typically matches the namespace of the referencing entity.

## Kind Values

All supported entity kinds for references:

| Kind        | Examples                            | Used For                       |
| ----------- | ----------------------------------- | ------------------------------ |
| `component` | `component:eng-tools/backstage-dev` | Software components            |
| `api`       | `api:eng-tools/backstage-api`       | APIs and interfaces            |
| `system`    | `system:eng-tools/backstage`        | Groups of components           |
| `domain`    | `domain:product/ecommerce`          | Products or business units     |
| `group`     | `group:pht-team/backstage-eng`      | Teams and organizational units |
| `user`      | `user:opentext/dserres`             | Individual people              |
| `resource`  | `resource:eng-tools/backstage-db`   | Infrastructure resources       |
| `location`  | `location:default/catalog-entities` | Catalog entity sources         |

## Reference Contexts

Entity references appear in different contexts:

### Ownership

```yaml
spec:
  owner: group:pht-team/backstage-eng
```

### Relationships

```yaml
spec:
  system: eng-tools/backstage
  domain: product/platform
  subcomponentOf: component:eng-tools/backstage-core
  providesApis:
    - api:eng-tools/backstage-api
  consumesApis:
    - api:platform/events-api
  dependsOn:
    - resource:eng-tools/backstage-db
    - component:platform/auth-service
```

### Support Contact

```yaml
spec:
  supportContact: user:opentext/platform-lead
```

### Group Hierarchy

```yaml
spec:
  parent: group:pht-team/common-tools
  members:
    - user:opentext/dserres
    - user:opentext/swilson2
```

### Leadership

```yaml
spec:
  leader: user:opentext/jsmith
```

## Namespace Considerations

### Namespace Naming Conventions

- **Team/Product namespaces** - `eng-tools`, `platform`, `commerce`
- **Organization namespaces** - `opentext`, `ldap`, organization domain
- **Infrastructure namespaces** - `infrastructure`, `operations`, `cloud`

### Multi-Namespace Organization

```yaml
# Product namespace
product/35968b13-c250-48e8-8309-5e5759b8fbcb

# Team namespace
pht-team/backstage-eng

# Organization namespace
opentext/dserres
```

### Namespace Uniqueness

Namespace + name must be unique together:

```
✓ engine:platform/auth-service
✓ engine:commerce/auth-service
✓ engine:infrastructure/auth-service
```

All three are valid because they have different namespaces.

## Cross-Namespace References

References across namespaces require full entity references:

```yaml
# In component (namespace: eng-tools)
spec:
  owner: group:pht-team/backstage-eng # Different namespace: pht-team
  domain: product/35968b13-c250-48e8... # Different namespace: product
  dependsOn:
    - resource:infrastructure/prod-cluster-1 # Different namespace: infrastructure
```

## Special Cases

### Self-References

A resource can reference itself in relationships:

```yaml
# Not typical, but allowed
spec:
  partOf: system:eng-tools/backstage
```

### Optional References

Many reference fields are optional:

```yaml
spec:
  system: eng-tools/backstage # optional
  domain: product/platform # optional
  subcomponentOf: component:eng-tools/backend # optional
```

If omitted, those relationships simply don't exist.

### Multiple References

Arrays of references are common:

```yaml
spec:
  providesApis:
    - api:eng-tools/catalog-api
    - api:eng-tools/search-api
  consumesApis:
    - api:platform/events-api
    - api:infrastructure/metrics-api
  dependsOn:
    - component:platform/auth-service
    - resource:infrastructure/prod-cluster-1
  members:
    - user:opentext/dserres
    - user:opentext/swilson2
```

## Reference Resolution

The catalog resolves references at import time:

1. Parse the reference string
2. Split into kind, namespace, and name
3. Look up the target entity in the catalog
4. Create relationship edges in both directions
5. Update UI navigation and search

## Reference Best Practices

1. **Use full references** when crossing namespaces
2. **Use abbreviated references** only within the same namespace
3. **Keep namespaces consistent** across your organization
4. **Document namespace conventions** in your catalog docs
5. **Validate references** - broken references won't generate relationships
6. **Use meaningful names** that match infrastructure naming
7. **Test references** by importing and checking the UI

## Troubleshooting References

### Reference Not Found

If a reference doesn't resolve:

1. Check the target entity exists in the catalog
2. Verify the kind spelling (case-sensitive)
3. Verify the namespace spelling (case-sensitive)
4. Verify the name spelling (case-sensitive)
5. Check for extra spaces in the reference

### Wrong Namespace

If a reference resolves to the wrong entity:

1. Verify the namespace is correct
2. Check if multiple entities have the same name in different namespaces
3. Use the full reference to disambiguate

## Example: Complete Reference Usage

```yaml
apiVersion: backstage.io/v1alpha1
kind: Component
metadata:
  namespace: eng-tools
  name: backstage-backend
spec:
  type: backend
  owner: group:pht-team/backstage-eng
  system: eng-tools/backstage
  domain: product/35968b13-c250-48e8-8309-5e5759b8fbcb
  providesApis:
    - backstage-api
  consumesApis:
    - api:platform/auth-api
    - api:infrastructure/metrics-api
  dependsOn:
    - resource:eng-tools/backstage-db
    - backstage-cache
    - resource:infrastructure/prod-cluster-1
```

Note how some references use abbreviated form (same namespace) and others use full form (different namespace).
