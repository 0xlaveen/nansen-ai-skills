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
| `--format` | string | Output format: `json` (default) or `csv` |

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
| `--sort` | string | no | — | e.g., `net_flow_24h_usd:desc` |
| `--filters` | object | no | — | JSON filters |

**Returns:** `token_address`, `token_symbol`, `chain`, `net_flow_1h_usd`, `net_flow_24h_usd`, `net_flow_7d_usd`, `net_flow_30d_usd`, `token_age_days`, `token_sectors`, `trader_count`, `market_cap_usd`

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

**Returns:** `transaction_hash`, `trader_address`, `trader_address_label`, `token_bought_address`, `token_bought_symbol`, `token_sold_address`, `token_sold_symbol`, `token_bought_amount`, `token_sold_amount`, `trade_value_usd`, `block_timestamp`, `chain`, `token_bought_age_days`, `token_sold_age_days`, `token_bought_market_cap`, `token_sold_market_cap`

### `smart-money perp-trades`
Perpetual trades on Hyperliquid. **No `--chain` option** (Hyperliquid only).

| Option | Type | Required |
|--------|------|----------|
| `--limit` | number | no |
| `--sort` | string | no |
| `--filters` | object | no |

**Returns:** `trader_address`, `trader_address_label`, `token_symbol`, `side`, `action`, `token_amount`, `price_usd`, `value_usd`, `type`, `block_timestamp`, `transaction_hash`

### `smart-money holdings`
Aggregated smart money token balances.

| Option | Type | Required | Default |
|--------|------|----------|---------|
| `--chain` | string | no | solana |
| `--chains` | array | no | — |
| `--limit` | number | no | — |
| `--labels` | string/array | no | — |

**Returns:** `token_address`, `token_symbol`, `chain`, `value_usd`, `holders_count`, `token_sectors`, `balance_24h_percent_change`, `share_of_holdings_percent`, `token_age_days`, `market_cap_usd`

### `smart-money dcas`
Jupiter DCA strategies by smart wallets.

| Option | Type | Required |
|--------|------|----------|
| `--limit` | number | no |
| `--filters` | object | no |

**Returns:** `trader_address`, `trader_address_label`, `input_token_address`, `input_token_symbol`, `output_token_address`, `output_token_symbol`, `deposit_token_amount`, `output_token_redeemed_amount`, `token_spent_amount`, `deposit_value_usd`, `dca_vault_address`, `dca_status`, `dca_created_at`, `dca_updated_at`, `transaction_hash`

### `smart-money historical-holdings`
Historical holdings over time.

| Option | Type | Required | Default |
|--------|------|----------|---------|
| `--chain` | string | no | solana |
| `--chains` | array | no | — |
| `--days` | number | no | 30 |
| `--limit` | number | no | — |

**Returns:** `date`, `chain`, `token_address`, `token_symbol`, `token_sectors`, `smart_money_labels`, `balance`, `value_usd`, `balance_24h_percent_change`, `holders_count`, `share_of_holdings_percent`, `token_age_days`, `market_cap_usd`

---

## profiler

All commands require `--address` except `search`.

### `profiler balance`
| Option | Type | Required | Default |
|--------|------|----------|---------|
| `--address` | string | **yes** | — |
| `--chain` | string | no | ethereum |
| `--entity` | string | no | — |

**Returns:** `chain`, `address`, `token_address`, `token_symbol`, `token_name`, `token_amount`, `price_usd`, `value_usd`

### `profiler labels`
| Option | Type | Required | Default |
|--------|------|----------|---------|
| `--address` | string | **yes** | — |
| `--chain` | string | no | ethereum |

**Returns:** `label`, `category`, `definition`, `smEarnedDate`, `fullname`

### `profiler transactions`

> ⚠️ **Requires `--date` parameter** (undocumented in schema). Format: `--date '{"from": "YYYY-MM-DD", "to": "YYYY-MM-DD"}'`. Without it, the API returns an error. The `--days` option does NOT satisfy this requirement.

| Option | Type | Required | Default |
|--------|------|----------|---------|
| `--address` | string | **yes** | — |
| `--chain` | string | no | ethereum |
| `--limit` | number | no | — |
| `--days` | number | no | 30 |
| `--date` | object | **yes** (undocumented) | — |

