# Nansen CLI Command Reference

Complete parameter reference for all commands. See `schema.json` for the machine-readable version.

## Global Options

| Option | Type | Description |
|--------|------|-------------|
| `--pretty` | boolean | Pretty-print JSON output |
| `--table` | boolean | Tabular output (for display only — truncates addresses!) |
| `--fields` | string | Comma-separated field list |
| `--no-retry` | boolean | Disable auto-retry |
| `--retries` | number | Max retry attempts (default: 3) |
| `--cache` | boolean | Enable response caching |
| `--no-cache` | boolean | Disable cache for this request |
| `--cache-ttl` | number | Cache TTL in seconds (default: 300) |
| `--stream` | boolean | Output as NDJSON |

> **Per-command options** like `--chain`, `--limit`, `--sort`, `--days`, `--filters` vary by command. Check `schema.json` or run `nansen schema`.

---

## smart-money

### `smart-money netflow`
Net capital flows (inflows vs outflows) by token.

| Option | Type | Required | Default | Description |
|--------|------|----------|---------|-------------|
| `--chain` | string | no | solana | Blockchain |
| `--chains` | array | no | — | Multiple chains (JSON) |
| `--limit` | number | no | — | Result count |
| `--labels` | string/array | no | — | Smart money label filter |
| `--sort` | string | no | — | e.g., `net_flow_usd:desc` |
| `--filters` | object | no | — | JSON filters |

**Returns:** `token_address`, `token_symbol`, `token_name`, `chain`, `inflow_usd`, `outflow_usd`, `net_flow_usd`

### `smart-money dex-trades`
Real-time DEX trading activity by smart wallets.

| Option | Type | Required | Default |
|--------|------|----------|---------|
| `--chain` | string | no | solana |
| `--chains` | array | no | — |
| `--limit` | number | no | — |
| `--labels` | string/array | no | — |
| `--sort` | string | no | — |
| `--filters` | object | no | — |

**Returns:** `tx_hash`, `wallet_address`, `token_address`, `token_symbol`, `side`, `amount`, `value_usd`, `timestamp`

### `smart-money perp-trades`
Perpetual trades on Hyperliquid. **No `--chain` option** (Hyperliquid only).

| Option | Type | Required |
|--------|------|----------|
| `--limit` | number | no |
| `--sort` | string | no |
| `--filters` | object | no |

**Returns:** `wallet_address`, `symbol`, `side`, `size`, `price`, `value_usd`, `pnl_usd`, `timestamp`

### `smart-money holdings`
Aggregated smart money token balances.

| Option | Type | Required | Default |
|--------|------|----------|---------|
| `--chain` | string | no | solana |
| `--chains` | array | no | — |
| `--limit` | number | no | — |
| `--labels` | string/array | no | — |

**Returns:** `token_address`, `token_symbol`, `chain`, `balance`, `balance_usd`, `holder_count`

### `smart-money dcas`
Jupiter DCA strategies by smart wallets.

| Option | Type | Required |
|--------|------|----------|
| `--limit` | number | no |
| `--filters` | object | no |

**Returns:** `wallet_address`, `input_token`, `output_token`, `total_input`, `total_output`, `avg_price`

### `smart-money historical-holdings`
Historical holdings over time.

| Option | Type | Required | Default |
|--------|------|----------|---------|
| `--chain` | string | no | solana |
| `--chains` | array | no | — |
| `--days` | number | no | 30 |
| `--limit` | number | no | — |

**Returns:** `date`, `token_address`, `token_symbol`, `balance`, `balance_usd`

---

## profiler

All commands require `--address` except `search`.

### `profiler balance`
| Option | Type | Required | Default |
|--------|------|----------|---------|
| `--address` | string | **yes** | — |
| `--chain` | string | no | ethereum |
| `--entity` | string | no | — |

**Returns:** `token_address`, `token_symbol`, `token_name`, `balance`, `balance_usd`, `price_usd`

### `profiler labels`
| Option | Type | Required | Default |
|--------|------|----------|---------|
| `--address` | string | **yes** | — |
| `--chain` | string | no | ethereum |

**Returns:** `label`, `label_type`, `label_subtype`

### `profiler transactions`
| Option | Type | Required | Default |
|--------|------|----------|---------|
| `--address` | string | **yes** | — |
| `--chain` | string | no | ethereum |
| `--limit` | number | no | — |
| `--days` | number | no | 30 |

**Returns:** `tx_hash`, `block_number`, `timestamp`, `from`, `to`, `value`, `value_usd`, `method`

### `profiler pnl`
| Option | Type | Required | Default |
|--------|------|----------|---------|
| `--address` | string | **yes** | — |
| `--chain` | string | no | ethereum |

**Returns:** `token_address`, `token_symbol`, `realized_pnl_usd`, `unrealized_pnl_usd`, `total_pnl_usd`

### `profiler search`
| Option | Type | Required |
|--------|------|----------|
| `--query` | string | **yes** |
| `--limit` | number | no |

**Returns:** `entity_name`, `address`, `chain`, `labels`

### `profiler historical-balances`
| Option | Type | Required | Default |
|--------|------|----------|---------|
| `--address` | string | **yes** | — |
| `--chain` | string | no | ethereum |
| `--days` | number | no | 30 |

**Returns:** `date`, `token_address`, `token_symbol`, `balance`, `balance_usd`

### `profiler related-wallets`
| Option | Type | Required | Default |
|--------|------|----------|---------|
| `--address` | string | **yes** | — |
| `--chain` | string | no | ethereum |
| `--limit` | number | no | — |

**Returns:** `address`, `relationship`, `transaction_count`, `volume_usd`

### `profiler counterparties`
| Option | Type | Required | Default |
|--------|------|----------|---------|
| `--address` | string | **yes** | — |
| `--chain` | string | no | ethereum |
| `--days` | number | no | 30 |

