# Changelog

## [1.0.0] - 2026-02-15

### Added
- **`references/` directory** — shared API docs, cached schema, chain list, label definitions, and example responses
- **`references/schema.json`** — cached `nansen schema` output; skills reference this instead of running the command each time
- **`references/examples/`** — truncated JSON response examples for each major command domain
- **`openclaw/nansen-router/`** — routing/orchestrator skill that acts as the entry point for all Nansen queries
- **`CHANGELOG.md`** — this file

### Changed
- **OpenClaw skills** — refactored to be concise (routing + rules + examples); detailed parameter docs moved to `references/`
- **Claude Code skills** — streamlined per-domain `.md` files; reference shared `references/` directory
- **`README.md`** — updated to reflect new structure, router skill, and references directory

### Removed
- **`nansen-cluster-detective`** — removed from both openclaw/ and claude-code/ (not validated; delegation gap, param bugs). Will be re-added after validation.
