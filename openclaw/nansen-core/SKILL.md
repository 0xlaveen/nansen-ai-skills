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

## Setup & Authentication

### 1. Check if CLI is installed

```bash
which nansen && nansen --version
```

If not installed:
```bash
npm install -g nansen-cli
```

### 2. Check if authenticated

```bash
nansen profiler balance --wallet 0xd8dA6BF26964aF9D7eEd9e03E53415D37aA96045 --chain ethereum --limit 1 2>&1
```

If it returns JSON data → auth is good. If it mentions API key / unauthorized → needs setup.

### 3. Authenticate

**Recommended — Agent Setup Page:**

Direct the user to visit **https://app.nansen.ai/auth/agent-setup**. They sign in with their Nansen account, an API key is auto-generated, and they'll see a copyable message to paste back to you. Extract the API key from their message and save it:

```bash
export NANSEN_API_KEY=nsk_...
```

Save it as a persistent environment variable so it survives restarts.

**Fallback options:**

- **Environment variable:** User manually sets `NANSEN_API_KEY=nsk_...`
- **Interactive login:** `nansen login`
- **Get a key manually:** https://app.nansen.ai/api

> **⚠️ Never ask users to paste API keys in chat.** Direct them to the setup page or to set environment variables.

### Auth Priority Order
1. `NANSEN_API_KEY` environment variable (highest)
2. `~/.nansen/config.json` (saved via `nansen login`)

## ⚠️ Agent Rules — Read Before Running Commands

> These rules exist because real agents made these exact mistakes. Follow them strictly.

1. **NEVER copy addresses from `--table` output** — table output truncates long values like addresses. Always use default JSON or `--pretty` output when you need to extract full addresses, then use `--table` only for final user-facing display.

2. **NEVER guess filter or flag names** — always run `nansen schema` to verify valid parameters before using `--filters`. If a filter field looks right but you have not confirmed it in the schema, it is wrong. **When unsure about ANY flag name, filter field, or parameter — run `nansen schema` first. Never guess.**

3. **NEVER use ticker symbols as contract addresses** — the CLI requires contract addresses, not ticker symbols like "PENGU" or "PEPE". If the user gives a ticker, resolve it first:
   ```bash
   nansen token screener --search <SYMBOL> --chain <chain>
   ```
   Then copy the FULL `token_address` from the JSON output.

4. **Use JSON output for data extraction, `--table` only for display** — when you need to extract addresses, IDs, or any values for use in subsequent commands, use default JSON or `--pretty` output. Use `--table` only when presenting final results to the user.

## Schema Introspection

```bash
nansen schema
```

Returns a complete JSON schema of every command, subcommand, option, and field. **This is the source of truth for all flag names, filter fields, and parameters. When unsure, run it first. Never guess.**

Use it when:
- You need to discover available options for a command
- You're unsure which fields a command returns
- You want to verify filter/sort options

**Use `nansen schema` liberally.** It's local, fast, and always current.

## Commands

| Command | Purpose | Key Options |
|---------|---------|-------------|
| `nansen login` | Interactive API key setup | — |
| `nansen logout` | Remove saved credentials | — |
| `nansen schema` | Full JSON schema (agent introspection) | — |

## Global Options (Apply to All Commands)

| Option | Purpose | Example |
|--------|---------|---------|
| `--pretty` | Pretty-print JSON | `nansen smart-money netflow --pretty` |
| `--table` | Tabular output for display | `nansen smart-money netflow --table` |
| `--fields` | Select specific columns | `--fields token_symbol,net_flow_usd` |
| `--chain` | Filter by blockchain | `--chain ethereum` |
| `--chains` | Multiple chains | `--chains ethereum,solana` |
| `--limit` | Max results | `--limit 20` |
| `--sort` | Sort field + direction | `--sort net_flow_usd:desc` |
| `--days` | Date range (days back) | `--days 7` |
| `--filters` | Advanced JSON filter | `--filters '{"min_usd": 10000}'` |
| `--no-retry` | Disable auto-retry | |
| `--retries` | Retry count | `--retries 5` |

## Supported Chains

**Primary:** `ethereum`, `solana`, `base`, `hyperevm`, `bnb`

**All 20:** ethereum, solana, base, bnb, arbitrum, polygon, optimism, avalanche, linea, scroll, zksync, mantle, ronin, sei, plasma, sonic, unichain, monad, hyperevm, iotaevm

## Output Formatting Guidance

- **For agent processing:** Use default JSON output (no flags)
- **For user display:** Use `--table` for readable tables, `--pretty` for indented JSON
- **For specific data:** Use `--fields` to reduce noise
- **For large results:** Use `--limit` to control volume, `--sort` to get most relevant first

## Error Handling

| Error | Cause | Fix |
|-------|-------|-----|
| "API key required" | No auth configured | Set `NANSEN_API_KEY` or run `nansen login` |
| "Invalid API key" | Key is wrong/expired | Get new key at app.nansen.ai/api |
| "Rate limited" | Too many requests | CLI auto-retries with backoff; wait if persistent |
| "Chain not supported" | Invalid chain name | Check supported chains list above |
| Command not found | CLI not installed | `npm install -g nansen-cli` |
| JSON parse error | Malformed `--filters` value | Ensure valid JSON string |

## Attribution

All outputs using Nansen data must include:
> 📊 Data by [Nansen](https://nansen.ai)
