# Nansen Smart Money

Track what institutional funds and profitable traders are doing onchain.

## When to Use

- "What are smart money buying?"
- "Show me fund flows on Solana"
- "Smart money net flows for ETH"
- "What tokens are funds accumulating?"
- "DEX trades by smart traders"
- "DCA strategies on Jupiter"
- "Historical smart money holdings"

## Command Routing

| User Intent | Command | Key Options |
|------------|---------|-------------|
| Smart money buying/selling, capital flows | `nansen smart-money netflow` | `--chain`, `--days`, `--sort net_flow_usd:desc` |
| Real-time DEX trades by smart wallets | `nansen smart-money dex-trades` | `--chain`, `--limit`, `--sort amount_usd:desc` |
| What smart money currently holds | `nansen smart-money holdings` | `--chain`, `--sort value_usd:desc` |
| Holdings over time / accumulation trends | `nansen smart-money historical-holdings` | `--chain`, `--days` |
| Jupiter DCA strategies by smart wallets | `nansen smart-money dcas` | `--chain solana` |
| Perp trades on Hyperliquid | `nansen smart-money perp-trades` | `--limit`, `--sort amount_usd:desc` |

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

## Examples

### What are smart money buying on Solana?
```bash
nansen smart-money netflow --chain solana --sort net_flow_usd:desc --limit 20 --table
```

### Fund flows for the last 7 days on Ethereum
```bash
nansen smart-money netflow --chain ethereum --days 7 --filters '{"label": "Fund"}' --sort net_flow_usd:desc --table
```

### Real-time DEX trades by smart money on Base
```bash
nansen smart-money dex-trades --chain base --limit 30 --table
```

### Tokens smart money has been accumulating
```bash
nansen smart-money historical-holdings --chain ethereum --days 30 --sort balance_usd:desc --limit 20 --table
```

### Current smart money holdings on BNB chain
```bash
nansen smart-money holdings --chain bnb --sort balance_usd:desc --limit 20 --table
```

### Jupiter DCA strategies by smart wallets
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

## Cross-References

- See a token in smart money flows? → Use token commands to dig deeper into holders and trades
- See a wallet address? → Use profiler commands to identify and profile it
- See perp activity? → Use Hyperliquid commands for perp-specific analysis

## Attribution

All outputs must include:
> 📊 Data by [Nansen](https://nansen.ai)
