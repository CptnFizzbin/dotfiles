# Service Account Resource Reference

Complete reference documentation for Service Account resource type specifications.

## Entity Declaration

| Field        | Value                   |
| ------------ | ----------------------- |
| `apiVersion` | `backstage.io/v1alpha1` |
| `kind`       | `Resource`              |
| `spec.type`  | `service-account`       |

## What is a Service Account Resource?

A Service Account resource describes an account that is used for system-to-system communication and authentication—such as service principals, robot accounts, API keys, or other non-human authentication credentials.

## Basic Structure

```yaml
apiVersion: backstage.io/v1alpha1
kind: Resource
metadata:
  namespace: eng-tools
  name: backstage-db-user
  title: Backstage Database Service Account
  description: Service account for Backstage backend to access production database
spec:
  type: service-account
  owner: group:pht-team/backstage-eng
  system: eng-tools/backstage
```

## Service Account-Specific Fields

Service account resources support the following additional fields in `spec`:

### accountType [optional]

- Type: string
- Purpose: Type of service account
- Examples: `service-principal`, `robot-account`, `api-key`, `jwt-key`, `oauth-client`

### provider [optional]

- Type: string
- Purpose: Credential provider or issuer
- Examples: `kubernetes`, `aws-iam`, `azure-ad`, `gitlab`, `github`, `okta`

### credentialScheme [optional]

- Type: string
- Purpose: Type of credentials used
- Examples: `username-password`, `api-key`, `certificate`, `oauth2`, `jwt`, `token`

### scope [optional]

- Type: array of strings
- Purpose: Permissions or scopes granted to the account
- Examples for database: `["SELECT", "INSERT", "UPDATE"]`
- Examples for API: `["read:repositories", "write:builds"]`

### targets [optional]

- Type: array
- Purpose: Systems or services this account can access

```yaml
spec:
  targets:
    - system: eng-tools/backstage
    - service: backstage-db
    - api: catalog-api
```

### expiration [optional]

- Type: string (ISO 8601 date)
- Purpose: When the account credentials expire
- Example: `2025-12-31T23:59:59Z`

### rotationPolicy [optional]

- Type: object or string
- Purpose: Credential rotation schedule
- Examples: `quarterly`, `annual`, `on-demand`

```yaml
spec:
  rotationPolicy:
    frequency: quarterly
    lastRotated: 2024-01-15T00:00:00Z
    nextRotation: 2024-04-15T00:00:00Z
```

## Extended Example

```yaml
apiVersion: backstage.io/v1alpha1
kind: Resource
metadata:
  namespace: eng-tools
  name: backstage-db-user
  title: Backstage Database Service Account
  description: |
    Service account for Backstage backend services to access
    the production PostgreSQL database.
  tags:
    - database
    - service-account
    - production
  links:
    - url: https://vault.otxlab.net/ui/vault/secrets/pki/backstage-db-user
      title: Vault Secrets
      icon: lock
spec:
  type: service-account
  owner: group:pht-team/backstage-eng
  system: eng-tools/backstage
  domain: product/35968b13-c250-48e8-8309-5e5759b8fbcb
  accountType: service-principal
  provider: postgresql
  credentialScheme: username-password
  scope:
    - SELECT
    - INSERT
    - UPDATE
    - DELETE
  targets:
    - resource:eng-tools/backstage-prod-db
  rotationPolicy:
    frequency: quarterly
    lastRotated: 2024-01-15T00:00:00Z
    nextRotation: 2024-04-15T00:00:00Z
```

## Account Type Values

- `service-principal` - Azure service principal or similar
- `robot-account` - Robot/automated account (e.g., Jenkins, CI/CD)
- `api-key` - API key or token
- `jwt-key` - JWT signing key
- `oauth-client` - OAuth 2.0 client credential
- `machine-user` - Machine user account (GitHub, GitLab)

## Provider Values

- `kubernetes` - Kubernetes service account
- `aws-iam` - AWS IAM user or role
- `azure-ad` - Azure Active Directory
- `gitlab` - GitLab service accounts
- `github` - GitHub app or machine user
- `okta` - Okta service app
- `postgresql` - PostgreSQL database user
- `mysql` - MySQL database user
- `mongodb` - MongoDB service account
- `redis` - Redis ACL user
- `vault` - HashiCorp Vault
- `custom` - Custom provider

## Credential Scheme Values

- `username-password` - Traditional username/password pair
- `api-key` - API key or token string
- `certificate` - X.509 certificate-based auth
- `oauth2` - OAuth 2.0 credentials
- `jwt` - JWT token
- `token` - Generic token/secret
- `ssh-key` - SSH public/private key pair

## Scope Examples

### Database Access

```yaml
scope:
  - SELECT
  - INSERT
  - UPDATE
  - CREATE
```

### API Access (OAuth-style scopes)

```yaml
scope:
  - read:catalog
  - write:catalog
  - read:secrets
```

### Kubernetes

```yaml
scope:
  - namespaces: ['backstage']
    verbs: ['get', 'list', 'watch']
```

## Rotation Policy

Specifies how often credentials should be rotated:

```yaml
spec:
  rotationPolicy:
    frequency: quarterly # or: monthly, annually, on-demand
    lastRotated: 2024-01-15T00:00:00Z
    nextRotation: 2024-04-15T00:00:00Z
```

## Related Resources

Service accounts are typically used by:

- **Components** - Using credentials to access other services
- **Databases** - Database users for application access
- **APIs** - API credentials for service-to-service calls
- **CI/CD Systems** - Build and deployment automation
- **Message Queues** - Authentication for message consumption

## Example: Kubernetes Service Account

```yaml
apiVersion: backstage.io/v1alpha1
kind: Resource
metadata:
  namespace: platform
  name: backstage-k8s-sa
  title: Backstage Kubernetes Service Account
spec:
  type: service-account
  owner: group:platform-engineering/kubernetes
  accountType: service-principal
  provider: kubernetes
  credentialScheme: token
  scope:
    - namespaces: ['backstage', 'backstage-dev']
      verbs: ['get', 'list', 'watch', 'create']
  targets:
    - resource:infrastructure/prod-cluster-1
```

## Tips

- Service accounts provide system-to-system authentication
- Use rotation policies to ensure credential freshness
- Scope definitions follow provider-specific syntax
- Provider information helps with credential management tooling
- Expiration dates ensure credentials don't linger indefinitely
- Account type and credential scheme guide rotation procedures
- Multiple targets indicate accounts serving multiple services
- Keep vault or secrets management links in the resource
