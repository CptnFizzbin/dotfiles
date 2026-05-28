# `middleware/errorHandler.ts` — Zod-aware error handler factory

Registered last in `app.ts`. Formats Zod validation errors as structured field
errors (400); falls back to http-errors status/message for everything else.

```typescript
import { ErrorRequestHandler } from "express"
import { isZodError } from "../lib/zodUtils"

export const errorHandler = (): ErrorRequestHandler => {
  return (error, _req, res, _next) => {
    console.error(error)

    if (isZodError(error)) {
      return res.status(400).json({
        errors: error.issues.map(({ code, path, message }) => ({
          code,
          field: path.join("."),
          message,
        })),
      })
    }

    res.status(error.status ?? 500).json({
      error: error.message ?? "Internal Server Error",
    })
  }
}
```

# `middleware/auth.ts` — Auth middleware

`Express.Request` is augmented inline — no separate `types.d.ts` needed.
Throws an `http-errors` Unauthorized so `errorHandler` handles the formatting.

```typescript
import { RequestHandler } from "express"
import createHttpError from "http-errors"

declare global {
  namespace Express {
    interface Request {
      user?: { id: string }
    }
  }
}

export const requireAuth: RequestHandler = (req, _res, next) => {
  const token = req.headers.authorization?.split(" ")[1]
  if (!token) throw new createHttpError.Unauthorized()

  req.user = { id: "decoded-user-id-from-token" }
  next()
}
```

