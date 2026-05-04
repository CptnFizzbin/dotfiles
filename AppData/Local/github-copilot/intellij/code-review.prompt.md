---
description: 'Perform a thorough code review using conventional comments formatting'
---

# Code Review

## Step 1 — Understand the changeset

Check if a `diff.txt` file exists in the project root.

- **If it exists:** read it to get an overview of what changed before diving into the files.
- **If it doesn't exist:** proceed by reviewing the relevant files directly.

After reading `diff.txt`, do a quick sanity check against the actual files in the repo. If the diff appears stale or
doesn't match the current state of the code (e.g. hunks that don't apply, files that have since changed), **stop and ask
the user to regenerate it** before continuing:

> "Hey, the diff looks out of sync with the current repo state. Can you regenerate `diff.txt`? (
`git diff main > diff.txt` or equivalent)"

## Step 2 — Review the code

Perform a thorough review covering:

- **Correctness** — Does the code do what it intends to? Are there edge cases or logic errors?
- **Design** — Is the solution well-structured? Does it fit the existing architecture?
- **Readability** — Is the code clear and self-documenting? Are names meaningful?
- **Maintainability** — Will this be easy to change later? Is complexity justified?
- **Test coverage** — Are new behaviors tested? Are existing tests updated where needed?
- **Security** — Any obvious vulnerabilities (injection, auth, sensitive data exposure)?
- **Performance** — Any unnecessary work, N+1s, or unintentional bottlenecks?
- **Conventions** — Does it follow the project's style, patterns, and tooling?

## Step 3 — Write the review

Structure your review as a formal markdown document saved to `docs/workspace/code-reviews/` using the filename format
`yymmdd-hhmm-{title}.md`.

Use **[Conventional Comments](https://conventionalcomments.org)** to label every piece of feedback:

| Label         | Use for                                          |
|---------------|--------------------------------------------------|
| `quibble:`    | Minor style/preference issues, non-blocking      |
| `suggestion:` | Improvements worth considering, non-blocking     |
| `issue:`      | Something that must be addressed — blocking      |
| `question:`   | Clarification needed before approving            |
| `thought:`    | An idea to discuss, no action required           |
| `chore:`      | Housekeeping tasks (renaming, cleanup, etc.)     |

Append decorations where relevant:

- **(non-blocking)** — feedback is optional
- **(blocking)** — must be resolved before merge
- **(if-minor)** — resolve if the change is trivial

### Review document structure

```
# Code Review: {title}

**Date:** {date}
**Reviewer:** Copilot

## Summary

Brief overview of what the changes do and overall impression.

## Changeset Overview

Summary of files changed (sourced from diff.txt or manual inspection).

## Feedback

### {filename or area}

**issue (blocking):** ...
**suggestion (non-blocking):** ...

(repeat per file/area)

## Verdict

- [ ] Approve
- [ ] Approve with minor changes
- [ ] Request changes

**Notes:** ...
```
