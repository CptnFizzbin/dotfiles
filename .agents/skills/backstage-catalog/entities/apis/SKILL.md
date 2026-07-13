---
name: backstage-catalog-apis
description: Define and document API entities in the Backstage Software Catalog. Use when cataloging REST, GraphQL, gRPC, or AsyncAPI interfaces; when linking an API definition file to a component; or when documenting API ownership, lifecycle, and system membership.
---

# APIs

Subskill for defining API entities in the Backstage catalog.

## What is an API?

An API describes an interface that can be exposed by a component. APIs can be defined in multiple formats: OpenAPI, AsyncAPI, GraphQL, or gRPC. The catalog allows you to document and visualize API definitions alongside your components.

## Use This Subskill When

- Documenting APIs provided by your services
- Cataloging REST endpoints, event specifications, or data schemas
- Defining API ownership and lifecycle
- Linking APIs to their providing and consuming components

## Quick Example

```yaml
apiVersion: backstage.io/v1alpha1
kind: API
metadata:
  namespace: eng-tools
  name: backstage-api
  title: Backstage Backend API
  description: API for the Backstage backend service
spec:
  type: openapi
  lifecycle: production
  owner: group:pht-team/backstage-eng
  system: eng-tools/backstage
  domain: product/35968b13-c250-48e8-8309-5e5759b8fbcb
  definition:
    $text: ./openapi3.yaml
```

## API Types

- `openapi` - OpenAPI v2 or v3 specification (YAML or JSON)
- `asyncapi` - AsyncAPI specification for event-driven APIs
- `graphql` - GraphQL schema definitions
- `grpc` - Protocol Buffer definitions for gRPC services

## Lifecycle States

- `experimental` - Early, non-production API
- `production` - Established, owned, maintained API
- `deprecated` - End of lifecycle, may disappear later

## Key Relationships

- `owner` - The team responsible for this API (required)
- `system` - The system this API belongs to
- `domain` - The product or business unit
- `definition` - The actual API specification (required)

## Specification Format

The `definition` field should reference your API specification file:

```yaml
spec:
  definition:
    $text: ./openapi.yaml
```

This uses entity substitution to load the external file into the catalog.

## Reference Documentation

See [API Reference](./references/api.md) for complete field specifications.

## Tips

- API definitions are loaded via entity substitution
- Keep your OpenAPI/AsyncAPI/GraphQL files in the same repo as your component
- Link APIs to components using `providesApis` on the component
- Link consuming relationships using `consumesApis` on components
- Use descriptive titles and descriptions for discoverability
