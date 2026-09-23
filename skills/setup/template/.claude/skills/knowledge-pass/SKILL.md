---
name: knowledge-pass
description: End-of-team review that captures what the team learned into the right docs. Run before shutting a team down.
---
# Knowledge pass

Ask each teammate: "What did you learn that isn't obvious from the code?" Then file each answer:

| It's about… | Put it in |
|---|---|
| A gotcha in one code area | that folder's `CLAUDE.md` (one line) |
| A decision or lesson in a business function (marketing, finance…) | that function's `business/<function>/CLAUDE.md` |
| A rule every agent must follow | root `CLAUDE.md` |
| Why we chose something | new `docs/decisions/NNNN-title.md` |
| How a role should work | that role's `.claude/agent-memory/<role>/MEMORY.md` |
| A procedure we'll repeat | a new or updated skill in `.claude/skills/` |

Rules:
- Skip anything the code already shows.
- Move facts out of role memories into shared docs when other roles need them.
- Keep each memory file under ~60 lines; merge or delete stale lines.
- Don't commit. Summarize the changes for the founder to review with `git diff`.
