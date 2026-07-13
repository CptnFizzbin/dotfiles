# Entity Substitutions Reference

Complete reference documentation for descriptor substitutions in the Backstage catalog.

## What are Substitutions?

Descriptor substitutions let a `catalog-info.yaml` file load external content into an entity by using `$text`, `$json`, or `$yaml`. This keeps entity descriptors concise while allowing larger definitions, such as OpenAPI documents, to remain in their native files.

## Supported Substitutions

### $text

Loads a referenced file as plain text.

```yaml
spec:
  definition:
    $text: ./openapi.yaml
```

Use `$text` when the consuming field expects a string, such as an API definition.

### $json

Loads a referenced file as JSON and embeds the parsed structure.

```yaml
spec:
  definition:
    $json: https://example.com/entity.json
```

Use `$json` when the consuming field expects structured JSON content.

### $yaml

Loads a referenced file as YAML and embeds the parsed structure.

```yaml
spec:
  definition:
    $yaml: ./definition.yaml
```

Use `$yaml` when the consuming field expects structured YAML content.

## Relative vs Absolute References

Relative references are resolved from the directory containing the `catalog-info.yaml` file.

```yaml
spec:
  definition:
    $text: ./openapi/openapi3.yaml
```

Absolute URLs can be used when the target is allowed by the Backstage backend reading configuration.

```yaml
spec:
  definition:
    $text: https://petstore.swagger.io/v2/swagger.json
```

## Typical Use Cases

- Load OpenAPI, AsyncAPI, GraphQL, or gRPC definitions into API entities
- Reuse shared structured metadata from YAML or JSON files
- Keep `catalog-info.yaml` files readable when definitions are large

## Example API Entity

```yaml
apiVersion: backstage.io/v1alpha1
kind: API
metadata:
  namespace: eng-tools
  name: backstage-api
  description: Backstage API definition
spec:
  type: openapi
  lifecycle: production
  owner: group:pht-team/backstage-eng
  definition:
    $text: ./openapi3.yaml
```

## Tips

- Relative substitution paths are resolved from the `catalog-info.yaml` location
- `$text` is the most common choice for API definitions
- External URLs may require `backend.reading.allow` configuration before they can be read
- Prefer substitutions when embedding large definitions would make the entity hard to maintain

