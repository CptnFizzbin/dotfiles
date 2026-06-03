# Conventional Comments

Conventional Comments is a standard for code review comments that makes feedback clearer, more actionable, and easier to process. Each comment is prefixed with a **label** that communicates the intent of the comment at a glance.

---

## Format

```
<label> [decorations]: <subject>

[discussion]
```

- **label** – A single word that categorizes the comment (see below).
- **decorations** _(optional)_ – Extra context modifiers in parentheses, e.g. `(non-blocking)`, `(if-minor)`.
- **subject** – A short, imperative summary of the comment.
- **discussion** _(optional)_ – A longer explanation, reasoning, or suggested alternative.

---

## Labels

| Label        | Purpose                                                                  |
| ------------ | ------------------------------------------------------------------------ |
| `quibble`    | Minor, preference-based suggestions. Often non-blocking.                 |
| `suggestion` | Proposes a specific improvement to the code.                             |
| `issue`      | Points out a problem that **must** be addressed before merging.          |
| `todo`       | A small, unambiguous task that needs to be done.                         |
| `question`   | Asks for clarification or raises uncertainty without demanding a change. |
| `chore`      | A maintenance task, e.g. updating a dependency or removing dead code.    |

---

## Decorations

Decorations are optional modifiers placed in parentheses after the label to provide additional nuance:

| Decoration       | Meaning                                                       |
| ---------------- | ------------------------------------------------------------- |
| `(non-blocking)` | The comment is informational and should not block merging.    |
| `(blocking)`     | The comment **must** be resolved before the PR can be merged. |
| `(if-minor)`     | Only address this if the change is trivial.                   |

---

## Examples

```txt
nitpick (non-blocking): Prefer double quotes for consistency with the rest of the codebase.
```

```txt
suggestion: Extract this logic into a helper function to reduce duplication.

Something like `calculateTotal(items)` would make this easier to test in isolation.
```

```txt
issue (blocking): This will throw a NullPointerException if `user` is not initialized.

We should add a null check before accessing `user.id`.
```

```txt
question: Is there a reason we're using a `for` loop here instead of `map`?
```

---

## Why Use Conventional Comments?

- **Reduces ambiguity** – Reviewers and authors immediately understand the weight and intent of each comment.
- **Speeds up reviews** – Authors can triage blocking vs. non-blocking feedback quickly.
- **Improves tone** – Encourages constructive, specific feedback rather than vague criticism.
- **Tooling-friendly** – Structured format is easy to parse, filter, or integrate with review tooling.

---

## References

- [conventionalcomments.org](https://conventionalcomments.org)
