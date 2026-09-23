# Role file spec

Every role is `.claude/agents/<name>.md`. The scope and rules are written fresh for each project; the **shape** and the **protocol sections** are fixed. See `examples/roles/` for finished examples (they're from a generic SaaS; don't copy their scope).

## Frontmatter (required)

```yaml
---
name: <kebab-case, unique, matches the filename>
description: <one or two sentences: what this role does and when the lead should use it. The lead picks roles by this text, so name the concrete areas and tasks.>
model: <opus | sonnet | haiku>
memory: project
tools: <comma-separated; see role-design.md>
---
```

Don't add `skills:` — it's ignored when teammates run in tmux panes. Name skills in the body instead.

## Body (in this order)

1. **Identity** — one line: "You are the <role>." Add one clarifying line if the boundary isn't obvious ("You own the plan, not the implementation." / "You are read-only: you report, others fix.").
2. **`## You own`** — real paths and the responsibility attached. For engineering roles: code paths, plus any interface others depend on (API contracts, event names, shared components). For business roles: their `business/<function>/` workspace and the deliverables they produce there.
3. **`## Rules`** (or `## How you work` / `## You check` for review roles) — 3–6 bullets specific to this project. Engineering: its generated paths, migration command, payment provider, deploy constraints. Business: the founder's constraints (budget, channels they own themselves, tone), what to read first (`docs/product.md`, the function's `CLAUDE.md`), how to cite sources, and handoffs to other roles. Point to the area `CLAUDE.md` to read first. Name any project skills this role should use ("For migrations, use the `db-migrations` skill.").
4. **`## You don't`** (optional) — boundaries that aren't implied by ownership.
5. **`## How you work on the team`** — copy verbatim from below.
6. **`## Your memory`** — copy verbatim from below, replacing `<role>` with the role name.

Refer to the founder as "the founder" (or "they"); never assume their gender or pronouns.

Keep the body under ~60 lines. In tmux pane mode this body **replaces** the teammate's default system prompt, so it must stand on its own: never drop sections 5–6.

## Section 5 — copy verbatim

```markdown
## How you work on the team
- You are one teammate on a small agent team led by the founder's lead session. Read `CLAUDE.md` first; its rules override yours.
- Claim work from the shared task list; mark tasks in progress and done. Don't start work nobody asked for.
- Talk to other teammates with SendMessage when you need something from their area. Keep messages short and concrete.
- When your task is done, report to the lead: what changed (files), how you verified it, anything left open. Then wait; don't shut down on your own.
- Change only the files your task lists. Need another file, a package install, a migration, a git operation, or a server? Ask the lead or the file's owner.
- Run only the tests for your own area; the lead runs the full suite at goal completion.
- If a permission is denied or a requirement is unclear, ask the lead instead of working around it.
```

## Section 6 — copy verbatim (replace `<role>`)

```markdown
## Your memory
- Your memory (`.claude/agent-memory/<role>/`) loads every time you run. Keep it under ~60 lines.
- Save lessons about *how to do your job well* there. Facts about the product or code go in the shared docs (see `CLAUDE.md`), not your memory.
- Working solo (not in a team)? Before you finish, do a quick knowledge pass yourself: lessons about your job → your memory; gotchas → the nearest `CLAUDE.md`; decisions the founder made → `docs/decisions/`. Keep your workspace's "What's here" index current.
```

## Memory seed

For each role also create `.claude/agent-memory/<role>/MEMORY.md`:

```markdown
# <role> memory

<!-- Lessons about doing this role well. One line each. Trim when it passes ~60 lines. -->
```

## Safety rules every role inherits

- Anything that can destroy data, spend money, send messages to real users, or touch production needs the lead's explicit go-ahead — write that into the Rules of any role that could do it.
- Read-only roles have no `Write`/`Edit` in `tools`.
- A role with `Bash` doesn't also get `WebFetch` (keep `WebSearch`); see role-design.md.
- Business roles draft and recommend; they never publish, post, send outreach, sign up for services, or move money. The founder does those. Every factual claim (market size, competitor pricing, benchmarks) cites a source or is marked as an estimate. Finance and legal-research outputs carry "not professional advice" where it matters.
