---
name: backstage-catalog-locations
description: Define Location entities in the Backstage Software Catalog to register external entity sources. Use when pointing the catalog at a git repository, URL, or directory that contains catalog-info.yaml files, or when setting up automatic entity discovery for non-standard locations.
---

# Locations

Subskill for defining catalog entity locations.

## What is a Location?

A Location is a reference to a file or endpoint that contains one or more catalog entities. Locations allow the catalog to discover and import entities from various sources—git repositories, HTTP endpoints, or other sources.

## Use This Subskill When

- Setting up automatic discovery of catalog entities
- Registering new entity sources with the catalog
- Managing catalog entity imports from multiple repositories
- Pointing the catalog to external entity definitions

## Quick Example

```yaml
apiVersion: backstage.io/v1alpha1
kind: Location
metadata:
  name: backstage-entities
  description: Catalog entities from Backstage repository
spec:
  targets:
    - url: https://gitlab.otxlab.net/engineering-tools/backstage/-/raw/main/catalog-info.yaml
      rules:
        - allow: [Component, System, Resource, API, Group, User]
```

## Location Types

- Git repository with `catalog-info.yaml` files
- HTTP URL pointing to a catalog entity
- LDAP directory for user/group discovery
- Cloud storage locations

## Key Fields

- `targets` - Array of target URLs or locations to scan
- `type` - Source type (e.g., 'url', 'dir')
- `rules` - Filtering rules for what entities to allow

## How Catalog Discovery Works

1. Locations are registered with the Backstage catalog
2. The catalog backend periodically scans registered locations
3. New or updated entities are imported into the catalog
4. Changes are automatically reflected in the UI

## Automatic Git Repository Discovery

For git repositories, Backstage automatically scans for `catalog-info.yaml` files in the repository root:

```
repository-root/
  ├── catalog-info.yaml        # Automatically discovered
  ├── src/
  ├── docs/
  └── ...
```

## Tips

- Most projects don't need to manually create Location entities
- The catalog automatically discovers `catalog-info.yaml` in git repositories
- Use locations if you need to import entities from non-standard locations
- Targets can be specific files or directories to scan
- Rules control which entity kinds are imported
