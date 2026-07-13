# System Reference

Complete reference documentation for the System entity kind.

## Entity Declaration

| Field        | Value                   |
| ------------ | ----------------------- |
| `apiVersion` | `backstage.io/v1alpha1` |
| `kind`       | `System`                |

## What is a System?

A System is a collection of resources and components that work together to provide functionality. Systems represent an abstraction level above individual components, giving consumers insights into exposed features without requiring detailed visibility into all components. A system may expose or consume one or several APIs.

## Basic Structure

```yaml
apiVersion: backstage.io/v1alpha1
kind: System
metadata:
  namespace: eng-tools
  name: backstage
  title: Backstage Engineering Portal
  description: Centralized catalog and portal for the engineering organization
spec:
  type: application
  owner: group:pht-team/backstage-eng
  domain: product/35968b13-c250-48e8-8309-5e5759b8fbcb
```

## Metadata Section

### namespace [required]

- Type: string
- Purpose: Organizational grouping
- Ensures combined uniqueness with `name`
- Example: `eng-tools`, `platform`, `services`

### name [required]

- Type: string
- Purpose: Unique identifier within the namespace
- Example: `backstage`, `api-platform`

### title [optional]

- Type: string
- Purpose: Human-readable display name
- Example: `Backstage Engineering Portal`

### description [optional]

- Type: string
- Purpose: Description of the system's purpose
- Supports markdown

### tags [optional]

- Type: array of strings
- Purpose: Keywords for categorization
- Example: `["platform", "internal-tools"]`

### links [optional]

- Type: array of link objects
- Purpose: Important URLs for the system

```yaml
links:
  - url: https://backstage.opentext.com
    title: Live System
    icon: dashboard
  - url: https://docs.backstage.opentext.com
    title: Documentation
    icon: docs
```

## Spec Section

### type [required]

The category or type of system.

**Well-known values:**

- `application` - A system that primarily provides a web application
- `service` - A system that primarily provides data to other systems via an API
- `reporting` - A system that primarily generates reports

Custom types are accepted, but well-known types enable Backstage to display specialized content.

### owner [required]

Entity reference to the system owner.

- Type: entity reference string
- Typically a Group (team)
- Example: `group:pht-team/backstage-eng`
- Can also be a User: `user:opentext/jdoe`
- Generated relationship: `ownerOf` (reverse `ownedBy`)

In Backstage, the owner is the singular entity that bears ultimate responsibility for the system and has authority to develop and maintain it.

### domain [optional]

Entity reference to the domain (product or business unit).

- Type: entity reference string
- Example: `product/35968b13-c250-48e8-8309-5e5759b8fbcb`
- Generated relationship: `partOf` (reverse `hasPart`)

### supportContact [optional]

Support information for the system.

**String formats (auto-detected):**

- Email: `backstage-support@opentext.com`
- URL: `https://support.opentext.com`
- Entity reference: `user:opentext/platform-lead`

**Object format (explicit):**

```yaml
spec:
  supportContact:
    email: backstage-support@opentext.com
    url: https://support.opentext.com
    entity: user:opentext/platform-lead
```

## System Hierarchy

Systems organize entities into logical layers:

```
Domain (Product/Business Unit)
  └── System (Logical grouping of components)
        ├── Component 1 (Backend service)
        ├── Component 2 (Frontend app)
        ├── Component 3 (Library)
        ├── API 1 (Provided API)
        └── Resource 1 (Database)
```

## Relationships

Components belong to a system through their `spec.system` reference:

```yaml
# In a Component entity
spec:
  system: eng-tools/backstage
```

Systems belong to domains through their optional `spec.domain` reference.

## Common Relationships

| Relationship | Generated From        | Target Kind | Notes                            |
| ------------ | --------------------- | ----------- | -------------------------------- |
| ownerOf      | spec.owner            | System      | Team owns this system            |
| partOf       | spec.domain           | Domain      | System belongs to domain         |
| hasPart      | Component spec.system | Component   | System contains these components |

## When to Use Systems

**Use systems when:**

- You have multiple related components that form a coherent unit
- You want to provide a high-level view above individual components
- Your architecture has clear logical boundaries between subsystems
- You need to organize components by product feature or capability

**You might not need systems when:**

- Your project has only one or two components
- Components are loosely related
- You're early in development

## Example: Multi-Component System

```yaml
# System definition
apiVersion: backstage.io/v1alpha1
kind: System
metadata:
  namespace: commerce
  name: checkout
  title: Checkout System
spec:
  type: application
  owner: group:pht-team/checkout-team
  domain: product/ecommerce

---
# Component 1: Frontend
apiVersion: backstage.io/v1alpha1
kind: Component
metadata:
  namespace: commerce
  name: checkout-ui
spec:
  type: frontend
  owner: group:pht-team/checkout-team
  system: commerce/checkout

---
# Component 2: Backend
apiVersion: backstage.io/v1alpha1
kind: Component
metadata:
  namespace: commerce
  name: checkout-service
spec:
  type: backend
  owner: group:pht-team/checkout-team
  system: commerce/checkout

---
# Component 3: Library
apiVersion: backstage.io/v1alpha1
kind: Component
metadata:
  namespace: commerce
  name: checkout-utils
spec:
  type: library
  owner: group:pht-team/checkout-team
  system: commerce/checkout
```

## Tips

- Systems help consumers understand your software at a higher level
- Use descriptive titles and descriptions for clarity
- A component can only belong to one system
- Multiple systems can belong to one domain
- Ownership is typically at the system level for the owning team
- Systems are optional for small projects
- Use systems to organize by product feature or capability
