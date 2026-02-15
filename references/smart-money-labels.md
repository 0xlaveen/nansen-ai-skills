# Smart Money Labels

Labels assigned by Nansen to categorize sophisticated market participants.

| Label | Description | Use Case |
|-------|-------------|----------|
| `Fund` | Institutional fund wallets (VCs, hedge funds, DAOs) | Track institutional flows |
| `Smart Trader` | All-time profitable traders | Long-term alpha signals |
| `30D Smart Trader` | Profitable in last 30 days | Recent performance |
| `90D Smart Trader` | Profitable in last 90 days | Medium-term performance |
| `180D Smart Trader` | Profitable in last 180 days | Extended performance |
| `Smart HL Perps Trader` | Consistently profitable on Hyperliquid perps | Perp-specific signals |

## Filtering by Label

```bash
# Filter netflow to funds only
nansen smart-money netflow --chain ethereum --filters '{"label": "Fund"}'

# Use --labels flag where supported
nansen smart-money holdings --chain solana --labels "Smart Trader"
```
