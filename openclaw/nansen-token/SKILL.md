---
name: nansen-token
description: >-
  Token God Mode analytics via Nansen CLI. Screen tokens, analyze holders, track
  flows, see who's buying/selling, PnL leaderboards, and flow intelligence by label.
  Use when the user asks about a specific token's holders, smart money activity on a
  token, token screening/discovery, or DEX trading activity for a token.
metadata:
  clawdbot:
    emoji: "🪙"
    homepage: "https://nansen.ai"
    requires:
      bins: ["nansen"]
---

# Nansen Token — Token God Mode

Deep analytics for any token: holders, flows, trades, PnL, and discovery.

## ⚠️ Agent Rules — Read Before Running Commands

> These rules exist because real agents made these exact mistakes. Follow them strictly.

1. **NEVER copy addresses from `--table` output** — table output truncates long values. Always use default JSON or `--pretty` when extracting addresses.
2. **NEVER guess filter/flag names** — run `nansen schema` first to verify valid parameters.
3. **NEVER use ticker symbols as addresses** — resolve tickers first (see workflow below).
4. **Use JSON for data extraction, `--table` only for final display.**

### Ticker-to-Address Resolution Workflow

When a user asks about a token by name or ticker symbol:

```
Step 1: User says "show me PENGU holders"
Step 2: Resolve address: nansen token screener --search PENGU --chain solana
Step 3: Copy FULL address from JSON output (NOT from --table, which truncates)
Step 4: Use address: nansen token holders --token-address <full_address> --chain solana
```

**Never skip Step 2.** Never fabricate or guess an address.

## When This Skill Activates

- "Who holds $TOKEN?" / "Top holders of X"
- "Who's buying/selling $TOKEN?"
- "Screen tokens by smart money interest"
- "Token flows for $TOKEN"
- "PnL leaderboard for $TOKEN"
- "DEX trading activity for $TOKEN"
- "Show me flow intelligence / label breakdown"

## Prerequisites

Requires **nansen-core** skill for auth. Verify with: `nansen schema`

## Command Routing

| User Intent | Command | Key Options |
|------------|---------|-------------|
| Discover/filter tokens | `nansen token screener` | `--chain`, `--sort`, `--limit`, `--smart-money` |
| Token holder breakdown | `nansen token holders` | `--token-address`, `--chain` |
| Token flow metrics (in/out) | `nansen token flows` | `--token-address`, `--chain`, `--days` |
| DEX trading activity | `nansen token dex-trades` | `--token-address`, `--chain`, `--limit` |
| PnL leaderboard for a token | `nansen token pnl` | `--token-address`, `--chain` |
| Recent buyers and sellers | `nansen token who-bought-sold` | `--token-address`, `--chain` |
| Flow intelligence by label | `nansen token flow-intelligence` | `--token-address`, `--chain` |
| Transfer history | `nansen token transfers` | `--token-address`, `--chain`, `--days` |
| Jupiter DCA orders | `nansen token jup-dca` | `--token-address` (Solana) |

> For perpetual/perps data, see **nansen-hyperliquid**.

> **Tip:** Run `nansen schema` for full option details.

## ⚠️ Step 1: Token Address Resolution

Most commands require a token contract address. If the user gives a ticker symbol, first help them find the address using:

```bash
nansen token screener --search <symbol>
```

Or with filters:

```bash
nansen token screener --chain <chain> --filters '{"symbol": "TOKEN"}' --limit 5
```

Use the returned `token_address` in subsequent commands. **Always resolve the address before running other token commands.**

## Example Queries → Commands

### "Screen tokens with smart money interest on Ethereum"
```bash
nansen token screener --chain ethereum --sort smart_money_count:desc --limit 20 --table
```

### "Top holders of $TOKEN"
```bash
nansen token holders --token-address 0x... --chain ethereum --sort balance_usd:desc --limit 20 --table
```

### "Who's buying and selling $TOKEN?"
```bash
nansen token who-bought-sold --token-address 0x... --chain ethereum --table
```

### "Token flows for $TOKEN over 7 days"
```bash
nansen token flows --token-address 0x... --chain ethereum --days 7 --table
```

### "PnL leaderboard — who's profiting on $TOKEN?"
```bash
nansen token pnl --token-address 0x... --chain ethereum --sort realized_pnl:desc --limit 20 --table
```

### "DEX trades for $TOKEN"
```bash
nansen token dex-trades --token-address 0x... --chain ethereum --limit 30 --table
```

### "Flow intelligence — which labels are buying?"
```bash
nansen token flow-intelligence --token-address 0x... --chain ethereum --table
```

### "Transfer history"
```bash
nansen token transfers --token-address 0x... --chain ethereum --days 7 --limit 50 --table
```

## Token Discovery Workflow

For investigating a token end-to-end:

1. **Screener** — Find interesting tokens by smart money metrics
2. **Holders** — Who holds it? Any smart money?
3. **Who Bought/Sold** — Recent activity
4. **Flow Intelligence** — Label-level breakdown (funds vs. smart traders vs. retail)
5. **PnL** — Who's profiting?
6. **Flows** — Net in/out over time

## Output Formatting

- Use `--table` for user-facing output
- For holder analysis, show top 10–20 with labels when available
- For PnL leaderboards, highlight top gainers and biggest losers
- For flow intelligence, present as label → net flow summary

## Combining with Other Skills

- See a wallet in holders? → Use **nansen-profiler** to identify them
- See smart money activity? → Use **nansen-smart-money** for broader flows
- Token has perp markets? → Use **nansen-hyperliquid** for perp analysis


## Troubleshooting

- **Empty results?** Try a different `--chain`, broaden `--days`, or increase `--limit`. Not all data is available on every chain.
- **Auth errors ("API key required" / "unauthorized")?** Set up via [app.nansen.ai/auth/agent-setup](https://app.nansen.ai/auth/agent-setup), or set `NANSEN_API_KEY` env var, or run `nansen login`.
- **"Chain not supported"?** Check the 20 supported chains in nansen-core. Use exact lowercase names (e.g., `ethereum`, `bnb`, `hyperevm`).
- **Invalid address?** EVM addresses must be `0x` + 40 hex chars. Solana addresses are Base58 (32-44 chars). ENS names may not be resolved by the CLI.

## Attribution

All outputs must include:
> 📊 Data by [Nansen](https://nansen.ai)
