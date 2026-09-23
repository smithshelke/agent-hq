---
name: goal-complete
description: Gate that closes a team goal before the next one starts — integrates, runs the full checks, gets the founder's review, and commits. Use when all tasks for the current goal are done, or before starting a new goal.
---
# Goal complete

Run as the lead. Don't start the next goal until every step passes.

1. **All tasks done.** Every task in the list for this goal is marked done; no teammate is still editing.
2. **Only planned files changed.** `git status` / `git diff --stat`: every changed file belongs to some task's file list. Investigate anything else before continuing.
3. **Full checks.** Run `<test command>`, `<typecheck command>`, `<lint command>` once on the combined result. Failures go back to the owning role as a new task; repeat from step 1.
4. **Review role**, if the team has one and the goal touched auth, payments, or user data: get its sign-off.
5. **Founder review.** Summarize what changed (by role), how it was verified, and anything left open. Wait for the founder's go-ahead.
6. **Commit** on the goal's branch with a message that states the goal. Don't push or merge unless the founder asks.
7. **Knowledge pass** (`knowledge-pass` skill) if the team is about to shut down or learned something worth keeping.
8. Report that the goal is closed and the tree is clean. Only now can a new goal start.
