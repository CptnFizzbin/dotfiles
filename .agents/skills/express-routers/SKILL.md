---
name: express-routers
description: >
  Structure and write routers for Express.js applications using 
  the router-factory pattern with dependency-injected services. Use when 
  building an Express API, adding routes, creating routers, structuring an 
  Express app, or working with Express middleware and services in TypeScript.
---

# Express Routers

> ⚠️ **Project-first rule**: If the project already has an established Express
> structure (feature folders, controller classes, top-level routers, etc.),
> follow it. Only apply this pattern for greenfield work or when no convention exists.

## Preferred pattern: Router factories

Each domain module exports a `create<Domain>Router(deps)` function. Services are
injected — no global singletons in route files.

## App structure

```
src/
├── app.ts                  # Express app setup, mounts root router + error handler
├── lib/
│   ├── routerUtils.ts      # RouterFactory<TDeps> type helper
│   └── zodUtils.ts         # isZodError type guard
├── middleware/
│   ├── auth.ts             # requireAuth — also augments Express.Request inline
│   └── errorHandler.ts     # errorHandler() factory — Zod-aware, registered last
├── routes/
│   ├── index.ts            # Root createApiRouter() — wires sub-routers
│   ├── posts.ts            # createPostsRouter: RouterFactory<PostsRouterDeps>
│   ├── users.ts            # createUsersRouter: RouterFactory<UsersRouterDeps>
│   └── auth.ts             # createAuthRouter: RouterFactory<AuthRouterDeps>
├── schema/
│   └── api/
│       └── <domain>/       # One file per request body shape
│           └── xData.ts    # interface XData + XDataSchema (Zod)
└── services/
    ├── types.ts            # Service interfaces (inject these, not implementations)
    ├── posts.ts
    └── users.ts
```

## Key rules

1. **Router factories** —
   `export const createXRouter: RouterFactory<XRouterDeps> = (deps) => { ... }`
2. **`RouterFactory<TDeps>`** — defined in `lib/routerUtils.ts` as
   `(deps: TDeps) => Router`; gives you the return type for free
3. **Deps interface per router** — name it `XRouterDeps` (not `Options`);
   declare it in the same file
4. **Inject services** — pass service instances as params; default to real impls
   in `index.ts`
5. **Zod schema per request body** — `schema/api/<domain>/<name>.ts` exports an
   interface + a `satisfies z.ZodType<Interface>` schema; call
   `XSchema.parse(req.body)` in the handler — `ZodError` propagates to
   `errorHandler` automatically
6. **Chain `.route(path)`** — group all verbs for a path together
7. **Specific routes before params** — `/me` before `/:id`
8. **Auth middleware throws, not responds** — use `http-errors` to throw
   (`throw new createHttpError.Unauthorized()`); `errorHandler` catches it
9. **Error handler is a factory** — `app.use(errorHandler())` registered last;
   handles Zod errors (400 with structured field errors) and http-errors
10. **Service interfaces in `services/types.ts`** — routes depend on the
    interface, never the impl

## Workflows

### Adding a new domain (e.g. "comments")

- [ ] Define interface in `services/types.ts`
- [ ] Implement service in `services/comments.ts`
- [ ] Create Zod schemas in `schema/api/comments/` for each request body
- [ ] Create `routes/comments.ts` with `createCommentsRouter(deps)`
- [ ] Mount in `routes/index.ts` via
  `router.use('/comments', createCommentsRouter(...))`

### Adding middleware that augments `req`

- [ ] Declare the property inline in the middleware file:
  ```ts
  declare global { namespace Express { interface Request { user?: { id: string } } } }
  ```
- [ ] Set the property and call `next()` (or throw an http-error to reject)

See [EXAMPLES.md](EXAMPLES.md) for full code examples.
