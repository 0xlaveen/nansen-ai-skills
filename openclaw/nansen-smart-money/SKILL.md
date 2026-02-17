---
name: nansen-smart-money
description: >-
  Track Smart Money flows, DEX trades, holdings, and DCA strategies across 18 chains
  via Nansen CLI. Use when the user asks about what smart money is buying/selling,
  capital flows, fund activity, or smart trader positions.
metadata:
  clawdbot:
    emoji: "🧠"
    homepage: "https://nansen.ai"
    requires:
      bins: ["nansen"]
---

# Nansen Smart Money

Track what institutional funds and profitable traders are doing onchain.

## When This Skill Activates

- "What are smart money buying?"
- "Show me fund flows on Solana"
- "What tokens are funds accumulating?"
- "DEX trades by smart traders"
- "DCA strategies on Jupiter"

## Command Routing

| User Intent | Command | Key Options |
|------------|---------|-------------|
| Capital flows by token | `nansen smart-money netflow` | `--chain`, `--limit`, `--labels`, `--sort`, `--filters` |
| Real-time DEX trades | `nansen smart-money dex-trades` | `--chain`, `--limit`, `--labels`, `--sort` |
| Current holdings | `nansen smart-money holdings` | `--chain`, `--limit`, `--labels` |
| Holdings over time | `nansen smart-money historical-holdings` | `--chain`, `--days`, `--limit` |
| Jupiter DCA strategies | `nansen smart-money dcas` | `--limit`, `--filters` |
| Smart money perp trades | `nansen smart-money perp-trades` | `--limit`, `--sort`, `--filters` *(no --chain, Hyperliquid only)* |

> For token-level perp analysis → see **nansen-hyperliquid**.

## Examples

```bash
# Smart money buying on Solana
nansen smart-money netflow --chain solana --sort net_flow_24h_usd:desc --limit 20 --table

# Fund flows on Ethereum
nansen smart-money netflow --chain ethereum --filters '{"label": "Fund"}' --sort net_flow_24h_usd:desc --table

# DEX trades on Base
nansen smart-money dex-trades --chain base --limit 30 --table

# Current holdings on BNB
nansen smart-money holdings --chain bnb --sort value_usd:desc --limit 20 --table

# Smart money perp trades
nansen smart-money perp-trades --sort value_usd:desc --limit 20 --table
```

## Interpretation

- High positive `net_flow_24h_usd` = accumulating
- High negative = distributing
- High `trader_count` with positive flow = strong conviction

## References

- Command parameters: `references/commands.md` (smart-money section)
- Example response: `references/examples/smart-money-netflow.json`
- Smart money labels: `references/smart-money-labels.md`
- Cached schema: `references/schema.json`

## Attribution

> 📊 Data by [Nansen](https://nansen.ai)
