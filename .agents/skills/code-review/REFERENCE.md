# Code Review — Reference

## Severity Definitions

| Level      | Emoji | Meaning                                                               |
|------------|-------|-----------------------------------------------------------------------|
| Blocker    | 🔴    | Must be fixed before merge — correctness, security, or data-loss risk |
| Warning    | 🟡    | Should be fixed — likely to cause future bugs or tech debt            |
| Suggestion | 🟢    | Nice to have — style, clarity, minor improvement                      |

## Extended Security Checks

- SQL / NoSQL injection vectors
- XSS via unsanitised HTML interpolation
- CSRF protection on state-changing endpoints
- Insecure direct object references (IDOR)
- Rate limiting on public endpoints
- Secrets in environment variables, not hardcoded

## Extended Performance Checks

- Pagination on list endpoints (no unbounded `SELECT *`)
- Index usage for DB queries (check query plans when unsure)
- Memory leaks in long-lived processes (timers, listeners not cleaned up)
- Streaming large files instead of buffering entirely in memory

## TypeScript-Specific Checks

- No `any` without a comment explaining why
- Return types explicit on public functions
- `unknown` preferred over `any` for external data
- Discriminated unions used for result/error types

## Common Anti-Patterns to Flag

| Anti-pattern                     | Preferred alternative |
|----------------------------------|-----------------------|
| `catch (e) {}` (swallowed error) | Log or rethrow        |
| Deeply nested callbacks          | async/await           |
| Magic numbers / strings          | Named constants       |
| Boolean parameters               | Options object        |
| Mutation of function arguments   | Return new value      |

## Writing Good Review Comments

**Describe, explain, suggest** — don't just say "this is wrong":

> ❌ "This is bad."  
> ✅ "This loops over `users` inside a loop over `orders`, causing O(n²) queries.
> Consider fetching all users upfront into a Map keyed by id."

Keep tone collaborative, not prescriptive. Use "consider", "could", "might" for
suggestions.

