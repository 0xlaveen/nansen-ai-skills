---
name: nansen-smart-money
description: >-
  Track Smart Money flows, DEX trades, holdings, and DCA strategies across 20 chains
  via Nansen CLI. Use when the user asks about what smart money is buying/selling,
  capital flows, fund activity, or smart trader positions. Covers ethereum, solana,
  base, bnb, hyperevm, and 15 more chains.
metadata:
  clawdbot:
    emoji: "🧠"
    homepage: "https://nansen.ai"
    requires:
      bins: ["nansen"]
---

# Nansen Smart Money

Track what institutional funds and profitable traders are doing onchain.

## ⚠️ Agent Rules — Read Before Running Commands

> These rules exist because real agents made these exact mistakes. Follow them strictly.

1. **NEVER copy addresses from `--table` output** — table output truncates long values. Always use default JSON or `--pretty` when extracting addresses.
2. **NEVER guess filter/flag names** — run `nansen schema` first to verify valid parameters before using `--filters`.
3. **Use JSON for data extraction, `--table` only for final display.**

## When This Skill Activates

- "What are smart money buying?"
- "Show me fund flows on Solana"
- "Smart money net flows for ETH"
- "What tokens are funds accumulating?"
- "DEX trades by smart traders"
- "DCA strategies on Jupiter"
- "Historical smart money holdings"

## Prerequisites

Requires **nansen-core** skill for auth. Verify with: `nansen schema`

## Command Routing

| User Intent | Command | Key Options |
|------------|---------|-------------|
| Smart money buying/selling, capital flows | `nansen smart-money netflow` | `--chain`, `--days`, `--sort net_flow_usd:desc` |
| Real-time DEX trades by smart wallets | `nansen smart-money dex-trades` | `--chain`, `--limit`, `--sort value_usd:desc` |
| What smart money currently holds | `nansen smart-money holdings` | `--chain`, `--sort value_usd:desc` |
| Holdings over time / accumulation trends | `nansen smart-money historical-holdings` | `--chain`, `--days` |
| Jupiter DCA strategies by smart wallets | `nansen smart-money dcas` | `--chain solana` |

> For perpetual/perps data, see **nansen-hyperliquid**.

> **Tip:** Run `nansen schema` to see all available options and return fields for any command.

## Smart Money Labels

| Label | Description |
|-------|-------------|
| `Fund` | Institutional fund wallets (VCs, hedge funds) |
| `Smart Trader` | All-time profitable traders |
| `30D Smart Trader` | Profitable in last 30 days |
| `90D Smart Trader` | Profitable in last 90 days |
| `180D Smart Trader` | Profitable in last 180 days |
| `Smart HL Perps Trader` | Profitable Hyperliquid perp traders |

Use `--filters '{"label": "Fund"}'` to target specific labels.

## Example Queries → Commands

### "What are smart money buying on Solana?"
```bash
nansen smart-money netflow --chain solana --sort net_flow_usd:desc --limit 20 --table
```

### "Show me fund flows for the last 7 days on Ethereum"
```bash
nansen smart-money netflow --chain ethereum --days 7 --filters '{"label": "Fund"}' --sort net_flow_usd:desc --table
```

### "Real-time DEX trades by smart money on Base"
```bash
nansen smart-money dex-trades --chain base --limit 30 --table
```

### "What tokens have smart money been accumulating?"
```bash
nansen smart-money historical-holdings --chain ethereum --days 30 --sort balance_usd:desc --limit 20 --table
```

### "Current smart money holdings on BNB chain"
```bash
nansen smart-money holdings --chain bnb --sort balance_usd:desc --limit 20 --table
```

### "Jupiter DCA strategies by smart wallets"
```bash
nansen smart-money dcas --chain solana --table
```

## Interpretation Tips

- High positive `net_flow_usd` = smart money accumulating
- High negative = smart money distributing
- High `smart_money_count` with positive flow = strong conviction buy

## Output Formatting

- Use `--table` when presenting to users
- Use `--fields` to focus on key columns: `token_symbol`, `net_flow_usd`, `balance_usd`, `wallet_count`
- Sort by USD value descending for "what's biggest" questions
- Sort by change/delta for "what's moving" questions

## Combining with Other Skills

- See a token in smart money flows? → Use **nansen-token** to dig deeper into holders and trades
- See a wallet address? → Use **nansen-profiler** to identify and profile it
- See perp activity? → Use **nansen-hyperliquid** for Hyperliquid-specific analysis


## Troubleshooting

- **Empty results?** Try a different `--chain`, broaden `--days`, or increase `--limit`. Not all data is available on every chain.
- **Auth errors ("API key required" / "unauthorized")?** Set `NANSEN_API_KEY` env var or run `nansen login`. Get a key at [app.nansen.ai/api](https://app.nansen.ai/api).
- **"Chain not supported"?** Check the 20 supported chains in nansen-core. Use exact lowercase names (e.g., `ethereum`, `bnb`, `hyperevm`).
- **Invalid address?** EVM addresses must be `0x` + 40 hex chars. Solana addresses are Base58 (32-44 chars). ENS names may not be resolved by the CLI.

## Attribution

All outputs must include:
> 📊 Data by [Nansen](https://nansen.ai)
