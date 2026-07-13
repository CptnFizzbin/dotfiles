# Component Reference

Complete reference documentation for the Component entity kind.

## Entity Declaration

| Field        | Value                   |
| ------------ | ----------------------- |
| `apiVersion` | `backstage.io/v1alpha1` |
| `kind`       | `Component`             |

## What is a Component?

A Component describes a software component—typically intimately linked to source code and
representing a unit of software with a distinct deployable or linkable artifact. Examples include
backend services, frontend applications, websites, and libraries.

## Basic Structure

```yaml
apiVersion: backstage.io/v1alpha1
kind: Component
metadata:
  namespace: eng-tools
  name: backstage-dev
  title: Backstage Development
  description: OpenText Backstage Development Environment
  tags:
    - javascript
    - backstage
  links:
    - url: https://backstage-dev.otxlab.net
      title: Backstage DEV
      icon: dashboard
spec:
  type: website
  owner: group:pht-team/backstage-eng
  system: eng-tools/backstage
  domain: product/35968b13-c250-48e8-8309-5e5759b8fbcb
  lifecycle: development
  dependsOn:
    - resource:eng-tools/bp2-bkstdev-l001.otxlab.net
    - system:eng-tools/pht
```

## Metadata Section

### namespace [required]

- Type: string
- Purpose: Organizational grouping; typically team name
- Ensures combined uniqueness with `name`
- Example: `eng-tools`, `platform`, `services`

### name [required]

- Type: string
- Purpose: Unique identifier within the namespace
- Must be unique in combination with namespace
- Example: `backstage-dev`, `api-gateway`, `ui-components`

### title [optional]

- Type: string
- Purpose: Human-readable display name
- Used in UI and listings
- Example: `Backstage Development`

### description [optional]

- Type: string
- Purpose: Brief description of the component
- Supports markdown formatting
- Used in search and discovery

### tags [optional]

- Type: array of strings
- Purpose: Keywords for categorization and filtering
- Example: `["javascript", "backstage", "eng-tools"]`

### links [optional]

- Type: array of link objects
- Purpose: Important URLs related to the component

```yaml
links:
  - url: https://backstage-dev.otxlab.net
    title: Backstage DEV
    icon: dashboard
  - url: https://github.com/opentext/backstage
    title: Source Repository
    icon: github
```

## Spec Section

### type [required]

The category of component.

**Well-known values:**

- `artifact` - An artifact created by a build system (has type-specific fields in
  `kind-component-artifact.md`)
- `backend` - Backend service, typically exposing an API
- `frontend` - Frontend client, typically consuming the backend API
- `website` - Website combining both backend and frontend
- `library` - Software library (npm module, Java library, etc.)

Custom types are accepted, but well-known types enable Backstage to display specialized content.

### lifecycle [required]

The current stage of the component.

**Well-known values:**

- `experimental` - Early, non-production component; users may prefer alternatives
- `development` - Unstable; may change at any time
- `prerelease` - More stable than development but low reliability guarantees
- `production` - Established, owned, maintained component
- `sunset` - Identified for deprecation in the near future
- `deprecated` - End of lifecycle; may disappear later

### owner [required]

Entity reference to the component owner.

- Type: entity reference string
- Typically a Group (team)
- Example: `group:pht-team/backstage-eng`
- Can also be a User: `user:opentext/dserres`

Generated relationship: `ownerOf` (and reverse `ownedBy`)

### system [optional]

Entity reference to the parent system.

- Type: entity reference string
- Links component to a larger system
- Example: `eng-tools/backstage`
- Generated relationship: `partOf` (and reverse `hasPart`)

### domain [optional]

Entity reference to the domain (product or business unit).

- Type: entity reference string
- Typically a product or LOB
- Example: `product/35968b13-c250-48e8-8309-5e5759b8fbcb`
- Generated relationship: `partOf` (and reverse `hasPart`)

### subcomponentOf [optional]

Entity reference to a parent component.

- Type: entity reference string
- Indicates this component is part of another component
- Example: `project-frontend` (expands using default namespace)
- Generated relationship: `partOf` (and reverse `hasPart`)

### providesApis [optional]

Array of entity references to APIs this component provides.

```yaml
spec:
  providesApis:
    - artist-api
    - artist-search-api
```

Generated relationship: `providesApi` (and reverse `apiProvidedBy`)

### consumesApis [optional]

Array of entity references to APIs this component consumes.

```yaml
spec:
  consumesApis:
    - events-api
    - artist-api
```

Generated relationship: `consumesApi` (and reverse `apiConsumedBy`)

### dependsOn [optional]

Array of entity references to components or resources this depends on.

```yaml
spec:
  dependsOn:
    - artists-db # Uses default namespace
    - component:artists-service
    - resource:cdn-bucket
```

Generated relationship: `dependsOn` (and reverse `dependencyOf`)

### supportContact [optional]

Support information for the component.

**String formats (auto-detected):**

- Email: `support@company.com`
- URL: `https://support.company.com`
- Entity reference: `user:opentext/support-lead`

**Object format (explicit):**

```yaml
spec:
  supportContact:
    email: support@company.com
    url: https://support.company.com
    entity: user:opentext/support-lead
```

### artifacts [optional]

Array of artifact definitions for components built from multiple artifacts.

```yaml
spec:
  artifacts:
    - name: 'artifact-1'
      repo: 'maven-local'
      group: 'com.mycompany'
      scope: 'compile'
      packaging: 'aar'
    - name: 'artifact-2'
      repo: 'npm-local'
```

**Artifact fields:**

- `name` [required] - Artifact identifier
- `repo` [required] - Repository name
- `group` [optional] - Group/organization (required for Maven)
- `scope` [optional] - Scope (compile, test, provided, runtime, classpath, optional)
- `packaging` [optional] - Packaging type (aar, jar, etc.)

## Common Relationships

| Relationship | Generated From      | Target Kind         | Notes                                 |
| ------------ | ------------------- | ------------------- | ------------------------------------- |
| ownerOf      | spec.owner          | Component           | Team owns this component              |
| partOf       | spec.system         | System              | Component belongs to system           |
| partOf       | spec.domain         | Domain              | Component belongs to domain           |
| partOf       | spec.subcomponentOf | Component           | Component is part of parent component |
| providesApi  | spec.providesApis   | API                 | Component provides this API           |
| consumesApi  | spec.consumesApis   | API                 | Component consumes this API           |
| dependsOn    | spec.dependsOn      | Component, Resource | Component depends on these            |

## Tips

- All fields in `metadata` and `spec` sections are case-sensitive
- Entity references use `kind:namespace/name` format
- Default namespace allows shortened references within the same namespace
- The `owner` field is crucial for discoverability and accountability
- Lifecycle and type help Backstage display appropriate UI elements
- Systems help organize related components
- Dependencies are automatically visualized
