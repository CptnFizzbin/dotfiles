# Express Routers — Examples Index

Use the table below to find the right example file. Each file is self-contained
and focused on one topic.

- [schemas.md](examples/schemas.md) — Zod schema template + folder layout. Use when adding/validating a request body.
- [services.md](examples/services.md) — Service interface definitions. Use when defining a new service contract.
- [lib.md](examples/lib.md) — `RouterFactory<T>` + `isZodError`. Use when setting up or understanding the lib utilities.
- [app.md](examples/app.md) — `app.ts` entry point. Use when bootstrapping or modifying the top-level app.
- [middleware.md](examples/middleware.md) — `errorHandler()` + `requireAuth`. Use when adding middleware or understanding error handling.
- [routes-wiring.md](examples/routes-wiring.md) — `routes/index.ts` wiring. Use when mounting a new domain router.
- [routes-auth.md](examples/routes-auth.md) — Simple router, no nested resources. Use when creating a basic router with body validation.
- [routes-simple.md](examples/routes-simple.md) — Specific-before-param (`/me` before `/:id`). Use when handling named routes alongside param routes.
- [routes-nested.md](examples/routes-nested.md) — Nested sub-path (`/:id/comments`). Use when adding a nested resource on an existing router.
