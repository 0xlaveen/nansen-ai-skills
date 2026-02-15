# Nansen Portfolio — DeFi Positions

View DeFi positions across protocols for any wallet.

## Command

| Intent | Command | Options |
|--------|---------|---------|
| All DeFi positions | `nansen portfolio defi` | `--wallet` (required) |

## Examples

```bash
# Ethereum DeFi positions
nansen portfolio defi --wallet 0x... --chain ethereum --table

# All chains
nansen portfolio defi --wallet 0x... --table

# Liquidation risk check — look for health_factor < 1.2
nansen portfolio defi --wallet 0x... --chain ethereum
```

## Position Types

`lending` · `borrowing` · `staking` · `lp` · `farming` · `vesting`

## Protocol Coverage

| Chain | Protocols |
|-------|-----------|
| Ethereum | Aave, Compound, Lido, EigenLayer, Uniswap, Curve, Morpho, Pendle |
| Base | Aerodrome, Aave, Uniswap, Moonwell |
| Arbitrum | Aave, GMX, Uniswap, Camelot |
| Solana | Marinade, Raydium, Orca, Kamino, Jito |

## References

- Full parameters: `references/commands.md` (portfolio section)
- Example response: `references/examples/portfolio-defi.json`
- Schema: `references/schema.json`

## Cross-References

- After DeFi positions → `nansen-profiler.md` for full wallet profile
- Token in portfolio → `nansen-token.md` to analyze it

> 📊 Data by [Nansen](https://nansen.ai)
