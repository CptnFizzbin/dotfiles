# Groups & Users Reference

Complete reference documentation for Group and User entity kinds.

## Group Entity

### Entity Declaration

| Field        | Value                  |
| ------------ | ---------------------- |
| `apiVersion` | `backstage.io/v1beta1` |
| `kind`       | `Group`                |

### What is a Group?

A Group describes an organizational entity such as a team, business unit, or collection of people. Members of groups are modeled in the catalog as User entities.

### Basic Structure

```yaml
apiVersion: backstage.io/v1beta1
kind: Group
metadata:
  namespace: pht-team
  name: backstage-eng
  title: Backstage Engineering
  description: Team responsible for the Backstage platform
spec:
  type: team
  profile:
    displayName: Backstage Engineering
    email: backstage-eng@opentext.com
    picture: https://avatars.opentext.com/backstage-eng.png
  leader: user:opentext/dserres
  members:
    - user:opentext/ssanthosh
    - user:opentext/llaredovelaz
    - user:opentext/swilson2
    - user:opentext/grampersadh
  parent: group:pht-team/common-tools
```

### Metadata Section

#### namespace [required]

- Type: string
- Purpose: Organizational grouping
- Typically: `pht-team`, `department`, `squad`
- Example: `pht-team`

#### name [required]

- Type: string
- Purpose: Unique identifier within the namespace
- Example: `backstage-eng`, `platform-team`

#### title [optional]

- Type: string
- Purpose: Human-readable display name
- Example: `Backstage Engineering`

#### description [optional]

- Type: string
- Purpose: Description of the group's purpose
- Supports markdown

### Spec Section

#### type [required]

The category or type of group.

**Well-known values:**

- `team` - Product development team
- `department` - Organizational department
- `business-unit` - Business unit or line of business
- `squad` - Smaller team within a larger team

Custom types are accepted for organizational flexibility.

#### profile [optional]

Display profile information for the group.

```yaml
spec:
  profile:
    displayName: Backstage Engineering
    email: backstage-eng@opentext.com
    picture: https://avatars.opentext.com/backstage-eng.png
```

**Fields:**

- `displayName` - Human-readable name for UI display
- `email` - Group contact email for inquiries
- `picture` - URL to group avatar/logo image

#### leader [optional]

Entity reference to the group leader or manager.

- Type: entity reference string (User)
- Example: `user:opentext/dserres`
- Indicates the authoritative person responsible for the group
- Generated relationship: `leadOf`

#### members [optional]

Array of entity references to users who are members.

```yaml
spec:
  members:
    - user:opentext/ssanthosh
    - user:opentext/llaredovelaz
    - user:opentext/swilson2
```

Explicitly defines who is in the group.

#### parent [optional]

Entity reference to the parent group in the hierarchy.

- Type: entity reference string (Group)
- Example: `group:pht-team/common-tools`
- Indicates organizational hierarchy
- Not all groups need a parent (supports multi-root hierarchies)
- A group can have at most one parent
- Generated relationship: `childOf` (and reverse `parentOf`)

#### children [required but computed]

Child groups in the hierarchy (computed from parent references).

This field is typically not set manually; it's computed by the catalog from `parent` references in child groups.

## User Entity

### Entity Declaration

| Field        | Value                  |
| ------------ | ---------------------- |
| `apiVersion` | `backstage.io/v1beta1` |
| `kind`       | `User`                 |

### What is a User?

A User represents an individual person in the organization.

### Basic Structure

```yaml
apiVersion: backstage.io/v1beta1
kind: User
metadata:
  namespace: opentext
  name: dserres
  title: David Serres
spec:
  profile:
    displayName: David Serres
    email: dserres@opentext.com
    picture: https://avatars.opentext.com/dserres.jpg
  memberOf:
    - group:pht-team/backstage-eng
```

### Metadata Section

#### namespace [required]

- Type: string
- Purpose: Organizational grouping
- Typically: `opentext`, `ldap`, organization domain
- Example: `opentext`

#### name [required]

- Type: string
- Purpose: Unique identifier within the namespace
- Typically: username or LDAP uid
- Example: `dserres`, `swilson2`

#### title [optional]

- Type: string
- Purpose: Human-readable name or job title
- Example: `David Serres`

### Spec Section

#### profile [optional]

Display profile information for the user.

```yaml
spec:
  profile:
    displayName: David Serres
    email: dserres@opentext.com
    picture: https://avatars.opentext.com/dserres.jpg
```

**Fields:**

- `displayName` - Human-readable name for UI display
- `email` - Email address for contact
- `picture` - URL to user avatar image

#### memberOf [optional]

Array of entity references to groups the user belongs to.

```yaml
spec:
  memberOf:
    - group:pht-team/backstage-eng
    - group:pht-team/platform-engineering
```

Generated relationship: `memberOf` (and reverse `hasMember`)

## Common Relationships

### Group Relationships

| Relationship | Generated From | Target Kind | Notes                         |
| ------------ | -------------- | ----------- | ----------------------------- |
| memberOf     | spec.members   | User        | Group contains these users    |
| leadOf       | spec.leader    | User        | User leads this group         |
| childOf      | spec.parent    | Group       | Group belongs to parent group |
| parentOf     | (computed)     | Group       | Group has these child groups  |

### User Relationships

| Relationship | Generated From | Target Kind | Notes                        |
| ------------ | -------------- | ----------- | ---------------------------- |
| memberOf     | spec.memberOf  | Group       | User belongs to these groups |

## Entity References

When referencing users and groups in other entities:

```yaml
# Owner reference
spec:
  owner: group:pht-team/backstage-eng

# Support contact
spec:
  supportContact: user:opentext/dserres

# Component dependencies
spec:
  leader: user:opentext/jsmith
```

## Group Hierarchy Example

```yaml
# Parent group
apiVersion: backstage.io/v1beta1
kind: Group
metadata:
  namespace: pht-team
  name: common-tools
  title: Common Tools Division
spec:
  type: department

---
# Child group 1
apiVersion: backstage.io/v1beta1
kind: Group
metadata:
  namespace: pht-team
  name: backstage-eng
  title: Backstage Engineering
spec:
  type: team
  parent: group:pht-team/common-tools
  members:
    - user:opentext/dserres

---
# Child group 2
apiVersion: backstage.io/v1beta1
kind: Group
metadata:
  namespace: pht-team
  name: devx
  title: Developer Experience
spec:
  type: team
  parent: group:pht-team/common-tools
  members:
    - user:opentext/jsmith
```

## Tips

- Groups are often pre-populated from LDAP or enterprise directory
- User and group namespaces typically match your organization structure
- Email addresses in profiles are used for contact and notifications
- Profile pictures improve discoverability and recognition
- Member lists explicitly define team membership
- Leader designation creates accountability
- Parent/child hierarchy represents organizational structure
- Most users and groups are auto-synced; manual creation is rare
