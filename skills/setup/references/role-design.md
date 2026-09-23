# Designing roles from a project

Roles come from two sources, not from a menu:
- **The codebase** — the product's real engineering areas (section 1).
- **The founder's direction** — the business functions a solo founder needs covered, most of which never appear in code: marketing, business planning, finance, sales, support, legal/compliance research, hiring (section 2).

A good team for a pre-launch B2B tool with no users looks nothing like one for a revenue-generating consumer app.

## 1. Map the engineering areas

Collect evidence, then group it into areas: each area is a slice of work with its own files, conventions, and risks.

| Evidence | Suggests an area like |
|---|---|
| Server framework, routes, ORM, migrations | API / backend (or split: `api` + `data-model` if the schema is large and busy) |
| Web framework, pages, components | web app |
| Separate marketing site, blog, SEO config, CMS | marketing site (distinct from the product UI) |
| `ios/`, `android/`, Expo, Flutter, React Native | mobile |
| Queue workers, cron, background jobs | jobs / workers (fold into backend unless substantial) |
| Stripe/Paddle/LemonSqueezy, webhooks, entitlements | billing (split out when payments logic is spread across the app) |
| Auth library, RBAC, multi-tenancy | auth & access (usually a review concern, not an owner role) |
| Dockerfiles, IaC (Terraform, Pulumi, SST), CI/CD, deploy scripts | infra / devops |
| Notebooks, training code, embeddings, vector DB, prompts, evals | ML / AI features |
| dbt, warehouse, analytics SQL, event tracking | data & analytics |
| Design tokens, component library, Storybook | design system |
| Any UI to build (web app, landing pages, mobile) with no designer yet | recommend a `designer` role that owns design direction, tokens, components, and prototypes (see `examples/roles/designer.md`) |
| Public docs site, API reference, SDKs | docs / developer experience |
| Browser extension, CLI, desktop app | its own surface |

