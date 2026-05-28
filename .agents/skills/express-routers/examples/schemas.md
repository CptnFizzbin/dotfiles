# Zod Schema Pattern

Each request body gets its own file in `schema/api/<domain>/`. The file exports
a TypeScript interface and a Zod schema that `satisfies z.ZodType<Interface>`.

## Folder layout

```
schema/
└── api/
    ├── auth/
    │   └── loginData.ts
    ├── posts/
    │   ├── createPostData.ts
    │   ├── updatePostData.ts
    │   ├── createCommentData.ts
    │   ├── updateCommentsData.ts
    │   └── removeCommentsData.ts
    └── users/
        └── updateMeData.ts
```

## Template

```typescript
import z from "zod/v4"

export interface CreatePostData {
  title: string
  body: string
}

export const CreatePostDataSchema = z.object({
  title: z.string().min(1),
  body: z.string().min(1),
}) satisfies z.ZodType<CreatePostData>
```

## Usage in a handler

```typescript
router.post(requireAuth, async (req, res) => {
  const data = await postsService.create(CreatePostDataSchema.parse(req.body))
  res.status(201).json({ data })
})
```

`ZodError` thrown by `.parse()` propagates to `errorHandler` automatically —
no per-route try/catch needed.

