# Upgrading an existing HQ

Brings an HQ that an older agent-hq version generated up to date with the current version's **shared parts**, and leaves everything the founder or the agents wrote alone.

## What upgrade may change (shared parts)

| Part | How |
|---|---|
| Team protocol in each role: `## How you work on the team` and `## Your memory` | Apply only the line-level changes the changelog lists (add, or replace the named line). Never replace these sections wholesale: founders add their own lines there (e.g. extra team rules), and those must survive. |
| `CLAUDE.md` → `## Working as a team (no races)` | Replace that one section with the current template's version. Add it if it's missing. |
| Team skills in `.claude/skills/` that come from the template | Add missing ones. For existing ones, apply the changes listed in the changelog below, keeping project-specific values (real commands, review role name, extra checks). Never replace one wholesale. |
| `scripts/team.sh` | Replace with the current template, unless the founder changed it (then show the difference and ask). Remove scripts the changelog retired. |
| `.claude/settings.json` | Merge any new required keys. Never remove keys. |
| `.claude/agent-hq.json` | Update `version`. |

## What upgrade never touches

- Each role's frontmatter and its own sections (identity, `You own`, `Rules`, `How you work`, `You don't`).
- Agent memory (`.claude/agent-memory/`).
- Workspaces (`business/`, area `CLAUDE.md` files, `product/` etc.), `docs/` content, the backlog's items, decision records.
- Roles or skills the founder added that aren't from the template.

## Procedure

1. **Safety.** Run `git status`. If there are uncommitted changes, ask the founder to commit first (offer the command) and stop until they have. Upgrade must be undoable with git.
2. **Version.** Read `.claude/agent-hq.json`. If it's missing, the HQ predates 0.6.0: work out which changelog entries already apply by checking for their markers (listed per entry).
3. **Plan.** For each changelog entry newer than the HQ's version (or whose marker is missing), list the concrete edits per file. Show the founder the plan in one short list, grouped by file.
4. **Apply** after the founder confirms (in no-questions mode, apply and report).
5. **Verify** with the setup skill's verify checklist (step 5), limited to the shared parts.
6. **Report** what changed per file, what was left alone, and: "Review with `git diff`; undo with `git checkout -- .`." Remind them to restart running teams so teammates pick up the new instructions. Don't commit.

## Changelog of shared parts

Newest first. Each entry has a **marker** to detect whether an HQ already has it.

### 0.8.0
- New project skill `.claude/skills/ui-skills/SKILL.md` if any role produces UI (save the output of `npx -y ui-skills start`; fall back to the template stub). Marker: the file exists.
- UI-producing roles (design, frontend, web, mobile, landing pages): add the UI Skills rule from `role-spec.md` verbatim to the role's `## Rules` (the second exception to "never touch role sections"), replacing any older, softer ui-skills line; add `Bash` to its tools if missing. Marker: `UI work follows UI Skills strictly`.

### 0.7.1
- Upgrade itself: protocol sections are now edited line by line, never replaced wholesale. No HQ changes.

### 0.7.0
- Team protocol: replaces the "When your task is done, report to the lead…" line with the messaging rules (full results in files; ≤5-line reports to the lead; progress in the task list; message peers directly; batch requests to the lead; summarize fanned-out work into one file). Marker: `Keep the lead's context clean`.

### 0.6.0
- Adds `.claude/agent-hq.json` (`{"version": "<current>"}`). Marker: the file exists.

### 0.5.0
- Team protocol: adds the rule "Never assume anything about the product or about another role's area…" right after the SendMessage line. Marker: `Never assume anything about the product` in a role file.

### 0.4.0
- Team protocol: adds "Not in a team (no SendMessage tool…)? Work the same way, but report and ask questions directly to the founder." after the permission line. Marker: `Not in a team (no SendMessage tool`.

### 0.3.x
- `scripts/advisor.sh` retired: delete it; the advisor is spawned as a pane teammate. Marker: the script is absent.
- `team-kickoff`: adds the step "Strategic goals get the advisor." Marker: `Strategic goals get the advisor`.
- `goal-complete`: adds the step "Advisor check". Marker: `Advisor check`.
- Advisor role (its own `How you work`, the one exception to "never touch role sections", only if the role is the template's advisor): adds "The founder talks to you directly in your pane…" and "When the lead brings you into a goal…". Marker: `directly in your pane`.
- New skill `knowledge-review` and a "Monthly knowledge review" recurring item in `docs/backlog.md` (add the item only; don't touch other items). Marker: `.claude/skills/knowledge-review/` exists.
- Memory section: adds the "Working solo (not in a team)?" line. Marker: `Working solo`.
- Workspace `CLAUDE.md` files get a "What's here" section if missing (add an empty one; don't reorganize the file). Marker: `What's here`.
