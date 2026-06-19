---
description: Generate a GitHub PR or GitLab MR description from the current diff
---

You are generating a pull request / merge request description for a software
project.

## Instructions

1. Read `diff.txt` in the workspace root to understand what changed.
2. Analyse the diff and summarise the changes clearly and concisely.
3. Save the output as a Markdown file under `.agents/workspace/prs/` (or
   elsewhere if specified by the `AGENTS.md` or `CONTEXT.md` files) using the
   filename format:
   `YYYYMMDD-{short-slug}.md` (e.g. `20260504-refactor-migration-system.md`)
4. Ensure `docs/workspace` is listed in `.gitignore` — add it if it's missing.

## Output format

The generated Markdown file must follow this structure:

```markdown
# <Short, imperative title that summarises the change>

## Summary

<!-- 2–4 sentence overview of what this PR does and why -->

## Changes

<!-- Bullet list grouped by area/concern. Be specific but concise. -->

### <Group 1 (e.g. "Refactoring", "New Features", "Bug Fixes", "Removals")>

- ...

### <Group 2>

- ...

## Motivation

<!-- Why was this change needed? What problem does it solve? -->

## Testing

<!-- How was this tested, or what should reviewers check? -->

## Notes

<!-- Any caveats, follow-up work, or things reviewers should be aware of -->
```

## Guidelines

- Use an **imperative, present-tense** title (e.g. "Refactor migration system to
  use file-based discovery")
- Group related changes together — don't just dump every file change as a bullet
- Skip sections that don't apply (e.g. omit "Testing" if there are no testable
  changes)
- Keep the tone professional but direct
- Do **not** include raw file paths unless they add meaningful context
