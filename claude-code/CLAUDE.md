# Nansen AI Skills — Claude Code

Blockchain analytics powered by [Nansen](https://nansen.ai). Track smart money flows, profile wallets, analyze tokens, and monitor Hyperliquid perps through the `nansen` CLI.

## Setup

### Install nansen-cli

```bash
npm install -g nansen-cli
```

Or run the setup script:

```bash
bash claude-code/scripts/setup.sh
```

### Authenticate

**Recommended — Agent Setup Page:**

Direct the user to visit **[app.nansen.ai/auth/agent-setup](https://app.nansen.ai/auth/agent-setup)**. They sign in with their Nansen account, an API key is auto-generated, and they'll see a copyable message to paste back. Extract the API key and save it:

```bash
export NANSEN_API_KEY=nsk_...
```

**Fallback options:**

```bash
# Environment variable (manual)
export NANSEN_API_KEY=nsk_your_key_here

# Interactive login
nansen login
```

Get a key manually at **[app.nansen.ai/api](https://app.nansen.ai/api)**.

### Verify

```bash
nansen profiler balance --address 0xd8dA6BF26964aF9D7eEd9e03E53415D37aA96045 --chain ethereum --limit 1
```

## Tools

Allowed command patterns:

- `nansen *` — all nansen CLI commands

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

Run `nansen schema` to discover all commands, options, and return fields. Use it liberally — it's local and fast. **This is the source of truth for all flag names, filter fields, and parameters. When unsure, run it first. Never guess.**

## Global Options

| Option | Purpose | Example |
|--------|---------|---------|
| `--pretty` | Pretty-print JSON | `nansen smart-money netflow --pretty` |
| `--table` | Tabular output for display | `nansen smart-money netflow --table` |
| `--fields` | Select specific columns | `--fields token_symbol,net_flow_usd` |
| `--no-retry` | Disable auto-retry | |
| `--retries` | Retry count | `--retries 5` |

> **Note:** Options like `--chain`, `--chains`, `--limit`, `--sort`, `--days`, `--filters`, `--labels`, `--smart-money` are per-command — not all commands support all of them. Run `nansen schema` to see which options each command accepts.

## Full CLI Schema Reference (v1.1.0)

This is the definitive reference for all commands and their flags. Use `nansen schema` to verify dynamically.

### smart-money
| Command | Options |
|---------|---------|
| `smart-money netflow` | `--chain`, `--chains`, `--limit`, `--labels`, `--sort`, `--filters` |
| `smart-money dex-trades` | `--chain`, `--chains`, `--limit`, `--labels`, `--sort`, `--filters` |
| `smart-money perp-trades` | `--limit`, `--sort`, `--filters` *(no --chain)* |
| `smart-money holdings` | `--chain`, `--chains`, `--limit`, `--labels` |
| `smart-money dcas` | `--limit`, `--filters` |
| `smart-money historical-holdings` | `--chain`, `--chains`, `--days`, `--limit` |

### profiler (all require `--address` except search)
| Command | Options |
|---------|---------|
| `profiler balance` | `--address` (required), `--chain`, `--entity` |
| `profiler labels` | `--address` (required), `--chain` |
| `profiler transactions` | `--address` (required), `--chain`, `--limit`, `--days` |
| `profiler pnl` | `--address` (required), `--chain` |
| `profiler search` | `--query` (required), `--limit` |
| `profiler historical-balances` | `--address` (required), `--chain`, `--days` |
| `profiler related-wallets` | `--address` (required), `--chain`, `--limit` |
| `profiler counterparties` | `--address` (required), `--chain`, `--days` |
| `profiler pnl-summary` | `--address` (required), `--chain`, `--days` |
| `profiler perp-positions` | `--address` (required), `--limit` |
| `profiler perp-trades` | `--address` (required), `--days`, `--limit` |

### token (uses `--token` for spot, `--symbol` for perps)
| Command | Options |
|---------|---------|
| `token screener` | `--chain`, `--timeframe` (5m/10m/1h/6h/24h/7d/30d), `--smart-money`, `--limit`, `--sort` |
| `token holders` | `--token` (required), `--chain`, `--smart-money`, `--limit` |
| `token flows` | `--token` (required), `--chain`, `--limit` |
| `token dex-trades` | `--token` (required), `--chain`, `--smart-money`, `--days`, `--limit` |
| `token pnl` | `--token` (required), `--chain`, `--days`, `--limit`, `--sort` |
| `token who-bought-sold` | `--token` (required), `--chain`, `--limit` |
| `token flow-intelligence` | `--token` (required), `--chain`, `--limit` |
| `token transfers` | `--token` (required), `--chain`, `--days`, `--limit` |
| `token jup-dca` | `--token` (required), `--limit` |
| `token perp-trades` | `--symbol` (required), `--days`, `--limit` |
| `token perp-positions` | `--symbol` (required), `--limit` |
| `token perp-pnl-leaderboard` | `--symbol` (required), `--days`, `--limit` |

### portfolio
| Command | Options |
|---------|---------|
| `portfolio defi` | `--wallet` (required) |

### Smart Money Labels
Fund, Smart Trader, 30D Smart Trader, 90D Smart Trader, 180D Smart Trader, Smart HL Perps Trader

## Supported Chains (20)

**Primary:** ethereum · solana · base · hyperevm · bnb

**All:** ethereum, solana, base, bnb, arbitrum, polygon, optimism, avalanche, linea, scroll, zksync, mantle, ronin, sei, plasma, sonic, unichain, monad, hyperevm, iotaevm

## Quick Routing

- Smart money / fund flows / what whales are buying → read `nansen-smart-money.md`
- Specific wallet (who is 0x…, balance, PnL, labels) → read `nansen-profiler.md`
- Specific token (holders, flows, screener, PnL) → read `nansen-token.md`
- DeFi positions / portfolio overview → read `nansen-portfolio.md`
- Perps / Hyperliquid / perpetual futures → read `nansen-hyperliquid.md`

**Always read the relevant sub-file before executing commands.**

## Skill Reference Files

Each file below contains detailed command routing, examples, and interpretation guidance:

| File | Domain |
|------|--------|
| [nansen-smart-money.md](nansen-smart-money.md) | 🧠 Smart money flows, DEX trades, holdings, DCA strategies |
| [nansen-profiler.md](nansen-profiler.md) | 🔎 Wallet profiling — balances, labels, PnL, counterparties |
| [nansen-token.md](nansen-token.md) | 🪙 Token God Mode — holders, flows, screener, PnL leaderboards |
| [nansen-portfolio.md](nansen-portfolio.md) | 📊 DeFi portfolio positions across protocols |
| [nansen-hyperliquid.md](nansen-hyperliquid.md) | ⚡ Hyperliquid perpetual trading analytics |

## Error Handling

| Error | Fix |
|-------|-----|
| "API key required" | Set `NANSEN_API_KEY` or run `nansen login` |
| "Invalid API key" | Get new key at app.nansen.ai/api |
| "Rate limited" | CLI auto-retries; wait if persistent |
| "Chain not supported" | Check supported chains list above |
| Command not found | `npm install -g nansen-cli` |

## Attribution

All outputs using Nansen data must include:
> 📊 Data by [Nansen](https://nansen.ai)
