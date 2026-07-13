# API Reference

Complete reference documentation for the API entity kind.

## Entity Declaration

| Field        | Value                   |
| ------------ | ----------------------- |
| `apiVersion` | `backstage.io/v1alpha1` |
| `kind`       | `API`                   |

## What is an API?

An API entity describes an interface that can be exposed by a component. The API can be defined in
different formats: OpenAPI, AsyncAPI, GraphQL, or gRPC. Catalog entities link APIs to their
providing and consuming components.

## Basic Structure

```yaml
apiVersion: backstage.io/v1alpha1
kind: API
metadata:
  namespace: eng-tools
  name: backstage-api
  title: Backstage Backend API
  description: API for the Backstage backend service
  tags:
    - rest
    - openapi
spec:
  type: openapi
  lifecycle: production
  owner: group:pht-team/backstage-eng
  system: eng-tools/backstage
  domain: product/35968b13-c250-48e8-8309-5e5759b8fbcb
  definition:
    $text: ./openapi3.yaml
```

## Metadata Section

### namespace [required]

- Type: string
- Purpose: Organizational grouping
- Ensures combined uniqueness with `name`
- Example: `eng-tools`, `platform`

### name [required]

- Type: string
- Purpose: Unique identifier within the namespace
- Example: `backstage-api`, `catalog-service-api`

### title [optional]

- Type: string
- Purpose: Human-readable display name
- Example: `Backstage Backend API`

### description [optional]

- Type: string
- Purpose: Brief description of the API
- Supports markdown

### tags [optional]

- Type: array of strings
- Purpose: Keywords for categorization
- Example: `["rest", "openapi", "v3"]`

### links [optional]

- Type: array of link objects
- Purpose: Important URLs for the API

```yaml
links:
  - url: https://backstage.opentext.com/docs/api
    title: API Documentation
    icon: docs
  - url: https://api.backstage.opentext.com/openapi.json
    title: OpenAPI Specification
    icon: code
```

## Spec Section

### type [required]

The format of the API definition.

**Well-known values:**

- `openapi` - OpenAPI v2 or v3 specification in YAML or JSON format
- `asyncapi` - AsyncAPI specification for event-driven APIs
- `graphql` - GraphQL schema definitions
- `grpc` - Protocol Buffer definitions for gRPC services

Custom types are accepted but well-known types enable specialized Backstage tooling.

### lifecycle [required]

The current stage of the API.

**Well-known values:**

- `experimental` - Early, non-production API
- `production` - Established, owned, maintained API
- `deprecated` - End of lifecycle; may disappear later

### owner [required]

Entity reference to the API owner.

- Type: entity reference string
- Typically a Group (team)
- Example: `group:pht-team/backstage-eng`
- Generated relationship: `ownerOf` (reverse `ownedBy`)

### system [optional]

Entity reference to the parent system.

- Type: entity reference string
- Example: `eng-tools/backstage`
- Generated relationship: `partOf` (reverse `hasPart`)

### domain [optional]

Entity reference to the domain (product or business unit).

- Type: entity reference string
- Example: `product/35968b13-c250-48e8-8309-5e5759b8fbcb`
- Generated relationship: `partOf` (reverse `hasPart`)

### definition [required]

The actual API specification in the format specified by `type`.

**Using entity substitution to load from file:**

```yaml
spec:
  definition:
    $text: ./openapi3.yaml
```

This loads the `openapi3.yaml` file from the same repository into the entity. The `$text` field is
an entity substitution that includes the file content.

**Inline definition (not recommended for large specs):**

```yaml
spec:
  definition: |
    openapi: 3.0.0
    info:
      title: Sample API
      version: 1.0.0
    paths: {}
```

### supportContact [optional]

Support information for the API.

**String formats (auto-detected):**

- Email: `support@company.com`
- URL: `https://support.company.com`
- Entity reference: `user:opentext/api-lead`

**Object format (explicit):**

```yaml
spec:
  supportContact:
    email: api-support@company.com
    url: https://api-support.company.com
    entity: user:opentext/api-lead
```

## Entity Substitutions

The `$text` substitution loads external files:

```yaml
spec:
  definition:
    $text: ./openapi.yaml
```

**Benefits:**

- Keeps `catalog-info.yaml` clean and maintainable
- Loads definitions directly from source files
- Works with any text file format

**Limitations:**

- File must be in the same repository
- Path is relative to the `catalog-info.yaml` file
- Content is included at import time

## Common Relationships

| Relationship | Generated From              | Target Kind | Notes                       |
| ------------ | --------------------------- | ----------- | --------------------------- |
| ownerOf      | spec.owner                  | API         | Team owns this API          |
| partOf       | spec.system                 | System      | API belongs to system       |
| partOf       | spec.domain                 | Domain      | API belongs to domain       |
| providedBy   | Component spec.providesApis | Component   | Component provides this API |
| consumedBy   | Component spec.consumesApis | Component   | Component consumes this API |

## API Format Examples

### OpenAPI 3.0 Reference

```yaml
spec:
  type: openapi
  definition:
    $text: ./openapi.yaml
```

Example `openapi.yaml`:

```yaml
openapi: 3.0.0
info:
  title: Sample API
  version: 1.0.0
paths:
  /items:
    get:
      summary: List all items
      responses:
        '200':
          description: Success
```

### AsyncAPI Reference

```yaml
spec:
  type: asyncapi
  definition:
    $text: ./asyncapi.yaml
```

### GraphQL Reference

```yaml
spec:
  type: graphql
  definition:
    $text: ./schema.graphql
```

### gRPC Reference

```yaml
spec:
  type: grpc
  definition:
    $text: ./service.proto
```

## Tips

- Always use entity substitutions (`$text`) for API definitions
- Keep API specs in the same repository as the component that provides them
- Use well-known types to enable Backstage tooling and visualization
- Link APIs to components using `providesApis` on the component
- Document lifecycle status to indicate API stability
- Use descriptive titles and descriptions for discoverability
