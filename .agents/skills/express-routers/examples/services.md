# `services/types.ts` — Service interfaces

Routes depend on these interfaces, never on concrete implementations. Pass the
real impl as a default in `routes/index.ts`; inject a mock in tests.

```typescript
export interface PostsService {
  list(): Promise<unknown[]>
  getOne(id: string): Promise<{ id: string }>
  create(data: unknown): Promise<unknown>
  update(id: string, patch: unknown): Promise<unknown>
  remove(id: string): Promise<null>
}

export interface CommentsService {
  list(postId: string): Promise<{ data: unknown[]; meta: { postId: string } }>
  create(postId: string, data: unknown): Promise<unknown>
  updateMany(postId: string, patches: unknown): Promise<unknown>
  removeMany(postId: string, ids?: unknown): Promise<null>
}

export interface UsersService {
  list(): Promise<unknown[]>
  getOne(id: string): Promise<{ id: string }>
  updateMe(userId: string, patch: unknown): Promise<unknown>
}

export interface AuthService {
  login(email: string, password: string): Promise<{ token: string }>
  register(email: string, password: string): Promise<{ token: string }>
}
```

