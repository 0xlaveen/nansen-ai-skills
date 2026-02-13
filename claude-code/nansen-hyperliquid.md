# Nansen Hyperliquid — Perpetual Trading Analytics

Track smart money perpetual trading on Hyperliquid.

## ⚠️ Agent Rules — Read Before Running Commands

> These rules exist because real agents made these exact mistakes. Follow them strictly.

1. **NEVER copy addresses from `--table` output** — table output truncates long values. Always use default JSON or `--pretty` when extracting addresses.
2. **NEVER guess filter/flag names** — run `nansen schema` first to verify valid parameters.
3. **Use JSON for data extraction, `--table` only for final display.**

## When to Use

- "What are smart money trading on Hyperliquid?"
- "Hyperliquid perp trades"
- "Open positions on Hyperliquid"
- "PnL leaderboard for Hyperliquid perps"
- "Perp trades for $BTC / $ETH on Hyperliquid"
- "Who's long/short on Hyperliquid?"
- Any mention of Hyperliquid + trading/perps/positions

## Command Routing

| User Intent | Command | Key Options |
|------------|---------|-------------|
| Smart money perp trades | `nansen smart-money perp-trades` | `--limit`, `--sort`, `--filters` *(no --chain)* |
| Perp trades by wallet | `nansen profiler perp-trades` | `--address` (required), `--days`, `--limit` |
| Current perp positions by wallet | `nansen profiler perp-positions` | `--address` (required), `--limit` |
| Perp trades by symbol | `nansen token perp-trades` | `--symbol` (required), `--days`, `--limit` |
| Open positions by symbol | `nansen token perp-positions` | `--symbol` (required), `--limit` |
| Perp PnL leaderboard by symbol | `nansen token perp-pnl-leaderboard` | `--symbol` (required), `--days`, `--limit` |

## Common Perp Symbols

BTC, ETH, SOL, DOGE, ARB, OP, AVAX, MATIC, LINK, UNI, AAVE, WIF, PEPE, JUP, TIA

## Smart Money Labels (Hyperliquid)

| Label | Description |
|-------|-------------|
| `Smart HL Perps Trader` | Consistently profitable on HL perps |
| `Fund` | Institutional fund wallets |
| `Smart Trader` | All-time profitable traders |

## Examples

### Smart money trades on Hyperliquid right now
```bash
nansen smart-money perp-trades --sort value_usd:desc --limit 20 --table
```

### Top PnL leaderboard for BTC perps
```bash
nansen token perp-pnl-leaderboard --symbol BTC --sort total_pnl:desc --limit 20 --table
```

### Open positions for BTC perps
```bash
nansen token perp-positions --symbol BTC --sort size_usd:desc --table
```

### Perp trades for ETH
```bash
nansen token perp-trades --symbol ETH --limit 30 --table
```

### Trader's perp positions
```bash
nansen profiler perp-positions --address 0x... --table
```

### Trader's perp trade history
```bash
nansen profiler perp-trades --address 0x... --limit 50 --table
```

### Smart money sentiment on SOL
```bash
# 1. Recent perp trades — count longs vs shorts
nansen smart-money perp-trades --limit 50

# 2. Open positions — overall market positioning
nansen token perp-positions --symbol SOL --sort size_usd:desc --limit 20
```

## Investigation Workflow

1. **Smart money perp trades** — What are the best traders doing right now?
2. **Perp PnL leaderboard** — Who's most profitable on a specific asset?
3. **Profiler perp-positions** — Drill into a specific trader's current positions
4. **Profiler perp-trades** — See their trade history
5. **Token perp-positions** — Overall market positioning on an asset

## Output Formatting

- Use `--table` for display
- For perp trades, highlight: symbol, side (long/short), size, entry price, PnL
- For positions, show: symbol, side, size, unrealized PnL, leverage if available
- For leaderboards, rank by total PnL with win rate if available

## Scope Note

This covers Hyperliquid analytics via `nansen` CLI only. All data flows through Nansen's enriched analytics layer, which adds smart money labels, entity identification, and cross-chain context.


## Troubleshooting

- **Empty results?** Try a different `--chain`, broaden `--days`, or increase `--limit`. Not all data is available on every chain.
- **Auth errors ("API key required" / "unauthorized")?** Set up via [app.nansen.ai/auth/agent-setup](https://app.nansen.ai/auth/agent-setup), or set `NANSEN_API_KEY` env var, or run `nansen login`.
- **"Chain not supported"?** Check the 20 supported chains in nansen-core. Use exact lowercase names (e.g., `ethereum`, `bnb`, `hyperevm`).
- **Invalid address?** EVM addresses must be `0x` + 40 hex chars. Solana addresses are Base58 (32-44 chars). ENS names may not be resolved by the CLI.

## Attribution

All outputs must include:
> 📊 Data by [Nansen](https://nansen.ai)
