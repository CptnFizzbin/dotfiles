---
name: backstage-catalog-groups-and-users
description: Define Group and User entities in the Backstage Software Catalog representing teams and individuals. Use when setting up ownership, specifying team membership, building organizational hierarchies, or referencing a PHT team as a component owner.
---

# Groups & Users

Subskill for defining organizational entities—groups (teams) and users in the Backstage catalog.

## What are Groups and Users?

**Groups** describe organizational entities such as teams, business units, or interest groups. **Users** represent individual people. These entities form the ownership and organizational structure that other catalog entities reference. Users are members of groups.

## Use This Subskill When

- Setting up team ownership for components, systems, or APIs
- Defining organizational hierarchies
- Managing group membership
- Specifying support contacts or leaders
- Understanding who owns what in the catalog

## Groups Example

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
  leader: user:opentext/dserres
  members:
    - user:opentext/ssanthosh
    - user:opentext/llaredovelaz
    - user:opentext/swilson2
    - user:opentext/grampersadh
```

## Users Example

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
  memberOf:
    - group:pht-team/backstage-eng
```

## Group Types

- `team` - Product development team
- `department` - Organizational department
- `business-unit` - Business unit or line of business
- `squad` - Smaller team or squad within a larger team

## Key Relationships

- `leader` - Lead or manager of the group
- `members` - Individual users in the group
- `parent` - Parent group in organizational hierarchy
- `children` - Child groups (inferred from members' parents)

## EntityReferences for Ownership

When specifying owners, use entity references:

```
group:namespace/name      # Reference a group
user:namespace/name       # Reference a user
```

Examples:

- `group:pht-team/backstage-eng` - The Backstage Engineering team
- `user:opentext/dserres` - David Serres (user)

## Reference Documentation

- [Groups Reference](./references/group.md)
- [Users Reference](./references/user.md)

## Tips

- Groups are often pre-populated from LDAP/enterprise directory
- User and group namespaces typically match your organization structure
- Use email addresses in profiles for contact purposes
- Profile pictures are optional but improve discoverability
- Members list explicitly defines team membership
- Use hierarchy to represent organizational structure (parent/children)
