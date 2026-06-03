---
name: find-source
description: Locate source files related to a feature or bug using semantic search, text search, and test files. Groups results by role and suggests insertion points for new code. Saves a structured source map to .agents/workspace/find-source/. Use when the user wants to find files related to a feature, bug, or ticket; mentions "where is X implemented", "find the code for", "which files are involved in", or invokes /find-source.
---

# find-source

Locate files related to a feature or bug and produce a structured source map of
the codebase.

## Quick start

When invoked with a description or ticket reference, follow the workflow below
and save output to `.agents/workspace/find-source/{topic}.md`.

## Workflow

1. **Parse the input**
    - Natural language? Extract key domain terms and feature concepts.
    - Ticket reference (e.g. `JIRA-1234`)? If an issue tracker tool/skill is
      available, fetch the ticket content. Otherwise, ask the user for a brief
      description before proceeding.

2. **Clarify scope (if needed)**
    - If the workspace is a monorepo or the input is ambiguous, ask: *"Should I
      search the whole workspace, or focus on a specific package?"*
    - Use semantic search and file patterns to infer scope first — only ask if
      necessary.

3. **Search for relevant files** (in order, combine results):
    - **Semantic search** — use meaning-based search with domain terms extracted
      from the input
    - **Grep / text search** — search for key identifiers, route paths, event
      names, or error strings from the input
    - **Test files** — tests reveal intent; search for test files that mention
      the feature or bug concepts
    - Avoid reading full file contents — use search results and snippets only

4. **Identify the top 5 most relevant files**
    - For each file, pull a short representative code snippet (use search results/snippets — don't read the full file)
    - Include relevant wrapping structures (class, namespace, function, module, etc.) so the snippet has context
    - Omit unrelated code within those structures using language-appropriate comment placeholders (e.g. `// ...`, `# ...`, `/* ... */`)
    - Write 1–3 sentences explaining *why* it's relevant

5. **Group all findings by role:**
    - 🚪 Entry Points (routes, handlers, event listeners, CLI commands)
    - 🧠 Business Logic (services, domain models, core algorithms)
    - 🗄️ Data / Config (schemas, migrations, config files, constants)
    - 🧪 Tests (unit, integration, e2e)
    - 🔧 Utilities / Shared (helpers, shared components, lib code)

6. **Suggest insertion points** for new code (if this is a feature or bug fix
   requiring changes):
    - Identify the most appropriate file(s) and where within them
    - Explain why that location makes sense given the existing patterns

7. **Save output** to `.agents/workspace/find-source/{topic}.md`
    - Use kebab-case for the topic name (derived from the input)
    - Ensure `.agents/workspace/` is in `.gitignore`

## Notes

- Don't read entire files unless there's no other way — rely on search snippets
- If results are sparse, broaden search terms and try synonyms or related
  concepts
- After 2–3 failed search attempts, summarise what was tried and ask the user
  for more context

## Output format

```md
# Source Map: {Topic}

**Input:** {original input} **Date:** {date}

---

## Top 5 Most Relevant Files

### 1. `path/to/file.ts`

```ts
class MyService {
  // ...

  relevantMethod(input: string): Result {
    // ...
    const processed = transform(input)
    return { processed, status: 'ok' }
    // ...
  }

  // ...
}
```

Short reason for why this snippet is important. 1-3 sentences at most.

### 2. `path/to/another-file.ts`

```ts
// namespace / module wrapping shown here, unrelated members omitted
export namespace FeatureModule {
  // ...

  export function relevantFunction() {
    // ...
  }

  // ...
}
```

Short reason. 1-3 sentences at most.

<!-- repeat for files 3–5 -->

---

## Files by Role

### 🚪 Entry Points
- `path/to/route.ts` — ...

### 🧠 Business Logic
- `path/to/service.ts` — ...

### 🗄️ Data / Config
- `path/to/schema.ts` — ...

### 🧪 Tests
- `path/to/feature.test.ts` — ...

### 🔧 Utilities / Shared
- `path/to/helper.ts` — ...

---

## Suggested Insertion Points

- **For [specific task]:** Add to `path/to/file.ts` near `functionName` — because [reason]
```
