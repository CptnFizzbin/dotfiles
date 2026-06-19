---
name: ve-ticket
description: Draft and write a ValueEdge User Story or Defect ticket as a local markdown file, ready for manual paste into ValueEdge. Bundles VE ticket templates and formatting rules. Use when user wants to create a ticket, write a story, log a defect, or says "create a VE ticket", "write a story", "log a bug".
---

# VE Ticket

Create a single ValueEdge User Story or Defect ticket as a local markdown file.

## Process

### 1. Read domain context

Read `CONTEXT.md` at the repo root and any ADRs in `docs/adr/` that are relevant to the area the ticket covers. Use the project's domain vocabulary — never drift to synonyms the glossary avoids.

### 2. Determine ticket type

- **User Story** — a new capability, behaviour, or improvement a user needs
- **Defect** — a bug: something that should work but doesn't

If ambiguous, infer from context. Ask only if genuinely unclear.

### 3. Infer the feature slug and file path

Derive a `kebab-case` slug from the ticket's subject (e.g. "gateway auth timeout" → `gateway-auth-timeout`).

Determine the next sequential number by counting existing `U-NN` or `I-NN` files in `.agent/tickets/<feature-slug>/`.

Output path:
- User Story → `.agent/tickets/<feature-slug>/U-<NN>-<slug>.md`
- Defect → `.agent/tickets/<feature-slug>/I-<NN>-<slug>.md`

Create the directory if it doesn't exist.

### 4. Write the file and display the content

Write the file immediately. Then display the full ticket content so it's ready for manual paste into ValueEdge.

---

## Templates

### User Story

```
type: User Story

# Summary
<project>: <feature/section> - <ticket subject>

# Description
<description of the user story, including the user need, context, and any 
relevant details. Focus on the "why" and "what", not the "how".>

# Acceptance Criteria
- <criterion 1>
- <criterion 2>
```

### Defect

```
type: Issue

# Summary
<project>: <feature/section> - <ticket subject>

# Description
<freeform description of the bug and its impact>

Steps to Reproduce
1. <step 1>
2. <step 2>

What Currently Happens
<observed behaviour>

What Should Happen
<expected behaviour>

# Acceptance Criteria
- <criterion 1>
- <criterion 2>
```

---

## Formatting rules

ValueEdge descriptions are plain text — keep content paste-ready:

- `#`, `##`, `###` for section headers
- `---` for dividers
- `` `inline code` `` for identifiers and values
- No bold, italics, links, or fenced code blocks

---

## VE hierarchy (reference)

Epics → Features → **User Stories / Issues**

Agents work at User Story and Issue level only. Never create Epic or Feature tickets.
VE ticket IDs are 9 digits prefixed by type: `U123456789`, `I123456789`.
Local files do not store VE IDs — once in VE, VE is the source of truth.

