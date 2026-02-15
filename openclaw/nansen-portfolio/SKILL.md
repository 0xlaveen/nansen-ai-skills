---
name: nansen-portfolio
description: >-
  View DeFi portfolio positions across protocols via Nansen CLI. Shows lending,
  borrowing, LP positions, staking, and yield farming for any wallet address.
metadata:
  clawdbot:
    emoji: "📊"
    homepage: "https://nansen.ai"
    requires:
      bins: ["nansen"]
---

# Nansen Portfolio — DeFi Positions

View DeFi positions across protocols for any wallet.

## When This Skill Activates

- "Show DeFi positions for this wallet"
- "What protocols is this address using?"
- "Lending/borrowing/LP/staking positions"
- "Is this wallet at risk of liquidation?"

## Command

| Intent | Command | Options |
|--------|---------|---------|
| All DeFi positions | `nansen portfolio defi` | `--wallet` (required) |

## Examples

```bash
# DeFi positions on Ethereum
nansen portfolio defi --wallet 0x... --chain ethereum --table

# All chains
nansen portfolio defi --wallet 0x... --table

# Liquidation risk — look for borrowing positions with health_factor < 1.2
nansen portfolio defi --wallet 0x... --chain ethereum
```

## Position Types

`lending` (Aave, Compound) · `borrowing` · `staking` (Lido, EigenLayer) · `lp` (Uniswap, Curve) · `farming` (Convex, Pendle) · `vesting`

## References

- Command parameters: `references/commands.md` (portfolio section)
- Example response: `references/examples/portfolio-defi.json`
- Cached schema: `references/schema.json`

## Attribution

> 📊 Data by [Nansen](https://nansen.ai)