**Returns:** `tx_hash`, `block_number`, `timestamp`, `from`, `to`, `value`, `value_usd`, `method`

### `profiler pnl`

> ⛔ **Currently unavailable** — returns 404 Not Found. This endpoint appears to be non-functional in the current CLI/API version.

| Option | Type | Required | Default |
|--------|------|----------|---------|
| `--address` | string | **yes** | — |
| `--chain` | string | no | ethereum |

### `profiler search`
| Option | Type | Required |
|--------|------|----------|
| `--query` | string | **yes** |
| `--limit` | number | no |

**Returns:** `entity_name`

### `profiler historical-balances`
| Option | Type | Required | Default |
|--------|------|----------|---------|
| `--address` | string | **yes** | — |
| `--chain` | string | no | ethereum |
| `--days` | number | no | 30 |

**Returns:** `block_timestamp`, `token_address`, `token_symbol`, `token_amount`, `value_usd`, `chain`

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

**Returns:** `counterparty_address`, `counterparty_address_label`, `interaction_count`, `total_volume_usd`, `volume_in_usd`, `volume_out_usd`, `tokens_info`

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

**Returns:** `address`, `address_label`, `side`, `position_value_usd`, `position_size`, `leverage`, `leverage_type`, `entry_price`, `mark_price`, `liquidation_price`, `funding_usd`, `upnl_usd`

### `profiler perp-trades`
| Option | Type | Required | Default |
|--------|------|----------|---------|
| `--address` | string | **yes** | — |
| `--days` | number | no | 30 |
| `--limit` | number | no | — |

**Returns:** `symbol`, `side`, `size`, `price`, `value_usd`, `pnl_usd`, `timestamp`

### `profiler batch`
Profile multiple addresses in a single operation.

| Option | Type | Required | Default |
|--------|------|----------|---------|
| `--addresses` | string | **yes** (or `--file`) | — |
| `--file` | string | **yes** (or `--addresses`) | — |
| `--chain` | string | no | ethereum |
| `--include` | string | no | labels,balance |
| `--delay` | number | no | 1000 |

> `--addresses`: comma-separated list. `--file`: path to file with one address per line. `--include`: comma-separated list of `labels`, `balance`, `pnl`.

**Returns:** Array of `{ address, chain, labels, balance, pnl, error }` per address.

### `profiler trace`
Multi-hop counterparty trace (BFS traversal from a root address).

| Option | Type | Required | Default |
|--------|------|----------|---------|
| `--address` | string | **yes** | — |
| `--chain` | string | no | ethereum |
| `--depth` | number | no | 2 |
| `--width` | number | no | 10 |
| `--days` | number | no | 30 |
| `--delay` | number | no | 1000 |

> `--depth`: max hops (1-5). `--width`: top N counterparties per hop.

**Returns:** `{ root, chain, depth, nodes, edges, stats }`

### `profiler compare`
Compare two wallets — shared counterparties, shared tokens, and balances.

| Option | Type | Required | Default |
|--------|------|----------|---------|
| `--addresses` | string | **yes** | — |
| `--chain` | string | no | ethereum |
| `--days` | number | no | 30 |

> `--addresses`: two comma-separated addresses.

**Returns:** `{ addresses, chain, shared_counterparties, shared_tokens, balances }`

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

**Returns:** `token_address`, `token_symbol`, `chain`, `price_usd`, `volume`, `buy_volume`, `sell_volume`, `market_cap_usd`, `token_age_days`, `liquidity`, `price_change`, `fdv`, `fdv_mc_ratio`, `inflow_fdv_ratio`, `outflow_fdv_ratio`, `netflow`

### `token holders`
| Option | Type | Required | Default |
|--------|------|----------|---------|
| `--token` | string | **yes** | — |
| `--chain` | string | no | solana |
| `--smart-money` | boolean | no | — |
| `--limit` | number | no | — |

**Returns:** `address`, `address_label`, `token_amount`, `value_usd`, `ownership_percentage`, `total_outflow`, `total_inflow`, `balance_change_24h`, `balance_change_7d`, `balance_change_30d`

### `token flows`

> ⚠️ **Requires `--date` parameter** (undocumented in schema). Format: `--date '{"from": "YYYY-MM-DD", "to": "YYYY-MM-DD"}'`. Without it, the API returns an error.

