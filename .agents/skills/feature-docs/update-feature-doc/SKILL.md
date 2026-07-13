---
name: update-feature-doc
description: Updates an existing feature doc to reflect new progress, completed work, or changed designs. Use when the user says "update the feature doc", "mark this as done", "reflect these changes in the feature doc", or provides a diff, PR description, commit log, or summary of completed work.
---

# Update Feature Doc

## Step 1 — Get the entrypoint

Accept whatever the user provides:

- **A diff or PR description** — use it to identify which components changed and what their new status is
- **A list of completed items** — map each to the relevant Implementation Details section
- **A description of design changes** — update the affected sections and Dependency Tree
- **A VE ticket ID or ticket content** — use it to locate the matching Implementation Details section

If the user hasn't said which feature doc to update, infer it from the entrypoint or ask.

## Step 2 — Read the current doc

Read the target `<feature-docs-dir>/NNN-slug/FEATURE.md`. Note the current status
of each Implementation Details section and Implementation Progress list.

## Step 3 — Apply changes

Update the file:

- **Implementation Progress** — advance items through `X` → `▶️` → `✓` as
  appropriate; fill in `[VE:XXXXXXX][]:` prefixes where ticket IDs are now known
- **Implementation Details** — update `**Implementation Status:**` and
  `**What's Missing:**` for each affected section; remove items from
  "What's Missing" once they are done
- **Dependency Tree** — update node symbols (`───` / `─▶─` / `─✓─` / `─C─`) to
  match the new state; refer to
  [../resources/dependency-tree-examples.md](../resources/dependency-tree-examples.md)
  for syntax
- **Frontmatter** — set `lastUpdated` to today's date and advance `status` to
  `In Progress` or `Complete` as appropriate

See [../resources/FEATURE-template.md](../resources/FEATURE-template.md) for the
canonical format.

## Step 4 — Confirm

Show the user a summary of what changed. If any section was ambiguous (e.g.
partial completion), flag it and ask for clarification before writing.
