# `routes/posts.ts` — Router with nested resources

Shows: multiple injected services, `requireAuth` inline per verb, and a nested
sub-path (`/:id/comments`) on the same router.

```typescript
import { Router } from "express"
import { requireAuth } from "../middleware/auth"
import type { CommentsService, PostsService } from "../services/types"
import { RouterFactory } from "../lib/routerUtils"
import { CreatePostDataSchema }    from "../schema/api/posts/createPostData"
import { UpdatePostDataSchema }    from "../schema/api/posts/updatePostData"
import { CreateCommentDataSchema } from "../schema/api/posts/createCommentData"
import { UpdateCommentsDataSchema } from "../schema/api/posts/updateCommentsData"
import { RemoveCommentsDataSchema } from "../schema/api/posts/removeCommentsData"

interface PostsRouterDeps {
  postsService: PostsService
  commentsService: CommentsService
}

export const createPostsRouter: RouterFactory<PostsRouterDeps> = ({ postsService, commentsService }) => {
  const router = Router()

  router
    .route("/")
    .get(async (_req, res) => {
      const data = await postsService.list()
      res.json({ data, meta: { page: 1, total: data.length } })
    })
    .post(requireAuth, async (req, res) => {
      const data = await postsService.create(CreatePostDataSchema.parse(req.body))
      res.status(201).json({ data })
    })

  router
    .route("/:id")
    .get(async (req, res) => {
      const data = await postsService.getOne(req.params.id)
      res.json({ data })
    })
    .patch(requireAuth, async (req, res) => {
      const data = await postsService.update(req.params.id, UpdatePostDataSchema.parse(req.body))
      res.json({ data })
    })
    .delete(requireAuth, async (req, res) => {
      await postsService.remove(req.params.id)
      res.status(204).send()
    })

  // Nested resource — same /:id prefix, different sub-path
  router
    .route("/:id/comments")
    .get(async (req, res) => {
      const result = await commentsService.list(req.params.id)
      res.json(result)
    })
    .post(requireAuth, async (req, res) => {
      const data = await commentsService.create(req.params.id, CreateCommentDataSchema.parse(req.body))
      res.status(201).json({ data })
    })
    .patch(requireAuth, async (req, res) => {
      const data = await commentsService.updateMany(req.params.id, UpdateCommentsDataSchema.parse(req.body))
      res.json({ data })
    })
    .delete(requireAuth, async (req, res) => {
      await commentsService.removeMany(req.params.id, RemoveCommentsDataSchema.parse(req.body))
      res.status(204).send()
    })

  return router
}
```

