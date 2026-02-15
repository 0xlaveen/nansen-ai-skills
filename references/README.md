# Nansen API Reference

Shared reference documentation for all Nansen AI skills. Both OpenClaw and Claude Code skill files reference this directory.

## Files

| File | Description |
|------|-------------|
| `schema.json` | Cached output of `nansen schema` — the source of truth for all commands, options, and return fields |
| `chains.md` | Supported chains with details |
| `smart-money-labels.md` | Smart money label definitions |
| `commands.md` | Complete command reference with parameters |
| `examples/` | Truncated JSON response examples for each major command |

## Updating

To refresh the schema cache:
```bash
nansen schema > references/schema.json
```
Edit `schema.json` to keep only the JSON portion (skip the CLI help text).