**Returns:** `counterparty_address`, `counterparty_label`, `transaction_count`, `volume_usd`

### `profiler pnl-summary`
| Option | Type | Required | Default |
|--------|------|----------|---------|
| `--address` | string | **yes** | — |
| `--chain` | string | no | ethereum |
| `--days` | number | no | 30 |

**Returns:** `total_realized_pnl`, `total_unrealized_pnl`, `win_rate`, `total_trades`

### `profiler perp-positions`
| Option | Type | Required |
|--------|------|----------|
| `--address` | string | **yes** |
| `--limit` | number | no |

**Returns:** `symbol`, `side`, `size`, `entry_price`, `mark_price`, `unrealized_pnl`, `leverage`

### `profiler perp-trades`
| Option | Type | Required | Default |
|--------|------|----------|---------|
| `--address` | string | **yes** | — |
| `--days` | number | no | 30 |
| `--limit` | number | no | — |

**Returns:** `symbol`, `side`, `size`, `price`, `value_usd`, `pnl_usd`, `timestamp`

---

## token

Uses `--token` (contract address) for spot commands, `--symbol` (ticker) for perp commands.

### `token screener`
| Option | Type | Required | Default |
|--------|------|----------|---------|
| `--chain` | string | no | solana |
| `--chains` | array | no | — |
| `--timeframe` | string | no | 24h |
| `--smart-money` | boolean | no | — |
| `--limit` | number | no | — |
| `--sort` | string | no | — |

**Timeframe values:** `5m`, `10m`, `1h`, `6h`, `24h`, `7d`, `30d`

**Returns:** `token_address`, `token_symbol`, `token_name`, `chain`, `price_usd`, `volume_usd`, `market_cap`, `holder_count`, `smart_money_holders`

### `token holders`
| Option | Type | Required | Default |
|--------|------|----------|---------|
| `--token` | string | **yes** | — |
| `--chain` | string | no | solana |
| `--smart-money` | boolean | no | — |
| `--limit` | number | no | — |

**Returns:** `wallet_address`, `balance`, `balance_usd`, `pct_supply`, `labels`

### `token flows`
| Option | Type | Required | Default |
|--------|------|----------|---------|
| `--token` | string | **yes** | — |
| `--chain` | string | no | solana |
| `--limit` | number | no | — |

**Returns:** `label`, `inflow`, `outflow`, `net_flow`, `wallet_count`

### `token dex-trades`
| Option | Type | Required | Default |
|--------|------|----------|---------|
| `--token` | string | **yes** | — |
| `--chain` | string | no | solana |
| `--smart-money` | boolean | no | — |
| `--days` | number | no | 30 |
| `--limit` | number | no | — |

**Returns:** `tx_hash`, `wallet_address`, `side`, `amount`, `price_usd`, `value_usd`, `timestamp`

### `token pnl`
| Option | Type | Required | Default |
|--------|------|----------|---------|
| `--token` | string | **yes** | — |
| `--chain` | string | no | solana |
| `--days` | number | no | 30 |
| `--limit` | number | no | — |
| `--sort` | string | no | — |

**Returns:** `wallet_address`, `realized_pnl_usd`, `unrealized_pnl_usd`, `total_pnl_usd`, `labels`

### `token who-bought-sold`
| Option | Type | Required | Default |
|--------|------|----------|---------|
| `--token` | string | **yes** | — |
| `--chain` | string | no | solana |
| `--limit` | number | no | — |

**Returns:** `wallet_address`, `side`, `amount`, `value_usd`, `timestamp`, `labels`

### `token flow-intelligence`
| Option | Type | Required | Default |
|--------|------|----------|---------|
| `--token` | string | **yes** | — |
| `--chain` | string | no | solana |
| `--limit` | number | no | — |

**Returns:** `label`, `inflow_usd`, `outflow_usd`, `net_flow_usd`, `unique_wallets`

### `token transfers`
| Option | Type | Required | Default |
|--------|------|----------|---------|
| `--token` | string | **yes** | — |
| `--chain` | string | no | solana |
| `--days` | number | no | 30 |
| `--limit` | number | no | — |

**Returns:** `tx_hash`, `from`, `to`, `amount`, `value_usd`, `timestamp`

### `token jup-dca`
| Option | Type | Required |
|--------|------|----------|
| `--token` | string | **yes** |
| `--limit` | number | no |

**Returns:** `wallet_address`, `input_token`, `output_token`, `total_input`, `executed`, `remaining`

### `token perp-trades`
| Option | Type | Required | Default |
|--------|------|----------|---------|
| `--symbol` | string | **yes** | — |
| `--days` | number | no | 30 |
| `--limit` | number | no | — |

**Returns:** `wallet_address`, `side`, `size`, `price`, `value_usd`, `pnl_usd`, `timestamp`

### `token perp-positions`
| Option | Type | Required |
|--------|------|----------|
| `--symbol` | string | **yes** |
| `--limit` | number | no |

**Returns:** `wallet_address`, `side`, `size`, `entry_price`, `mark_price`, `unrealized_pnl`, `leverage`

### `token perp-pnl-leaderboard`
| Option | Type | Required | Default |
|--------|------|----------|---------|
| `--symbol` | string | **yes** | — |
| `--days` | number | no | 30 |
| `--limit` | number | no | — |

**Returns:** `wallet_address`, `realized_pnl`, `unrealized_pnl`, `total_pnl`, `trade_count`

---

## portfolio

### `portfolio defi`
DeFi holdings across protocols.

| Option | Type | Required |
|--------|------|----------|
| `--wallet` | string | **yes** |

**Returns:** `protocol`, `chain`, `position_type`, `token_symbol`, `balance`, `balance_usd`
