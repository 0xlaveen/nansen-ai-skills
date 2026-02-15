# Nansen Smart Money

Track what institutional funds and profitable traders are doing onchain.

## Commands

| Intent | Command | Key Options |
|--------|---------|-------------|
| Capital flows by token | `nansen smart-money netflow` | `--chain`, `--limit`, `--labels`, `--sort`, `--filters` |
| DEX trades by smart wallets | `nansen smart-money dex-trades` | `--chain`, `--limit`, `--labels`, `--sort` |
| Current holdings | `nansen smart-money holdings` | `--chain`, `--limit`, `--labels` |
| Holdings over time | `nansen smart-money historical-holdings` | `--chain`, `--days`, `--limit` |
| Jupiter DCA strategies | `nansen smart-money dcas` | `--limit`, `--filters` |

For perp trades → see `nansen-hyperliquid.md`.

## Examples

```bash
# Smart money buying on Solana
nansen smart-money netflow --chain solana --sort net_flow_usd:desc --limit 20 --table

# Fund flows only
nansen smart-money netflow --chain ethereum --filters '{"label": "Fund"}' --sort net_flow_usd:desc --table

# DEX trades on Base
nansen smart-money dex-trades --chain base --limit 30 --table

# Holdings on BNB
nansen smart-money holdings --chain bnb --sort balance_usd:desc --limit 20 --table
```

## Interpretation

- High positive `net_flow_usd` = accumulating
- High negative = distributing
- High `trader_count` + positive flow = strong conviction

## References

- Full parameters: `references/commands.md` (smart-money section)
- Example response: `references/examples/smart-money-netflow.json`
- Labels: `references/smart-money-labels.md`
- Schema: `references/schema.json`

## Cross-References

- Token in flows? → `nansen-token.md` for deeper analysis
- Wallet address? → `nansen-profiler.md` to identify it
- Perp activity? → `nansen-hyperliquid.md`

> 📊 Data by [Nansen](https://nansen.ai)
