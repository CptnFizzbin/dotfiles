# `routes/auth.ts` — Simple router (no nested resources)

Shows the basic `RouterFactory` pattern with Zod body validation and no auth
middleware on the routes themselves.

```typescript
import { Router } from "express"
import type { AuthService } from "../services/types"
import { RouterFactory } from "../lib/routerUtils"
import { LoginDataSchema } from "../schema/api/auth/loginData"

interface AuthRouterDeps {
  authService: AuthService
}

export const createAuthRouter: RouterFactory<AuthRouterDeps> = ({ authService }) => {
  const router = Router()

  router
    .route("/login")
    .get((_req, res) => res.json({ message: "Return your login form here" }))
    .post(async (req, res) => {
      const { email, password } = LoginDataSchema.parse(req.body)
      const result = await authService.login(email, password)
      res.json(result)
    })

  router
    .route("/register")
    .get((_req, res) => res.json({ message: "Return your registration form here" }))
    .post(async (req, res) => {
      const { email, password } = LoginDataSchema.parse(req.body)
      const result = await authService.register(email, password)
      res.status(201).json(result)
    })

  return router
}
```

