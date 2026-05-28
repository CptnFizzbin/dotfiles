# `app.ts` — App entry point

```typescript
import express from "express"
import { createApiRouter } from "./routes"
import { errorHandler } from "./middleware/errorHandler"

const app = express()
app.use(express.json())

app.use("/api/v1", createApiRouter())

app.use(errorHandler())

app.listen(3000, () => console.log("Listening on http://localhost:3000"))

export default app
```

