# Database Resource Reference

Complete reference documentation for Database resource type specifications.

## Entity Declaration

| Field        | Value                   |
| ------------ | ----------------------- |
| `apiVersion` | `backstage.io/v1alpha1` |
| `kind`       | `Resource`              |
| `spec.type`  | `database`              |

## What is a Database Resource?

A Database resource describes a Postgres, MySQL, or other database system that can be used by your own team or provided to other teams as a shared service.

## Basic Structure

```yaml
apiVersion: backstage.io/v1alpha1
kind: Resource
metadata:
  namespace: eng-tools
  name: backstage-prod-db
  title: Backstage Production Database
  description: Primary PostgreSQL database for Backstage
spec:
  type: database
  owner: group:pht-team/backstage-eng
  system: eng-tools/backstage
```

## Database-Specific Fields

Database resources support the following additional fields in `spec`:

### databaseType [optional]

- Type: string
- Purpose: Type of database engine
- Examples: `postgres`, `mysql`, `mariadb`, `oracle`, `sqlserver`, `mongodb`

### databaseVersion [optional]

- Type: string
- Purpose: Version of the database engine
- Examples: `14.5`, `8.0.28`, `13.0`

### host [optional]

- Type: string
- Purpose: Hostname or FQDN of the database server
- Examples: `db.otxlab.net`, `backstage-db.c5fz3y.rds.amazonaws.com`

### port [optional]

- Type: integer or string
- Purpose: Network port for database connections
- Default examples: `5432` (PostgreSQL), `3306` (MySQL)

### endpoint [optional]

- Type: string or object
- Purpose: Connection endpoint (can be complex for cloud databases)
- Examples: `postgresql://user:pass@host:5432/dbname`

### replicationStatus [optional]

- Type: string
- Purpose: Status of database replication
- Examples: `active`, `standby`, `synced`, `lagged`

### backupPolicy [optional]

- Type: string
- Purpose: Backup schedule and retention policy
- Examples: `daily`, `hourly`, `continuous`

### capacity [optional]

- Type: object
- Purpose: Storage and performance capacity
- Example:

```yaml
spec:
  capacity:
    storage: '1TB'
    iops: '20000'
    connections: '1000'
```

### encryption [optional]

- Type: object
- Purpose: Encryption configuration
- Example:

```yaml
spec:
  encryption:
    atRest: true
    inTransit: true
    algorithm: 'AES-256'
```

## Extended Example

```yaml
apiVersion: backstage.io/v1alpha1
kind: Resource
metadata:
  namespace: eng-tools
  name: backstage-prod-db
  title: Backstage Production Database
  description: |
    Primary PostgreSQL database for Backstage production.
    Highly available with automated backups.
  tags:
    - postgresql
    - production
    - critical
  links:
    - url: https://db-console.otxlab.net/backstage-prod
      title: Database Console
      icon: database
    - url: https://backups.otxlab.net/backstage
      title: Backup Status
      icon: backup
spec:
  type: database
  owner: group:pht-team/backstage-eng
  system: eng-tools/backstage
  domain: product/35968b13-c250-48e8-8309-5e5759b8fbcb
  databaseType: postgres
  databaseVersion: '14.5'
  host: backstage-prod-db.c5fz3y.rds.amazonaws.com
  port: 5432
  replicationStatus: active
  backupPolicy: hourly
  capacity:
    storage: '500GB'
    iops: '10000'
    connections: '500'
  encryption:
    atRest: true
    inTransit: true
    algorithm: 'AES-256'
```

## Related Resources

Databases typically work with:

- **Components** - Reference databases through `spec.dependsOn`
- **Service Accounts** - Authenticate to the database
- **Backup Systems** - Handle database backups and recovery
- **Monitoring Services** - Track database health and performance

## Connection Examples

### PostgreSQL

```
postgresql://user:password@host:5432/database_name
```

### MySQL

```
mysql://user:password@host:3306/database_name
```

### MongoDB

```
mongodb://user:password@host:27017/database_name
```

## Backup Policy Values

- `daily` - Daily backups
- `hourly` - Hourly backups
- `continuous` - Continuous/streaming backups
- `weekly` - Weekly backups
- `none` - No automated backups

## Tips

- Database version information aids with compatibility planning
- Capacity information helps with growth forecasting
- Replication status indicates high availability setup
- Backup policy is critical for disaster recovery planning
- Encryption details communicate security posture
- Host and port information aids with connection troubleshooting
- Connection endpoint can be used for automated tooling
