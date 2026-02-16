---
name: nansen-token
description: >-
  Token God Mode analytics via Nansen CLI. Screen tokens, analyze holders, track
  flows, see who's buying/selling, PnL leaderboards, and flow intelligence by label.
metadata:
  clawdbot:
    emoji: "🪙"
    homepage: "https://nansen.ai"
    requires:
      bins: ["nansen"]
---

# Nansen Token — Token God Mode

Deep analytics for any token: holders, flows, trades, PnL, and discovery.

## When This Skill Activates

- "Who holds $TOKEN?" / "Top holders"
- "Screen tokens by smart money"
- "Token flows" / "Who's buying/selling?"
- "PnL leaderboard for $TOKEN"

## ⚠️ Token Address Resolution

Most commands need a contract address. If user gives a ticker:
```bash
nansen token screener --search <SYMBOL> --chain <chain>
# Copy FULL token_address from JSON output (NOT --table)
```

## Command Routing

| User Intent | Command | Key Options | Status |
|------------|---------|-------------|--------|
| Discover tokens | `token screener` | `--chain`, `--timeframe`, `--smart-money`, `--limit`, `--sort` | ✅ |
| Holder breakdown | `token holders` | `--token` (req), `--chain`, `--smart-money`, `--limit` | ✅ |
| DEX trades | `token dex-trades` | `--token` (req), `--chain`, `--smart-money`, `--days`, `--limit` | ✅ |
| PnL leaderboard | `token pnl` | `--token` (req), `--chain`, `--days`, `--limit`, `--sort` | ✅ |
| Transfers | `token transfers` | `--token` (req), `--chain`, `--days`, `--limit`, `--from`, `--to`, `--enrich` | ✅ |
| Flow metrics | `token flows` | `--token` (req), `--chain`, `--date` (req) | ⚠️ needs `--date` |
| Buyers/sellers | `token who-bought-sold` | `--token` (req), `--chain`, `--date` (req) | ⚠️ needs `--date` |
| Flow intelligence | `token flow-intelligence` | `--token` (req), `--chain`, `--days` | ✅ |
| Jupiter DCA | `token jup-dca` | `--token` (req), `--limit` | ✅ (Solana only) |

> Perp commands (`perp-trades`, `perp-positions`, `perp-pnl-leaderboard`) use `--symbol` instead of `--token`. See **nansen-hyperliquid**.

### ⚠️ Known Issues

- **`token flows`** and **`token who-bought-sold`** require `--date '{"from": "YYYY-MM-DD", "to": "YYYY-MM-DD"}'` — without it, the API returns an error.
- **`token jup-dca`** — Solana only. Use a Solana token address, not EVM.

### Response Field Notes (actual API vs schema)

- **`token screener`** returns: `buy_volume`, `sell_volume`, `volume`, `netflow`, `price_usd`, `price_change`, `market_cap_usd`, `fdv`, `liquidity`, `token_age_days`, etc. (NOT `holder_count`/`smart_money_holders`)
- **`token dex-trades`** returns: `action`, `block_timestamp`, `estimated_swap_price_usd`, `estimated_value_usd`, `token_address`, `token_amount`, `traded_token_address`, `trader_address`, `trader_address_label`, `transaction_hash` (NOT `tx_hash`/`wallet_address`/`side`)
- **`token pnl`** returns: `trader_address`, `trader_address_label`, `pnl_usd_realised`, `pnl_usd_unrealised`, `pnl_usd_total`, `roi_percent_*`, `holding_amount`, `nof_trades` (NOT `wallet_address`/`labels`)
- **`token transfers`** returns: `from_address`, `from_address_label`, `to_address`, `to_address_label`, `transfer_amount`, `transfer_value_usd`, `transaction_hash`, `block_timestamp` (NOT `tx_hash`/`from`/`to`)
- **`token flow-intelligence`** returns single object with `*_net_flow_usd`, `*_avg_flow_usd`, `*_wallet_count` for each label group (public_figure, top_pnl, whale, smart_trader, exchange, fresh_wallets)

## Examples

```bash
# Screen tokens on Ethereum by smart money
nansen token screener --chain ethereum --sort smart_money_count:desc --limit 20 --table

# Top WETH holders (smart money only)
nansen token holders --token 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2 --chain ethereum --smart-money --limit 20 --table

# Token flows (--date is required!)
nansen token flows --token 0x... --chain ethereum --date '{"from": "2026-02-01", "to": "2026-02-15"}' --table

# Who's buying/selling? (--date is required!)
nansen token who-bought-sold --token 0x... --chain ethereum --date '{"from": "2026-02-01", "to": "2026-02-15"}' --table

# PnL leaderboard
nansen token pnl --token 0x... --chain ethereum --sort pnl_usd_realised:desc --limit 20 --table

# Flow intelligence by label
nansen token flow-intelligence --token 0x... --chain ethereum --days 7
```

## Discovery Workflow

1. **Screener** → find tokens  2. **Holders** → who holds?  3. **DEX Trades** → activity  4. **PnL** → profits  5. **Transfers** → movement

## References

- Command parameters: `references/commands.md` (token section)
- Example response: `references/examples/token-holders.json`
- Cached schema: `references/schema.json`

## API-Only Endpoints (No CLI Command)

These endpoints work via direct API call but have no CLI command:

### Token Information (`/api/v1/tgm/token-information`)
Detailed token metadata + spot metrics (volume, buys/sells, liquidity, holders).
```bash
curl -s -X POST -H "apikey: $NANSEN_API_KEY" -H "Content-Type: application/json" \
  -d '{"token_address":"0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2","chain":"ethereum","timeframe":"1d"}' \
  "https://api.nansen.ai/api/v1/tgm/token-information"
```
**Params:** `token_address` (req), `chain` (req), `timeframe` (req: `5m`|`1h`|`6h`|`12h`|`1d`|`7d`)
**Returns:** name, symbol, logo, market_cap, fdv, supply, spot_metrics (volume, buys/sells, liquidity, holders)

## MCP-Only Tools (Not available via CLI or REST API)

These tools exist only in the Nansen MCP server:
- **`token_ohlcv`** — OHLCV candlestick data for a token
- **`token_quant_scores`** — Quantitative scoring for a token (momentum, volatility, etc.)
- **`nansen_score_top_tokens`** — Top tokens ranked by Nansen Score

To use these, connect via MCP (see [docs.nansen.ai](https://docs.nansen.ai)).

## Attribution

> 📊 Data by [Nansen](https://nansen.ai)
