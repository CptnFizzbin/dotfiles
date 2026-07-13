---
name: create-feature-doc
description: Creates a new feature doc in the project's feature-docs directory for a new piece of work, including the FEATURE.md, dependency tree, and user story tickets. Use when the user says "create a feature doc", "start a new feature", "add a feature doc for", or has just finished a grilling/PRD session and wants to publish the design.
---

# Create Feature Doc

## Step 1 — Gather inputs

Collect the following (from the conversation, a PRD, or by asking):

- **Feature title and summary** — what it does and why
- **VE ticket ID(s)** — one or more, with descriptions (or `[]` if not yet assigned)
- **User stories / requirements** — what needs to be built (U-## tickets)
- **Prerequisite features** — which existing feature docs must be complete first
- **Dependent features** — which future features depend on this one

If a PRD or grilling session is already in context, synthesize from it — do not re-interview.

## Step 2 — Determine the feature number

Locate the project's feature-docs directory (commonly `docs/feature-docs/`). Take
the next sequential number after the highest existing `NNN-` prefix.

## Step 3 — Create the directory and files

Create `<feature-docs-dir>/NNN-slug/FEATURE.md` using the canonical format from
[../resources/FEATURE-template.md](../resources/FEATURE-template.md).

Choose the correct Dependency Tree frame (see
[../resources/dependency-tree-examples.md](../resources/dependency-tree-examples.md)):

- No prerequisites, no dependents → `══ [NNN]`
- Prerequisites only → `╔═ PREREQUISITES` + `╚═ [NNN]`
- Dependents only → `╠═ [NNN]` + `╚═ DEPENDENTS`
- Both → `╔═ PREREQUISITES` + `╠═ [NNN]` + `╚═ DEPENDENTS`

All new user stories start as `───` (pending). Set `status: Draft` in frontmatter.

## Step 4 — Create user story tickets

For each user story, create `<feature-docs-dir>/NNN-slug/U-NN-slug.md` using the
canonical format from
[../resources/USER-STORY-template.md](../resources/USER-STORY-template.md).
Include the VE ticket ID in `ve-tickets:` if one is known.

## Step 5 — Update the docs index

If the project has a docs index (e.g. `docs/INDEX.md`), add the new feature to
its Feature Docs and User Stories sections.

## Step 6 — Update adjacent Dependency Trees

If this feature is listed as a prerequisite or dependent of any existing feature,
open those FEATURE.md files and add a reference to this new feature number in
their Dependency Trees.

