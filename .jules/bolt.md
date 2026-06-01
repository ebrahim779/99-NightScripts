## 2025-05-15 - Workspace traversal bottleneck in RenderStepped

**Learning:** Using `Workspace:GetDescendants()` inside a `RenderStepped` connection is a major performance anti-pattern. `GetDescendants` is an O(n) operation where n is the number of objects in the entire workspace. Running this ~60 times per second causes massive CPU spikes and frame drops, especially in games with many parts. Throttling such operations to run at a lower frequency (e.g., once per second) provides almost identical user-facing functionality while reducing the performance cost by orders of magnitude.

**Action:** Always check if frequent workspace traversals can be moved from `RenderStepped` to a throttled loop using `task.wait()` or `task.delay()`.
