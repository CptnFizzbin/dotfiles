# `routes/index.ts` — Root router (wiring sub-routers)

Provides real service implementations as defaults. Each sub-router receives
only the services it needs, keeping deps explicit and testable.

```typescript
import { Router } from "express"
import { postsService }    from "../services/posts"
import { commentsService } from "../services/comments"
import { usersService }    from "../services/users"
import { authService }     from "../services/auth"
import { createPostsRouter } from "./posts"
import { createUsersRouter } from "./users"
import { createAuthRouter }  from "./auth"
import type {
  PostsService,
  CommentsService,
  UsersService,
  AuthService
} from "../services/types"

interface ApiRouterDeps {
  posts?:    PostsService
  comments?: CommentsService
  users?:    UsersService
  auth?:     AuthService
}

export function createApiRouter ({
  posts    = postsService,
  comments = commentsService,
  users    = usersService,
  auth     = authService,
}: ApiRouterDeps = {}): Router {
  const router = Router()
  router.use("/posts", createPostsRouter({ postsService: posts, commentsService: comments }))
  router.use("/users", createUsersRouter({ usersService: users }))
  router.use("/auth",  createAuthRouter({ authService: auth }))
  return router
}
```

