---
name: nansen-portfolio
description: >-
  View DeFi portfolio positions across protocols via Nansen CLI. Shows lending,
  borrowing, LP positions, staking, and yield farming for any wallet address.
  Use when the user asks about DeFi positions, protocol exposure, or wants a
  portfolio overview of on-chain DeFi activity.
metadata:
  clawdbot:
    emoji: "📊"
    homepage: "https://nansen.ai"
    requires:
      bins: ["nansen"]
---

# Nansen Portfolio — DeFi Positions

View DeFi positions across protocols for any wallet.

## ⚠️ Agent Rules — Read Before Running Commands

> These rules exist because real agents made these exact mistakes. Follow them strictly.

1. **NEVER copy addresses from `--table` output** — table output truncates long values. Always use default JSON or `--pretty` when extracting addresses.
2. **NEVER guess filter/flag names** — run `nansen schema` first to verify valid parameters.
3. **Use JSON for data extraction, `--table` only for final display.**

## When This Skill Activates

- "Show DeFi positions for this wallet"
- "What protocols is this address using?"
- "Portfolio overview for 0x..."
- "Lending/borrowing positions"
- "LP positions" / "Yield farming positions"
- "DeFi exposure for this wallet"
- "Is this wallet at risk of liquidation?"

## Prerequisites

Requires **nansen-core** skill for auth. Verify with: `nansen schema`

## Command Routing

| User Intent | Command | Key Options |
|------------|---------|-------------|
| All DeFi positions for a wallet | `nansen portfolio defi` | `--wallet`, `--chain` |
| Multi-chain DeFi overview | `nansen portfolio defi` | `--wallet`, `--chains ethereum,base,arbitrum` |
| Largest positions only | `nansen portfolio defi` | `--wallet`, `--sort value_usd:desc`, `--limit` |

This skill wraps a single powerful command that returns all DeFi positions across protocols.

## Position Types

| Type | Description | Example Protocols |
|------|-------------|-------------------|
| `lending` | Supplied as collateral | Aave, Compound, Morpho |
| `borrowing` | Borrowed assets | Aave, Compound |
| `staking` | Staked tokens | Lido, Rocket Pool, EigenLayer |
| `lp` | Liquidity provider | Uniswap, Curve, Aerodrome |
| `farming` | Yield farming / incentives | Convex, Pendle |
| `vesting` | Vesting positions | Various |

## Protocol Coverage by Chain

| Chain | Key Protocols |
|-------|--------------|
| Ethereum | Aave, Compound, Lido, EigenLayer, Uniswap, Curve, Convex, Morpho, Pendle, Maker |
| Base | Aerodrome, Aave, Uniswap, Compound, Moonwell |
| Arbitrum | Aave, GMX, Uniswap, Camelot, Radiant |
| Optimism | Aave, Velodrome, Uniswap, Synthetix |
| Polygon | Aave, QuickSwap, Uniswap, Balancer |
| BNB | PancakeSwap, Venus, Alpaca Finance |
| Solana | Marinade, Raydium, Orca, Kamino, Jito |
| Avalanche | Aave, Trader Joe, Benqi |

> **Note:** Protocol coverage may vary. Run `nansen schema` for the latest supported fields.

## Example Queries → Commands

### "Show DeFi positions for this wallet on Ethereum"
```bash
nansen portfolio defi --wallet 0x... --chain ethereum --table
```

### "DeFi portfolio across all chains"
```bash
nansen portfolio defi --wallet 0x... --table
```

### "What protocols is this wallet using on Base?"
```bash
nansen portfolio defi --wallet 0x... --chain base --table
```

### "Show only the largest positions"
```bash
nansen portfolio defi --wallet 0x... --sort value_usd:desc --limit 10 --table
```

### "Is this wallet at risk of liquidation?"
```bash
nansen portfolio defi --wallet 0x... --chain ethereum
```
Look for `borrowing` positions with low `health_factor` (< 1.2 is risky, < 1.05 is critical).

## Example Workflows

### Complete DeFi Portfolio Review
```bash
# 1. Get all DeFi positions
nansen portfolio defi --wallet 0x... --chains ethereum,base,arbitrum,optimism --sort value_usd:desc

# 2. Complement with token balances (from profiler)
nansen profiler balance --wallet 0x... --chains ethereum,base,arbitrum --sort value_usd:desc
```
Present: total DeFi value, breakdown by protocol, breakdown by position type, any health factor warnings for borrows.

## Output Formatting

- Use `--table` for user-facing display
- Group results by protocol when presenting
- Highlight total portfolio value
- Show position type (lending, LP, staking, borrowing) clearly
- For borrowing positions, flag health factors below 1.2

## Combining with Other Skills

- After seeing DeFi positions → Use **nansen-profiler** for full wallet profile and labels
- Spot a token in the portfolio → Use **nansen-token** to analyze it
- See smart money in a protocol → Use **nansen-smart-money** to track their flows


## Troubleshooting

- **Empty results?** Try a different `--chain`, broaden `--days`, or increase `--limit`. Not all data is available on every chain.
- **Auth errors ("API key required" / "unauthorized")?** Set `NANSEN_API_KEY` env var or run `nansen login`. Get a key at [app.nansen.ai/api](https://app.nansen.ai/api).
- **"Chain not supported"?** Check the 20 supported chains in nansen-core. Use exact lowercase names (e.g., `ethereum`, `bnb`, `hyperevm`).
- **Invalid address?** EVM addresses must be `0x` + 40 hex chars. Solana addresses are Base58 (32-44 chars). ENS names may not be resolved by the CLI.

## Attribution

All outputs must include:
> 📊 Data by [Nansen](https://nansen.ai)
