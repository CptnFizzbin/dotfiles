# `routes/users.ts` — Router with specific-before-param ordering

Shows: `requireAuth` on individual verbs, and a named route (`/me`) that must
be declared **before** the param route (`/:id`) so Express matches it correctly.

```typescript
import { Router } from "express"
import { requireAuth } from "../middleware/auth"
import type { UsersService } from "../services/types"
import { RouterFactory } from "../lib/routerUtils"
import { UpdateMeDataSchema } from "../schema/api/users/updateMeData"

interface UsersRouterDeps {
  usersService: UsersService
}

export const createUsersRouter: RouterFactory<UsersRouterDeps> = ({ usersService }) => {
  const router = Router()

  router.get("/", async (_req, res) => {
    const data = await usersService.list()
    res.json({ data })
  })

  // /me must come before /:id — Express matches top-to-bottom
  router
    .route("/me")
    .get(requireAuth, async (req, res) => {
      res.json({ data: req.user })
    })
    .patch(requireAuth, async (req, res) => {
      const data = await usersService.updateMe(req.user!.id, UpdateMeDataSchema.parse(req.body))
      res.json({ data })
    })

  router.get("/:id", async (req, res) => {
    const data = await usersService.getOne(req.params.id)
    res.json({ data })
  })

  return router
}
```

