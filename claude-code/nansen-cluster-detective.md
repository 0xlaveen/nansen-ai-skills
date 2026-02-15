# Nansen Cluster Detective

Detect wallet clusters — groups of addresses controlled by the same entity — using Nansen API endpoints. Inspired by governance forensics investigations (e.g., Marc Zeller's AAVE governance analysis).

## Two Modes

### Mode 1: Wallet Cluster Detection
- **Input:** A single wallet address
- **Goal:** Find all related addresses likely controlled by the same entity
- **Trigger:** "find clusters for 0x...", "who controls this wallet?"

### Mode 2: Token Cluster Detection
- **Input:** A single token address + chain
- **Goal:** Find clusters among top holders of that token
- **Trigger:** "find governance clusters for AAVE token", "is voting power concentrated?"

## Nansen API Endpoints Used

### Step 1: address_related_addresses (1 credit)
First funders, Safe signers, deployed contracts. **Core expansion mechanism.**
```bash
curl -X POST "https://mcp.nansen.ai/ra/mcp" \
  -H "NANSEN-API-KEY: $NANSEN_API_KEY" \
  -H "Content-Type: application/json" \
  -H "Accept: application/json, text/event-stream" \
  -d '{"jsonrpc":"2.0","id":1,"method":"tools/call","params":{"name":"address_related_addresses","arguments":{"request":{"addresses":["ADDRESS"],"chain":"ethereum"}}}}'
```

### Step 2: address_counterparties (5 credits)
Top counterparties — reveals funding chains and shared entities. Run on target AND on the first funder to find sibling wallets.
```bash
# timeRange, sourceInput, groupBy are ALL REQUIRED
curl -X POST "https://mcp.nansen.ai/ra/mcp" \
  -H "NANSEN-API-KEY: $NANSEN_API_KEY" \
  -H "Content-Type: application/json" \
  -H "Accept: application/json, text/event-stream" \
  -d '{"jsonrpc":"2.0","id":1,"method":"tools/call","params":{"name":"address_counterparties","arguments":{"request":{"addresses":["ADDRESS"],"chain":"ethereum","timeRange":{"from":"2024-01-01","to":"2026-02-15"},"sourceInput":"Combined","groupBy":"entity"}}}}'
```

### Step 3: address_transactions (1 credit)
Behavioral analysis — flag ghost voters (zero outgoing txns, only claims/delegation).
```bash
# NOTE: singular "address", not "addresses[]"
curl -X POST "https://mcp.nansen.ai/ra/mcp" \
  -H "NANSEN-API-KEY: $NANSEN_API_KEY" \
  -H "Content-Type: application/json" \
  -H "Accept: application/json, text/event-stream" \
  -d '{"jsonrpc":"2.0","id":1,"method":"tools/call","params":{"name":"address_transactions","arguments":{"request":{"address":"ADDRESS","chain":"ethereum"}}}}'
```

### Step 4: address_portfolio (1 credit)
Current holdings — compute voting power per address.
```bash
# NOTE: "walletAddress", not "addresses[]"
curl -X POST "https://mcp.nansen.ai/ra/mcp" \
  -H "NANSEN-API-KEY: $NANSEN_API_KEY" \
  -H "Content-Type: application/json" \
  -H "Accept: application/json, text/event-stream" \
  -d '{"jsonrpc":"2.0","id":1,"method":"tools/call","params":{"name":"address_portfolio","arguments":{"request":{"walletAddress":"ADDRESS"}}}}'
```

### Step 0 (Mode 2 only): token_current_top_holders (5 credits)
Get top holders, then run Mode 1 workflow on each.
```bash
curl -X POST "https://mcp.nansen.ai/ra/mcp" \
  -H "NANSEN-API-KEY: $NANSEN_API_KEY" \
  -H "Content-Type: application/json" \
  -H "Accept: application/json, text/event-stream" \
  -d '{"jsonrpc":"2.0","id":1,"method":"tools/call","params":{"name":"token_current_top_holders","arguments":{"request":{"tokenAddress":"TOKEN_ADDRESS","chain":"ethereum"}}}}'
```

## Workflow

### Mode 1: Wallet Cluster
1. `address_related_addresses` on input address → get first funders, signers
2. `address_related_addresses` on discovered addresses (1-hop expansion)
3. `address_counterparties` on target + funder → funding chains, sibling detection
4. `address_transactions` on each address → behavioral fingerprinting (ghost voter detection)
5. `address_portfolio` on each address → holdings snapshot, voting power

### Mode 2: Token Cluster
0. `token_current_top_holders` → get top holders
1. Run Mode 1 on each top holder (or let user pick which to investigate)

## Cluster Detection Logic

Two addresses belong to the same cluster if they share:
- **Safe signers** (overlap ≥ 50%) → weight 0.9
- **Same first funder** (non-exchange) → weight 0.7
- **Shared non-exchange counterparty** → weight 0.4
- **Similar ghost voter behavior** → weight 0.3

Threshold: cluster if edge weight ≥ 0.6 OR cumulative evidence ≥ 0.8

## Risk Flags to Report
- **Ghost voter**: zero/minimal outgoing txns, only inbound
- **Fresh Safe**: created near a governance proposal date
- **Concentrated power**: cluster holds >5% of token supply
- **Single funder**: all cluster addresses funded by one source

## Output Format
For each cluster found:
1. Addresses with Nansen labels + holdings
2. Evidence chain (what links them)
3. Total voting power
4. Risk flags

## Cost
- Mode 1 typical: ~16 credits (2-hop)
- Mode 1 deep: ~25 credits (3-hop)
- Mode 2: ~165 credits (top 10 holders)

## Limitations
- **No delegation data** — Nansen API can't trace `DelegateChanged` events (need onchain queries)
- **No Snapshot vote data** — can't verify coordinated voting patterns
- **No ENS archival** — can't resolve historic ENS ownership
- **`token_transfers` is global-only** — no wallet filter, excluded from workflow
- **Param naming inconsistent** — `addresses[]` vs `address` vs `walletAddress` depending on endpoint

## Auth
Requires `NANSEN-API-KEY` header. Set as environment variable `NANSEN_API_KEY`.
