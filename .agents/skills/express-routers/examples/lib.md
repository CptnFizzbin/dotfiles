# `lib/routerUtils.ts` — RouterFactory type helper

```typescript
import { Router } from "express"

export type RouterFactory<TDependencies> = (dependencies: TDependencies) => Router
```

# `lib/zodUtils.ts` — isZodError type guard

```typescript
import { ZodError } from "zod/v4"

export const isZodError = (obj: unknown): obj is ZodError => {
  return obj instanceof ZodError
}
```

