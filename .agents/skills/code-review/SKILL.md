---
name: code-review
description: Performs a structured code review across correctness, security, performance, readability, and maintainability. Use when user says "review this", "code review", "review my PR", "review these changes", or pastes code and asks for feedback.
---

# Code Review

## Quick start

When triggered, check for a `diff.txt` file at the root of the workspace. If it is missing, ask the user to generate it first (e.g. `git diff main > diff.txt`). Once the diff is available, run through the [Review Checklist](#review-checklist), return a structured report, and save it to `.agents/workspace/reviews/`.

## Workflow

1. **Check for diff** — look for a `diff.txt` file at the root of the workspace. If it does not exist, stop and ask the user to create it (e.g. `git diff main > diff.txt`) before continuing.
2. **Identify scope** — read `diff.txt` to understand which files and lines changed
3. **Read context** — understand intent before judging style
4. **Run checklist** — work through each category below
5. **Write report** — format each finding as a [Conventional Comment](#conventional-comments), grouped by file and line number
6. **Save report** — write the report to `.agents/workspace/reviews/<YYYY-MM-DD>-<three-to-five-word-summary>.md` where the summary is a kebab-cased description of the changes (e.g. `2026-06-02-fix-auth-null-check.md`). If a file with that name already exists, append a numeric suffix (e.g. `-2.md`).
7. **Summarise** — one-paragraph verdict at the top, then tell the user where the report was saved

## Review Checklist

### ✅ Correctness

- [ ] Logic matches the stated intent / ticket requirements
- [ ] Edge cases handled (nulls, empty collections, boundary values)
- [ ] Error paths return meaningful messages or propagate correctly
- [ ] Tests exist and cover the new behaviour

### 🔒 Security

- [ ] No secrets, tokens, or PII in code or comments
- [ ] User-supplied input is validated / sanitised before use
- [ ] Auth/authz checks are present where required
- [ ] Dependencies introduced are not known-vulnerable

### ⚡ Performance

- [ ] No obvious N+1 queries or unbounded loops
- [ ] Expensive operations cached where appropriate
- [ ] Async/await used correctly; no accidental blocking

### 📖 Readability

- [ ] Names (variables, functions, types) are clear and consistent
- [ ] Complex logic is commented or extracted to named helpers
- [ ] No dead code or commented-out blocks left behind

### 🏗️ Maintainability

- [ ] Follows existing project conventions (naming, file layout)
- [ ] No large functions that should be split
- [ ] New abstractions pull their weight (not over-engineered)
- [ ] Public API changes are documented

## Conventional Comments

All findings must be written as [Conventional Comments](CONVENTIONAL_COMMENTS.md). Each comment follows this format:

```
<label> [decorations]: <subject>

[discussion]
```

Use these labels to match severity:

| Severity      | Labels to use                                      |
| ------------- | -------------------------------------------------- |
| 🔴 Blocker    | `issue (blocking)`                                 |
| 🟡 Warning    | `issue`, `todo`, `chore`                           |
| 🟢 Suggestion | `suggestion`, `quibble (non-blocking)`, `question` |

Add `(non-blocking)` or `(if-minor)` decorations when a finding should not hold up the PR.

## Report Format

Group all findings by file, then by line, so each block can be copy-pasted directly into a GitLab inline comment.

```
## Code Review — <PR or MR title>

**Verdict**: <one-sentence summary>

---

### `path/to/file.ts`

**Line 12**
issue (blocking): <subject>
<reason and suggested fix>

**Line 34**
suggestion: <subject>
<rationale or example>

---

### `path/to/other_file.ts`

**Line 7**
todo: <subject>
<explanation>

---

If a finding is not tied to a specific line (e.g. a structural concern), list it under a `### General` section at the end.
```
