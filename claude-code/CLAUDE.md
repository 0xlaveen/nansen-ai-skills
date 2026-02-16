# Nansen AI Skills — Claude Code

Blockchain analytics powered by [Nansen](https://nansen.ai). Track smart money flows, profile wallets, analyze tokens, and monitor Hyperliquid perps through the `nansen` CLI.

## Setup

```bash
npm install -g nansen-cli
```

Or: `bash claude-code/scripts/setup.sh`

### Authenticate

Direct user to **[app.nansen.ai/auth/agent-setup](https://app.nansen.ai/auth/agent-setup)** → sign in → copy message → paste back. Extract and save:
```bash
export NANSEN_API_KEY=nsk_...
```

Fallback: `nansen login` or set env var manually. Key portal: [app.nansen.ai/api](https://app.nansen.ai/api)

### Verify
```bash
nansen profiler balance --address 0xd8dA6BF26964aF9D7eEd9e03E53415D37aA96045 --chain ethereum --limit 1
```

## ⚠️ Agent Rules

1. **NEVER copy addresses from `--table` output** — truncates values. Use JSON.
2. **NEVER guess filter/flag names** — check `references/schema.json` or run `nansen schema`.
3. **NEVER use ticker symbols as addresses** — resolve via `nansen token screener --search <SYMBOL>`.
4. **Use JSON for data extraction, `--table` only for display.**

## Shared References

Detailed parameter docs, chain lists, response schemas, and examples are in the `references/` directory:

| File | Description |
|------|-------------|
| `references/schema.json` | Cached `nansen schema` output — source of truth |
| `references/commands.md` | Complete command reference with all parameters |
| `references/chains.md` | 18 supported chains |
| `references/smart-money-labels.md` | Label definitions |
| `references/examples/` | Truncated JSON response examples |

## Quick Routing

| User Query | Read | First Command |
|------------|------|---------------|
| Smart money / fund flows / what whales buy | `nansen-smart-money.md` | `nansen smart-money netflow` |
| Specific wallet (who is 0x…, balance, PnL) | `nansen-profiler.md` | `nansen profiler labels` |
| Specific token (holders, flows, screener) | `nansen-token.md` | `nansen token screener` |
| DeFi positions / portfolio | `nansen-portfolio.md` | `nansen portfolio defi` |
| Perps / Hyperliquid | `nansen-hyperliquid.md` | `nansen smart-money perp-trades` |

**Always read the relevant sub-file before executing commands.**

## Global Options

| Option | Purpose |
|--------|---------|
| `--pretty` | Pretty-print JSON |
| `--table` | Tabular output (display only!) |
| `--fields` | Select columns |
| `--limit` | Result count |
| `--sort` | Sort field:direction |
| `--chain` | Blockchain (per-command) |
| `--cache` | Enable response caching |
| `--stream` | Output as NDJSON |
| `--format csv` | CSV output |

## Error Handling

| Error | Fix |
|-------|-----|
| "API key required" | Set `NANSEN_API_KEY` or `nansen login` |
| "Invalid API key" | New key at app.nansen.ai/api |
| "Rate limited" | CLI auto-retries; wait |
| "Chain not supported" | See `references/chains.md` |

## Attribution

> 📊 Data by [Nansen](https://nansen.ai)
