---
name: team-kickoff
description: Start an agent team for a goal — a feature, a launch, a pricing change, a marketing campaign, a business plan. Use when the founder asks to work on something with the team or spin up teammates.
---
# Team kickoff

The team works on **one goal at a time** in a shared checkout. This plan is what prevents teammates from colliding.

1. **One goal.** If the founder didn't name one and there's a PM role, ask it to propose the next goal from `docs/backlog.md`. Restate the goal in one sentence; confirm scope with the founder if anything is ambiguous. If another goal is still open (uncommitted work, unfinished tasks), finish it with `goal-complete` first or ask the founder.
2. **Branch.** If the goal changes code, create the goal's branch yourself (e.g. `goal/<short-name>`) from a clean working tree.
3. **Plan.** If `.claude/agents/` has a planning role, spawn it and ask for the breakdown; otherwise plan yourself. Every task gets:
   - an owner role (an agent type from `.claude/agents/`),
   - **the exact files or folders it may change** — no two tasks that can run at the same time may share a file,
   - its dependencies — tasks that define an interface (API shape, schema, event names, shared types) come first; tasks that use it wait,
   - acceptance criteria.
4. **Assign shared files.** Manifests, lockfiles, schema, shared types, and config each get one owner for this goal. Do the lead-only steps yourself when asked: package installs, migrations, git operations, dev server.
5. **Load the task list** with owners, file lists, and dependencies. Spawn only the roles whose tasks are ready or soon ready (usually 2–4, never more than 5). Keep coding teammates to 2–3 in parallel.
6. **Tell the founder** which teammates are running and what each owns.
7. **Watch for overlap.** If a teammate needs a file outside its list, decide: reassign it, sequence it after the current owner, or message the owner.
8. **Finish** with the `goal-complete` skill. Keep teammates alive until the founder says to shut down; before shutdown, run `knowledge-pass` (you run it, or delegate to a planning role if one is running), then shut teammates down and clean up the team.