| Option | Type | Required | Default |
|--------|------|----------|---------|
| `--token` | string | **yes** | — |
| `--chain` | string | no | solana |
| `--limit` | number | no | — |
| `--date` | object | **yes** (undocumented) | — |

**Returns:** `label`, `inflow`, `outflow`, `net_flow`, `wallet_count`

### `token dex-trades`
| Option | Type | Required | Default |
|--------|------|----------|---------|
| `--token` | string | **yes** | — |
| `--chain` | string | no | solana |
| `--smart-money` | boolean | no | — |
| `--days` | number | no | 30 |
| `--limit` | number | no | — |

**Returns:** `transaction_hash`, `trader_address`, `trader_address_label`, `action`, `token_amount`, `estimated_swap_price_usd`, `estimated_value_usd`, `block_timestamp`, `token_address`, `token_name`, `traded_token_address`, `traded_token_name`, `traded_token_amount`

### `token pnl`
| Option | Type | Required | Default |
|--------|------|----------|---------|
| `--token` | string | **yes** | — |
| `--chain` | string | no | solana |
| `--days` | number | no | 30 |
| `--limit` | number | no | — |
| `--sort` | string | no | — |

**Returns:** `trader_address`, `trader_address_label`, `pnl_usd_realised`, `pnl_usd_unrealised`, `pnl_usd_total`, `price_usd`, `holding_amount`, `holding_usd`, `max_balance_held`, `max_balance_held_usd`, `still_holding_balance_ratio`, `netflow_amount_usd`, `netflow_amount`, `roi_percent_total`, `roi_percent_realised`, `roi_percent_unrealised`, `nof_trades`

### `token who-bought-sold`

> ⚠️ **Requires `--date` parameter** (undocumented in schema). Format: `--date '{"from": "YYYY-MM-DD", "to": "YYYY-MM-DD"}'`. Without it, the API returns an error.

| Option | Type | Required | Default |
|--------|------|----------|---------|
| `--token` | string | **yes** | — |
| `--chain` | string | no | solana |
| `--limit` | number | no | — |
| `--date` | object | **yes** (undocumented) | — |

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
| `--from` | string | no | — |
| `--to` | string | no | — |
| `--enrich` | boolean | no | — |

> Use `--from` or `--to` to filter by sender/recipient address. Use `--enrich` to add Nansen labels to from/to addresses.

**Returns:** `transaction_hash`, `from_address`, `from_address_label`, `to_address`, `to_address_label`, `transfer_amount`, `transfer_value_usd`, `block_timestamp`, `transaction_type`

### `token jup-dca`

> ℹ️ **Solana only** — this command only works with Solana token addresses.

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

**Returns:** `trader_address`, `trader_address_label`, `token_symbol`, `side`, `action`, `token_amount`, `price_usd`, `value_usd`, `type`, `block_timestamp`, `transaction_hash`

### `token perp-positions`
| Option | Type | Required |
|--------|------|----------|
| `--symbol` | string | **yes** |
| `--limit` | number | no |

**Returns:** `address`, `address_label`, `side`, `position_value_usd`, `position_size`, `leverage`, `leverage_type`, `entry_price`, `mark_price`, `liquidation_price`, `funding_usd`, `upnl_usd`

### `token perp-pnl-leaderboard`
| Option | Type | Required | Default |
|--------|------|----------|---------|
| `--symbol` | string | **yes** | — |
| `--days` | number | no | 30 |
| `--limit` | number | no | — |

**Returns:** `trader_address`, `trader_address_label`, `pnl_usd_realised`, `pnl_usd_unrealised`, `pnl_usd_total`, `nof_trades`, `price_usd`, `holding_amount`, `position_value_usd`, `max_balance_held`, `max_balance_held_usd`, `still_holding_balance_ratio`, `netflow_amount_usd`, `netflow_amount`, `roi_percent_total`, `roi_percent_realised`, `roi_percent_unrealised`

---

## portfolio

### `portfolio defi`
DeFi holdings across protocols.

| Option | Type | Required |
|--------|------|----------|
| `--wallet` | string | **yes** |

**Returns:** Top-level object with `summary` (`total_value_usd`, `total_assets_usd`, `total_debts_usd`, `total_rewards_usd`, `token_count`, `protocol_count`) and `protocols` array containing per-protocol position details.
