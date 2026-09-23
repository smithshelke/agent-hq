---
name: setup
description: Spin up an agent HQ for a solo founder's startup — from an existing codebase, a startup memo, or just an idea. Designs specialist Claude Code agent roles from the code's real areas and the founder's business needs (product, marketing, finance, sales…), always with a PM owning the backlog and an investor-style advisor, each with persistent memory; plus shared CLAUDE.md knowledge, race-free team skills (team-kickoff, goal-complete, knowledge-pass, idea-review), and a tmux launcher. Also adds single roles later. Use whenever someone wants agent teammates, an AI dev or startup team, specialist agents for their app or business, to turn a startup memo into a project, "set up agent teams in this repo", or to add a role, even if they don't say "agent team".
---

# Agent HQ setup

Spin up an agent HQ: design a team of specialist Claude Code agents that fits *this* solo founder's project, then scaffold it. Assume the person may be new to Claude Code — explain terms briefly (roles, teammates, skills) the first time they come up. Roles come from two sources: the codebase's engineering areas and the founder's direction for business functions that never appear in code (marketing, business planning, finance, sales, support, legal research, ops). Nothing about which roles exist is fixed. Works in a code repo, a pre-code idea folder, or both.

## Why the setup is shaped this way

These behaviours were verified on Claude Code 2.1.280, where agent teams are experimental. If the installed version behaves differently (check `claude --version`; e.g. teams no longer need the env var, or tmux teammates now honor `skills:`), trust the observed behaviour and adapt.

- **Roles are files, teams are sessions.** Roles live in `.claude/agents/<role>.md` and persist. A team is one session's set of running roles; teammates go idle after a task and close only on shutdown. One team per session; 3–5 teammates at once.
- **In tmux pane mode a role's body replaces the teammate's system prompt**, so each role file must stand alone, including the team protocol.
- **`memory: project` works in every mode** (each role reads and writes `.claude/agent-memory/<role>/`). **`skills:` frontmatter is ignored in tmux pane mode**, so roles name the skills they should use in their body.
- **Knowledge is maintained in three places:** while working (each role saves lessons and gotchas as it goes, including in solo sessions), at the end of each team (`knowledge-pass`), and monthly (`knowledge-review`, run by the pm: prunes stale lines, resolves contradictions, keeps indexes current).
- **Knowledge is organized by area, not by agent.** Code areas and business functions (`business/marketing/`, `business/finance/`…) each get a folder with its own `CLAUDE.md`. Root `CLAUDE.md` = every agent; `<dir>/CLAUDE.md` = anyone working there; `docs/` = product, brand, decisions. A role's memory holds only how that role does its job.
- **One goal at a time, no races.** Teammates share one checkout (worktrees were rejected: per-worktree installs, env files, port clashes, delayed contracts, split knowledge). Instead the team finishes one goal on one branch before the next; within a goal each task lists the files it may change with no overlap between concurrent tasks, interface tasks run first, and only the lead runs installs, migrations, git operations, and the dev server. `goal-complete` gates each goal.
- **Only non-derivable knowledge earns a place.** No file trees, dependency lists, or anything an agent can read from the code.

## Modes

- **Full setup** (default): the workflow below.
- **Add a role** — the person asks for one role ("add a finance role", "we have code now, add engineering roles"): skip to step 2 for just that role, write it per step 3, create its workspace or area `CLAUDE.md`, update any list of roles in root `CLAUDE.md` (e.g. the business roles named in "Working as a team") and assign it relevant backlog items if the pm asks, then verify. Don't touch anything else.

## Workflow

### 0. Preflight

Check quietly and only mention problems:
- **Folder:**
  - **Existing project** (the current folder has code or project files): set up the HQ in place; the agents need to work where the code is.
  - **New project** (starting from a memo or an idea, or the current folder is the home directory, empty, or only holds the memo): create a new folder named `<project-slug>-hq` (lowercase, hyphens, e.g. `distribution-club-hq`), inside the current folder unless it's the home directory, in which case use `~/<project-slug>-hq`. Take the slug from the memo's or product's name. If that folder already exists and isn't empty, ask before using it. Copy the memo into it (see below) and do everything else inside it.
