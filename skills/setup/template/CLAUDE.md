# <Product name>

<One sentence: what it does and for whom. Details: docs/product.md>

## Stack
<!-- Only what isn't obvious from package manifests. -->
- <e.g. Next.js app in apps/web, Hono API in apps/api, Postgres via Drizzle>

## Rules (every agent)
- Never push to `main`. I review and merge.
- Never publish, post, email customers, sign up for services, or move money. Draft it; I do it.
- Never commit secrets. Env vars live in `.env.local` (gitignored); document new ones in `.env.example`.
- Never edit generated files: <list, e.g. `apps/api/src/db/migrations/*` — create new migrations instead>.
- If you changed code, run `<test command>` and `<typecheck command>` before calling work done.
- Stay in your lane: change only files your role owns. Need a change elsewhere? Message the owner.

## Working as a team (no races)
Teammates share one checkout, so the team works on **one goal at a time**:
- **One goal, one branch.** The lead creates the goal's branch. The next goal starts only after this one passes `goal-complete`.
- **Touch only the files your task lists.** Each task names the files it may change; no two running tasks share a file. Shared files (manifests, lockfiles, schema, shared types, config) have one owner per goal; ask them for changes.
- **Contracts first.** Tasks that depend on an interface (API shape, schema, event names) wait until the task defining it is done.
- **Lead-only commands:** installing or removing packages, migrations, `git` commits/branches/stash/reset/rebase, anything that rewrites the working tree, starting the dev server. Ask the lead.
- **Scoped checks only.** Run tests for your own area; the full suite runs once, at goal completion. Don't start servers on shared ports.
- Business roles work in their own `business/` folders and aren't bound by goal order.

## Where knowledge lives
- Area gotchas → the nearest `CLAUDE.md` (code areas like `apps/api/`; business functions like `business/marketing/`).
- Why we chose something → `docs/decisions/NNNN-title.md`.
- Product, users, pricing → `docs/product.md`. Voice and messaging → `docs/brand.md`.
- Repeatable procedures → `.claude/skills/`.

## Keeping knowledge current
- Hit a non-obvious gotcha? Add one line to the nearest `CLAUDE.md`.
- Learned something about *how to do your role*? Save it to your agent memory.
- Don't write down what the code already shows (file layout, dependency lists, signatures).
