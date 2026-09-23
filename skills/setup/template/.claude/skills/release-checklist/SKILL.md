---
name: release-checklist
description: Pre-release checks before merging to main or deploying to production.
---
# Release checklist

- [ ] Tests and typecheck pass: `<test command>`, `<typecheck command>`
- [ ] New env vars added to `.env.example` and to the hosting provider
- [ ] Migrations reviewed and reversible (or rollback plan written)
- [ ] <review role> has reviewed any auth, payment, or user-data change
- [ ] User-facing change? Changelog entry and docs updated
- [ ] Every goal in this release passed `goal-complete`
- [ ] Knowledge pass done
<!-- Replace placeholders with real commands, deploy steps, and the project's review role. Drop the review line if the team has no review role. -->
