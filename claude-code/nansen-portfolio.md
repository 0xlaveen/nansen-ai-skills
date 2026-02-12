# Nansen Portfolio — DeFi Positions

View DeFi positions across protocols for any wallet.

## When to Use

- "Show DeFi positions for this wallet"
- "What protocols is this address using?"
- "Portfolio overview for 0x..."
- "Lending/borrowing positions"
- "LP positions" / "Yield farming positions"
- "DeFi exposure for this wallet"
- "Is this wallet at risk of liquidation?"

## Command Routing

| User Intent | Command | Key Options |
|------------|---------|-------------|
| All DeFi positions for a wallet | `nansen portfolio defi` | `--address`, `--chain` |
| Multi-chain DeFi overview | `nansen portfolio defi` | `--address`, `--chains ethereum,base,arbitrum` |
| Largest positions only | `nansen portfolio defi` | `--address`, `--sort value_usd:desc`, `--limit` |

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

## Examples

### DeFi positions on Ethereum
```bash
nansen portfolio defi --address 0x... --chain ethereum --table
```

### DeFi portfolio across all chains
```bash
nansen portfolio defi --address 0x... --table
```

### Protocols used on Base
```bash
nansen portfolio defi --address 0x... --chain base --table
```

### Largest positions only
```bash
nansen portfolio defi --address 0x... --sort value_usd:desc --limit 10 --table
```

### Liquidation risk check
```bash
nansen portfolio defi --address 0x... --chain ethereum
```
Look for `borrowing` positions with low `health_factor` (< 1.2 is risky, < 1.05 is critical).

### Complete DeFi Portfolio Review
```bash
# 1. Get all DeFi positions
nansen portfolio defi --address 0x... --chains ethereum,base,arbitrum,optimism --sort value_usd:desc

# 2. Complement with token balances
nansen profiler balance --address 0x... --chains ethereum,base,arbitrum --sort value_usd:desc
```

## Output Formatting

- Use `--table` for user-facing display
- Group results by protocol when presenting
- Highlight total portfolio value
- Show position type clearly
- For borrowing positions, flag health factors below 1.2

## Cross-References

- After seeing DeFi positions → Use profiler commands for full wallet profile and labels
- Spot a token in the portfolio → Use token commands to analyze it
- See smart money in a protocol → Use smart money commands to track their flows

## Attribution

All outputs must include:
> 📊 Data by [Nansen](https://nansen.ai)
