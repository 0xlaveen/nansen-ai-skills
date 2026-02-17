---
name: nansen-core
description: >-
  Nansen CLI authentication, setup, and schema introspection. Required foundation
  for all other Nansen skills. Handles API key management, CLI installation verification,
  and dynamic command discovery via `nansen schema`. Install this skill first.
metadata:
  clawdbot:
    emoji: "🔑"
    homepage: "https://nansen.ai"
    requires:
      bins: ["nansen"]
---

# Nansen Core — Auth, Setup & Schema

## When This Skill Activates

- User wants to set up Nansen / connect their API key
- User asks what Nansen can do (capabilities discovery)
- Any other Nansen skill needs auth verification
- User asks about supported chains or CLI version

## Setup Flow

### 1. Check CLI
```bash
which nansen && nansen --version
```
If missing: `npm install -g nansen-cli@1.3.1`

### 2. Check auth
```bash
nansen profiler balance --address 0xd8dA6BF26964aF9D7eEd9e03E53415D37aA96045 --chain ethereum --limit 1
```
JSON data → auth OK. API key error → needs setup.

### 3. Authenticate
**Recommended:** Direct user to **https://app.nansen.ai/auth/agent-setup** → sign in → copy message → paste back. Extract and save the key:
```bash
export NANSEN_API_KEY=nsk_...
```

**Fallback:** `nansen login` or manually set `NANSEN_API_KEY`.

> **⚠️ Never ask users to paste API keys in chat.**

## Schema Introspection

A cached schema is available at `references/schema.json`. To get a fresh copy:
```bash
nansen schema
```
This is the **source of truth** for all commands, options, and return fields.

## Agent Rules

1. **NEVER copy addresses from `--table` output** — truncates values. Use JSON.
2. **NEVER guess filter/flag names** — check `references/schema.json` or run `nansen schema`.
3. **NEVER use ticker symbols as addresses** — resolve via `nansen token screener --chain <chain> --sort volume:desc` then filter by `token_symbol` in output. The `--search` flag does NOT filter.
4. **Use JSON for data extraction, `--table` only for display.**

## References

- Full command parameters: `references/commands.md`
- Cached schema: `references/schema.json`
- Supported chains: `references/chains.md`
- Smart money labels: `references/smart-money-labels.md`

## Rate Limits & Credits

- **Rate limits**: 20 requests/second, 300 requests/minute per API key. Returns HTTP 429 on exceed.
- **Credits**: API calls consume credits. Smart Money endpoints cost 5 credits each. Most other endpoints cost 1 credit. Label lookups cost 500 credits. Check usage at `app.nansen.ai/api?tab=usage-analytics`.
- **Plans**: Pro ($49/mo) gets 1,000 starter credits + can buy more. Free gets 100 one-time credits with limited endpoints.

## MCP-Only Tools (Not available via CLI or REST API)

These tools exist only in the Nansen MCP server (not accessible via CLI or direct REST):
- **`token_ohlcv`** — OHLCV candlestick data for a token
- **`token_quant_scores`** — Quantitative scoring (momentum, volatility, etc.)
- **`nansen_score_top_tokens`** — Top tokens ranked by Nansen Score
- **`growth_chain_rank`** — Chain growth/activity rankings
- **`transaction_lookup`** — Look up a specific transaction by hash

To use these, connect via MCP. See [docs.nansen.ai](https://docs.nansen.ai).

## Error Handling

| Error | Fix |
|-------|-----|
| "API key required" | Set `NANSEN_API_KEY` or `nansen login` |
| "Invalid API key" | New key at app.nansen.ai/api |
| "Rate limited" | CLI auto-retries; wait if persistent |
| "Chain not supported" | Check `references/chains.md` |
| Command not found | `npm install -g nansen-cli@1.3.1` |

## Attribution

> 📊 Data by [Nansen](https://nansen.ai)