Weigh each area by **how much ongoing work** it gets (recent git activity, size, the founder's stated focus). An area that barely changes doesn't need its own role.

## 2. Map the business functions

These come from the founder, not the repo. Ask what they want help with, then recommend functions based on the company's stage:

| Stage | Functions that usually pay off |
|---|---|
| Idea / pre-build | business planning (market, positioning, business model), research |
| Building / pre-launch | marketing (positioning, landing copy, launch plan), business planning |
| Launched, early revenue | marketing, growth/content, sales or support, finance (pricing, runway, metrics) |
| Growing | finance, sales, support, ops/hiring, legal/compliance research |

Common business roles and what they own:

| Role (example name) | Owns | Typical deliverables |
|---|---|---|
| `marketing` | `business/marketing/` | positioning, messaging, launch plans, campaign briefs, landing-page and email copy |
| `content` | `business/content/` | content calendar, blog/social drafts, scripts (e.g. TikTok, YouTube) |
| `business-planner` | `business/strategy/` | market and competitor research, business model, pricing strategy, roadmap priorities, OKRs |
| `finance` | `business/finance/` | runway and burn model, pricing math, unit economics, revenue metrics, budget, fundraising prep |
| `sales` | `business/sales/` | ICP, outreach sequences, pipeline notes, objection handling |
| `support` | `business/support/` | help docs, reply templates, feedback synthesis into product input |
| `legal-research` | `business/legal/` | terms/privacy drafts, compliance checklists — always "research, not legal advice; have a lawyer review" |
| `ops` | `business/ops/` | processes, tooling choices, hiring plans, vendor comparisons |
| `pm` | `docs/backlog.md`, `business/pm/` | the backlog across sessions (items with owner role, priority, status, goal), proposing the next goal before each kickoff, turning accepted decisions and found bugs into items, status reports, and the monthly `knowledge-review`. Optional sync with GitHub Issues (`gh`) or a tracker's project-scoped MCP server. Always included. See `examples/roles/pm.md`. |
| `advisor` | `business/advisor/` | investor-style reviews via the `idea-review` skill: validates, steers, and improves the idea; proposes experiments. Recommend it at every stage. See `examples/roles/advisor.md`. |

Each business role owns a folder under `business/` (or the project's existing equivalent, e.g. `docs/marketing/`). That folder is its workspace and gets its own `CLAUDE.md` for shared knowledge in that function (brand voice lives with marketing, pricing decisions with finance), exactly like code areas.

The founder's direction wins: if they name a function, include it even if the stage table wouldn't; if they say they do something themselves (e.g. "I post on TikTok"), don't create a role that replaces them — offer a supporting one instead (e.g. `content` drafts scripts, the founder posts).

## 3. Turn areas and functions into roles

**Operations vs. product.** Before creating a role for an operation (sourcing suppliers, matching, payouts, onboarding, support triage…), check whether the product itself is meant to do that work. If it is, the operation isn't a separate business function — it *is* the product:
- Create or extend a **`product`** role that owns the rules and specs for that operation (criteria, policies, flows, templates). While the operation is still manual, the founder runs it using those docs; as it's automated, the same docs become the spec engineering builds from.
- Don't create an ops role that would have to be retired once the feature ships.
- Only create an operations role for work the product will never do (e.g. the founder's own sales, legal, bookkeeping).

- **One owner role per active area.** Ownership is a set of paths plus a responsibility.
- **Merge small areas** into a neighbour (workers into backend, design system into web) rather than creating thin roles.
- **Split big areas** only when two halves have different expertise and change independently (e.g. `api` vs `billing`).
- **Business roles** follow the same rule: one role per function the founder actually wants covered. Merge thin ones (e.g. `sales` + `support` early on).
- **The advisor is recommended for every solo founder** (it replaces the co-founder or investor who would push back). It advises only: no authority over other roles, no code, writes only its notes and — after the founder accepts a change — decision records and `docs/product.md`. It needs `SendMessage` in `tools` to ask teammates for status.
- **Add a cross-cutting role only when it pays for itself:**
  - *Planning* (e.g. `architect`, `tech-lead`): when features routinely span 2+ areas.
  - *Testing* (e.g. `qa`): when there's a test suite worth maintaining or the founder wants verification separated from building.
  - *Review* (e.g. `security-reviewer`): read-only; justified by auth, payments, PII, multi-tenancy, or public APIs.
- **Name roles after the work, in the project's language** (`billing`, `ios`, `pipeline`, `marketing`, `finance`), lowercase kebab-case, unique.
- **Business roles and engineering roles coordinate through the lead**, and directly when their work touches (marketing ↔ web for landing pages, finance ↔ billing for pricing changes). Write those handoffs into their rules.
- **Team size:** at setup, usually 3–4 roles plus the always-included pm and advisor, never more than 6 unless the founder asks; add more later as the work grows. A single team session runs 3–5 of them at once.

## 4. Pick tools and model per role

- **Tools:** builders get `Read, Grep, Glob, Bash, Write, Edit`. Reviewers get no `Write`/`Edit`. Research-heavy roles (marketing, business-planner, sales, legal-research) get `Read, Grep, Glob, Write, Edit, WebSearch, WebFetch` and no `Bash`. Roles that model numbers (finance) also get `Bash` so they can compute with scripts instead of doing math in their head — but then drop `WebFetch` and keep only `WebSearch`: a role that can both read arbitrary web pages and run commands is the easiest one for injected page content to steer into executing something. Apply the same rule to any role that needs both.
- **Model:** strongest model (`opus`) where mistakes are expensive or judgment-heavy: planning, security, billing, data migrations, finance, business strategy. `sonnet` for most building roles. `haiku` only for narrow, low-risk roles (docs, copy tweaks) when the founder wants to save cost.

## 5. Present the proposal

Show a compact table before writing anything:

| Role | Kind | Owns (paths) | Why this role | Model | Tools |
|---|---|---|---|---|---|

Kind is `engineering`, `business`, or `cross-cutting`.

Then the founder adds, removes, renames, or merges. Only generate confirmed roles.