- **git:** agent teams rely on branches and diffs for review. If the folder isn't a git repo, offer to run `git init` (ask first).
- **tmux:** needed for split-pane teammates (`command -v tmux`). If missing, say teammates will run inside one Claude window instead and give the install command for their OS (macOS `brew install tmux`, Debian/Ubuntu `sudo apt install tmux`). On Windows without WSL, panes aren't available; in-process mode still works.
- **Claude Code version:** note `claude --version` for the report.
- **Memo or brief:** if the person points to a startup memo, pitch, or brief (a file path, or pasted text), read it fully. Copy it into the project as `docs/memo.md` (keep the original's filename in a first-line note) and treat it as the primary source for product, customer, pricing, stage, plans, and open questions. Never edit the original.

### 1. Inspect the project

Before asking anything, learn what you can. If there's no code yet, skip to existing docs and notes, and note that engineering roles will be placeholders or deferred.
- Stack, package manager, and layout from manifests, lockfiles, monorepo config.
- Real test, typecheck, lint, dev, and migration commands (manifest scripts, Makefile, CI).
- Generated or do-not-edit paths (migrations, codegen output, vendored code).
- Risk surfaces: auth, payments, PII, multi-tenancy, public APIs, production deploy paths.
- Where the work happens: recent git history per directory (`git log --since=3.months --name-only`), if there's history.
- Business material already in the repo: pitch notes, pricing pages, marketing copy, analytics config, `docs/`, `business/`.
- Existing `CLAUDE.md`, `.claude/agents/`, `.claude/skills/`, `.claude/settings.json`. **Never overwrite existing files**; merge into them. Existing roles are kept and counted in the design.

### 2. Design the roles

**Always include a `pm` role** (see `examples/roles/pm.md`): every company needs someone keeping the backlog across sessions. It owns `docs/backlog.md`, which is always created and seeded from the memo or the founder's priorities.

**Start small.** Propose the fewest roles that cover the current stage and the next 30 days of work (usually 3–4, never more than 6). List everything else under "add later" with the trigger for adding it (e.g. "backend — once there's code to own"). This applies in no-questions mode too. Roles can be added any time with the add-a-role mode.

Read `references/role-design.md` and follow it: map the engineering areas from the code, map the business functions from the founder's direction and stage, turn both into owner roles, add planning/testing/review roles only where they pay off, and pick tools and model per role.

Ask the founder, in one short round (AskUserQuestion if available), only what the code can't tell you:
- What the product does and for whom (one line), and the stage (idea, building, launched, growing). Skip what the memo already answers.
- Which business functions they want covered (offer the stage-based recommendation from `role-design.md` as the default), and which they'll keep doing themselves.
- Cost preference, if it changes model choices.

Then present the proposed roles as one table (role · kind · owns · why · model · tools), engineering and business together, and let them add, remove, rename, or merge. Generate only confirmed roles. If the founder said not to ask questions, use your best judgment and state the assumptions in the final report. Never attribute a request to the founder that they didn't make — distinguish "you asked for X" from "I chose X because…".

### 3. Write the roles

For each confirmed role, write `.claude/agents/<name>.md` and its memory seed following `references/role-spec.md` exactly: the frontmatter fields, the body order, and the two verbatim sections. Scope and rules come from what you found in step 1 (real paths, real commands, real risks). `examples/roles/` shows the finished quality bar; don't reuse their scope.

### 4. Write the shared scaffolding

Adapt each file in `template/`:

| Template | Adapt |
|---|---|
| `CLAUDE.md` | Product line, stack notes that aren't obvious from manifests, real commands, real generated paths. If one exists, add only the missing sections (Rules, Where knowledge lives, Keeping knowledge current). |
| area `CLAUDE.md` files (`template/apps/*/CLAUDE.md` are examples) | One per owned code folder. Seed with gotchas you actually noticed; otherwise leave the comment. |
| business workspaces (`template/business/CLAUDE.md` is the example) | One folder per business role, e.g. `business/marketing/`, with a `CLAUDE.md` holding a "What's here" index, that function's shared knowledge (brand voice, ICP, pricing decisions), and the founder's constraints for it. Code areas that accumulate specs (e.g. `product/`) get the same index. |
| `.claude/skills/*` | idea-review if the team has an advisor role. team-kickoff, goal-complete, knowledge-pass, and knowledge-review always (fill goal-complete's real test/typecheck/lint commands; for a no-code project drop its checks step). release-checklist only if there's code to release; fill real commands, name the actual review role (or drop that line if there is none), and add role-specific checks (e.g. "billing reviewed webhook idempotency", "marketing updated launch copy"). |
| `docs/*` | Fill product.md from the memo and the founder's answers (keep it short and point to `docs/memo.md` for detail); leave unknown fields as `<placeholders>`. Turn a memo's plans, build list, and open questions into initial backlog items. |
| `docs/backlog.md` | Always: copy and seed from the memo's plans and build list, or the founder's stated priorities. Owned by the pm role. |
| `.claude/settings.json` | Merge `env.CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS: "1"` and `teammateMode: "auto"`; keep existing keys. |
| `scripts/team.sh` | Copy and `chmod +x`, unless the project has an equivalent. |

If a role's rules name a project skill that doesn't exist yet (e.g. `db-migrations`), either create it from the procedure you found in step 1 or remove the reference.

### 5. Verify

- Each `.claude/agents/*.md` and `SKILL.md` has parseable frontmatter with `name` and `description`; role names are unique and match filenames.
- Every role contains both verbatim sections from the spec. (including the no-assumptions rule)
- Root `CLAUDE.md` contains the "Working as a team (no races)" section.
- Every path a role owns exists (create empty business workspaces), or is flagged as a placeholder.
- Business roles' rules forbid publishing, posting, outreach, sign-ups, and moving money, and require sources for factual claims.
- Read-only roles have no `Write`/`Edit`; no role has both `Bash` and `WebFetch`.
- `.claude/settings.json` is valid JSON.
- No `<placeholder>` remains where you had the real answer.
- Every backlog item has exactly one owner role (helpers go in the item text).
- Every workspace `CLAUDE.md` has a "What's here" section.
- `docs/backlog.md` has a recurring "Monthly knowledge review" item owned by pm.

### 6. Report

Short:
- The roles table as generated, and any assumptions you made.
- Files created vs. merged.
- Placeholders the founder still needs to fill.
- **Restart first:** agent teams only turn on when Claude starts, and this session started before `.claude/settings.json` existed. Tell the founder to exit this session and open the HQ with `./scripts/team.sh` before spawning any teammate; otherwise roles run as plain subagents with no panes.
- How to start (one line each, for someone new):
  - `./scripts/team.sh` opens the HQ (tmux session + Claude). Teammates appear as panes when a team starts.
  - *"Use team-kickoff to build <goal>"* starts a team. The team works one goal at a time; each closes with `goal-complete`.
  - *"Run the knowledge pass, then shut down the team."* ends it.
- **Idea stage or new memo:** recommend the first step is an advisor review of the memo before building: in the HQ, *"Spawn the advisor and have it validate the idea in docs/memo.md"*, then answer its questions in its pane.
- "Add later" roles and when to add them (*"/agent-hq:setup add a <role> role"*).
- The advisor is a teammate like the others: spawn it any time (*"Spawn the advisor to review my pricing idea"*) and talk to it in its pane. The lead also brings it in for strategic goals.
- Nothing is committed; review with `git diff`.
