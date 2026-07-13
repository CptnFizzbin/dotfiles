# Well-Known Annotations Reference

Complete reference documentation for Backstage well-known annotations.

## What are Annotations?

Annotations are metadata key-value pairs attached to catalog entities. Well-known annotations have special meaning in Backstage and enable integrations with external systems. Custom annotations can also be added for application-specific metadata.

## Annotation Format

Annotations appear in the metadata section:

```yaml
metadata:
  annotations:
    annotation-key: value
    another.annotation/key: value
```

Annotation keys typically use reverse domain naming: `provider/key` or `provider.service/key`

## TechDocs Annotations

### backstage.io/techdocs-ref

Specifies the location of TechDocs documentation.

- **Key:** `backstage.io/techdocs-ref`
- **Value:** Documentation location
- **Typical Value:** `dir:.` (documentation in root directory)
- **Alternative Values:**
  - `dir:docs` - Documentation in `docs` directory
  - `url:https://docs.example.com` - External documentation URL

**Example:**

```yaml
metadata:
  annotations:
    backstage.io/techdocs-ref: dir:.
```

## GitHub Annotations

### github.com/project-slug

GitHub repository reference.

- **Key:** `github.com/project-slug`
- **Value:** GitHub organization/repository
- **Format:** `org/repo`
- **Example:** `opentext/backstage`

**Example:**

```yaml
metadata:
  annotations:
    github.com/project-slug: opentext/backstage
```

### github.com/team-slug

GitHub team reference for code ownership.

- **Key:** `github.com/team-slug`
- **Value:** GitHub organization/team
- **Example:** `opentext/backstage-eng`

**Example:**

```yaml
metadata:
  annotations:
    github.com/team-slug: opentext/backstage-eng
```

## GitLab Annotations

### gitlab.com/project-id

GitLab project ID.

- **Key:** `gitlab.com/project-id`
- **Value:** Numeric project ID or full path
- **Example:** `42` or `group/subgroup/project`

**Example:**

```yaml
metadata:
  annotations:
    gitlab.com/project-id: engineering-tools/backstage
```

## Artifactory Annotations

Artifactory integration for artifact repositories.

### artifactory.com/project-key

Artifactory project key.

- **Key:** `artifactory.com/project-key`
- **Value:** Project key in Artifactory
- **Example:** `backstage`

**Example:**

```yaml
metadata:
  annotations:
    artifactory.com/project-key: backstage
```

### artifactory.com/repo

Artifactory repository name.

- **Key:** `artifactory.com/repo`
- **Value:** Repository name
- **Example:** `npm-local`, `maven-local`

**Example:**

```yaml
metadata:
  annotations:
    artifactory.com/repo: npm-local
    artifactory.com/project-key: backstage
```

## OpenText Annotations

### opentext.com/repofile-readme

Relative path to the README associated with the entity.

- **Key:** `opentext.com/repofile-readme`
- **Value:** Repo-relative path from the `catalog-info.yaml` file to the README file
- **Example:** `README.md`, `docs/README.md`

**Example:**

```yaml
metadata:
  annotations:
    opentext.com/repofile-readme: README.md
```

This annotation is useful when the entity page should surface repository documentation without
requiring the README content to be duplicated elsewhere.

### opentext.com/repofile-changelog

Relative path to the changelog associated with the entity.

- **Key:** `opentext.com/repofile-changelog`
- **Value:** Repo-relative path from the `catalog-info.yaml` file to the changelog file
- **Example:** `CHANGELOG.md`, `docs/CHANGELOG.md`

**Example:**

```yaml
metadata:
  annotations:
    opentext.com/repofile-changelog: CHANGELOG.md
```

Use this annotation when change history should be discoverable directly from the catalog entity.

## PHT Annotations

### pht.opentext.com/pht-sync-id

PHT SyncID used to associate an entity with a PHT Product.

- **Key:** `pht.opentext.com/pht-sync-id`
- **Value:** PHT SyncID UUID
- **Example:** `b705ad7d-94ad-46e0-8342-03600718416a`

**Example:**

```yaml
metadata:
  annotations:
    pht.opentext.com/pht-sync-id: b705ad7d-94ad-46e0-8342-03600718416a
```

This attribute links an entity to a PHT Product based on the SyncID from PHT.

## View and URL Annotations

### backstage.io/view-url

Custom URL for viewing the entity.

- **Key:** `backstage.io/view-url`
- **Value:** URL to custom view or dashboard
- **Example:** `https://dashboard.company.com/component/id`

**Example:**

```yaml
metadata:
  annotations:
    backstage.io/view-url: https://app.company.com/services/backstage
```

### backstage.io/edit-url

Custom URL for editing the entity definition.

- **Key:** `backstage.io/edit-url`
- **Value:** URL to edit interface
- **Example:** `https://github.com/org/repo/edit/main/catalog-info.yaml`

**Example:**

```yaml
metadata:
  annotations:
    backstage.io/edit-url: https://github.com/opentext/backstage/edit/main/catalog-info.yaml
```

## Sentry Annotations

### sentry.io/project-slug

Sentry error tracking project.

- **Key:** `sentry.io/project-slug`
- **Value:** Project slug in Sentry
- **Format:** `organization/project`
- **Example:** `company/backstage`

**Example:**

```yaml
metadata:
  annotations:
    sentry.io/project-slug: opentext/backstage
```

## SonarQube Annotations

### sonarqube.org/project-key

SonarQube project key for code quality metrics.

- **Key:** `sonarqube.org/project-key`
- **Value:** Project key in SonarQube
- **Example:** `com.company:backstage`

**Example:**

```yaml
metadata:
  annotations:
    sonarqube.org/project-key: com.opentext:backstage
```

## Custom Annotations

You can define custom annotations for your organization:

```yaml
metadata:
  annotations:
    my-company.com/cost-center: '12345'
    my-company.com/business-unit: platform
    my-company.com/sla-tier: critical
    my-company.com/data-classification: internal
```

## Complete Example

```yaml
apiVersion: backstage.io/v1alpha1
kind: Component
metadata:
  namespace: eng-tools
  name: backstage-backend
  title: Backstage Backend Service
  annotations:
    backstage.io/techdocs-ref: dir:.
    github.com/project-slug: opentext/backstage
    github.com/team-slug: opentext/backstage-eng
    gitlab.com/project-id: engineering-tools/backstage
    artifactory.com/repo: npm-local
    opentext.com/repofile-readme: README.md
    opentext.com/repofile-changelog: CHANGELOG.md
    pht.opentext.com/pht-sync-id: b705ad7d-94ad-46e0-8342-03600718416a
    pagerduty.com/service-id: PXXXXXXX
    sentry.io/project-slug: opentext/backstage
    sonarqube.org/project-key: com.opentext:backstage
    my-company.com/cost-center: '12345'
    my-company.com/data-classification: internal
spec:
  type: backend
  owner: group:pht-team/backstage-eng
```

## Annotation Key Conventions

- Use reverse domain notation: `provider.com/key` or `provider/key`
- Use lowercase letters and hyphens for readability
- Use `/` to separate provider from key name
- Consider namespacing custom annotations: `company.com/key`
- Document custom annotations in your organization's guidelines

## Tips

- Annotations enable integrations with external systems
- Well-known annotations are recognized by Backstage plugins
- Custom annotations store application-specific metadata
- Annotations don't appear in relationships but enable queries
- Use annotations for integrations rather than core catalog data
- Keep annotation keys consistent across similar entities
- Document custom annotation usage for your team
- OpenText repo file annotations should use paths relative to the `catalog-info.yaml` file
