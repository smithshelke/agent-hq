---
name: knowledge-review
description: Periodic cleanup of the project's knowledge base — prunes stale or reversed guidance, resolves contradictions between role memories and shared docs, and keeps workspace indexes current. Run monthly (the pm owns it) or when agents seem to follow outdated guidance.
---
# Knowledge review

Knowledge rots: decisions get reversed, lessons stop applying, workspaces fill up. This review keeps what agents read accurate and short.

1. **Collect.** Root `CLAUDE.md`, every area and workspace `CLAUDE.md`, `.claude/agent-memory/*/MEMORY.md`, `docs/product.md`, `docs/decisions/`, and `git log --since=1.month --stat` for context.
2. **Stale lines.** Flag anything that no longer matches reality: references to files that don't exist, tools or vendors no longer used, "MVP/Next" items that have shipped, lessons tied to removed code.
3. **Contradictions.** Compare role memories and area files against root `CLAUDE.md`, `docs/product.md`, and the latest decision records. Newer accepted decisions win; if it's unclear which is right, ask the founder.
4. **Misfiled knowledge.** Facts in a role's memory that other roles need → move to the shared doc. Role-specific how-to in shared docs → move to that role's memory.
5. **Size.** Memory files over ~60 lines and `CLAUDE.md` files over ~100 lines: merge duplicates, cut what the code or files already show.
6. **Indexes.** Every workspace's "What's here" lists what's actually in the folder; add missing files, remove deleted ones.
7. **Report and apply.** Show the founder a short list of proposed removals and moves (quote each removed line). Apply what they approve. Don't commit; they review with `git diff`.
8. Update the "Last done" date on the recurring item in `docs/backlog.md`.
