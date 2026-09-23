# agent-hq

Spin up an **agent HQ** for a solo founder's project: a team of specialist Claude Code agents that build, market, plan, and challenge your idea together, while you stay the founder who decides.

One command looks at your project (code or just an idea), asks you a few questions, and sets up:

- **Specialist roles** designed from *your* codebase, memo, and goals, not a fixed menu: engineering or product roles for the areas of your product, business roles you ask for (`marketing`, `finance`, `sales`…), a **PM** that owns the backlog across sessions, and an **advisor** that reviews your idea like a demanding early-stage investor.
- **Memory per role** that grows as each agent learns how to do its job.
- **Shared knowledge** every agent reads: product, brand, decisions, and gotchas per area.
- **Team workflows** as skills: `team-kickoff`, `goal-complete`, `knowledge-pass`, `knowledge-review` (monthly, run by the PM), `release-checklist`, `idea-review`.
- **Race-free teamwork**: one goal at a time, each task limited to its own files, and git, installs and migrations run only by the lead.
- **Launcher**: `scripts/team.sh` opens the HQ in tmux; teammates, including the advisor, appear as panes you can talk to directly.

## Requirements

- [Claude Code](https://code.claude.com/docs). Built and tested on 2.1.280, where agent teams are experimental.
- git
- tmux for split-pane teammates (optional: without it, teammates run inside one Claude window).

## Install

From a clone of this repo:

```sh
claude --plugin-dir /path/to/agent-hq
```

Or add it as a marketplace and install it into one project:

```
/plugin marketplace add smithshelke/agent-hq
/plugin install agent-hq@agent-hq --scope project
```

## Use

In your project folder:

```
/agent-hq:setup
```

You can also just say *"set up an agent team for this project"*. Starting from a startup memo? Put it in an empty folder and say *"start a new project from memo.md with an agent team"*. Add a role later with *"/agent-hq:setup add a <role> role"*. Review the proposed roles, then:

```sh
./scripts/team.sh                 # open the HQ
> Use team-kickoff to build <feature / launch / campaign>
> ...
> Run the knowledge pass, then shut down the team.

> Spawn the advisor to review my pricing idea   # then chat in its pane
```

Nothing is committed. Review every change with `git diff`.

## How it works

| Piece | Where |
|---|---|
| Rules for every agent, including the no-races rules | `CLAUDE.md` |
| Role definitions | `.claude/agents/<role>.md` |
| Each role's memory | `.claude/agent-memory/<role>/` |
| Gotchas per code area | `<area>/CLAUDE.md` |
| Workspaces for business roles | `business/<function>/` |
| Product, brand, decisions | `docs/` |
| Team workflows | `.claude/skills/` |
| Backlog (owned by the PM) | `docs/backlog.md` |
| Your memo, if you started from one | `docs/memo.md` |

Guardrails built in:
- Business agents draft but never publish, post, send outreach, sign up for services or move money.
- Factual claims need sources.
- No role gets both terminal access and web page fetching.
- The advisor advises only.

## Known limits (Claude Code 2.1.280)

- A team lasts for one session; roles and memory persist on disk.
- One team per session, and 3–5 teammates at a time is practical.
- In tmux pane mode, `skills:` in a role file is ignored, so roles name the skills they should load.
- Each teammate costs roughly a full session's tokens.

## License

MIT — see [LICENSE](LICENSE).
