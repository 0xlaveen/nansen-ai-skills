# Supported Chains

20 chains supported by `nansen-cli`. Use exact lowercase names.

## Primary Chains

| Chain | ID | Notes |
|-------|----|-------|
| `ethereum` | EVM | Main L1 |
| `solana` | Non-EVM | Base58 addresses |
| `base` | EVM | Coinbase L2 |
| `hyperevm` | EVM | Hyperliquid EVM |
| `bnb` | EVM | BNB Chain (formerly BSC) |

## All Chains

`ethereum`, `solana`, `base`, `bnb`, `arbitrum`, `polygon`, `optimism`, `avalanche`, `linea`, `scroll`, `zksync`, `mantle`, `ronin`, `sei`, `plasma`, `sonic`, `unichain`, `monad`, `hyperevm`, `iotaevm`

## Address Formats

- **EVM chains**: `0x` + 40 hex characters (e.g., `0xd8dA6BF26964aF9D7eEd9e03E53415D37aA96045`)
- **Solana**: Base58 string, 32–44 characters
- **ENS names**: May not be resolved by the CLI — use raw addresses
