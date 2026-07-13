---
name: feature-docs
description: Manage feature design docs — create new ones or update existing ones to reflect progress. Use when the user says "create a feature doc", "update a feature doc", "start a new feature", "mark this as done", "reflect these changes in the feature doc", or provides a diff, PR description, or commit log to record against a feature.
---

# Feature Docs

Structured design documents that live alongside the codebase and track both
intent and progress for each feature.

## Sub-skills

| Task                           | Sub-skill                                         |
|--------------------------------|---------------------------------------------------|
| Create a new feature doc       | [create-feature-doc](create-feature-doc/SKILL.md) |
| Update an existing feature doc | [update-feature-doc](update-feature-doc/SKILL.md) |

Load the appropriate sub-skill and follow its workflow. Return here only if you
need to run both in sequence (e.g. create then immediately mark the first story
in progress).

## Shared Resources

Both sub-skills draw from the same canonical files:

| File                                                                 | Purpose                             |
|----------------------------------------------------------------------|-------------------------------------|
| [FEATURE-template.md](resources/FEATURE-template.md)                 | Canonical FEATURE.md format         |
| [USER-STORY-template.md](resources/USER-STORY-template.md)           | Canonical user story ticket format  |
| [dependency-tree-examples.md](resources/dependency-tree-examples.md) | Dependency tree syntax and examples |

## Conventions

- Feature docs live in a `feature-docs/` directory (commonly
  `docs/feature-docs/`).
- Each feature gets its own `NNN-slug/` subdirectory with a `FEATURE.md` and one
  `U-NN-slug.md` per user story.
- Status symbols used throughout: `───` pending · `─▶─` in progress · `─✓─`
  complete · `─C─` critical path.

