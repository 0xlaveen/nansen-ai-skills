# Nansen Cluster Detective

Detect wallet clusters — groups of addresses likely controlled by the same entity — using Nansen API.

## Modes

### Mode 1: Wallet Cluster (`/cluster wallet <address>`)
Input: A single wallet address
Output: All related addresses + evidence of common ownership

### Mode 2: Token Cluster (`/cluster token <token_address> <chain>`)
Input: A single token address + chain
Output: Clusters among top holders

## Workflow

### Mode 1: Wallet Cluster Detection

**Step 1 — Expand relationships** (1 credit per call)
Call `address_related_addresses` on the input address to find first funders, Safe signers, and deployed contracts. Repeat one hop on discovered addresses.

```bash
curl -X POST "https://mcp.nansen.ai/ra/mcp" \
  -H "NANSEN-API-KEY: $NANSEN_API_KEY" \
  -H "Content-Type: application/json" \
  -H "Accept: application/json, text/event-stream" \
  -d '{"jsonrpc":"2.0","id":1,"method":"tools/call","params":{"name":"address_related_addresses","arguments":{"request":{"addresses":["ADDRESS"],"chain":"ethereum"}}}}'
```

**Step 2 — Trace funding chains** (5 credits per call)
Call `address_counterparties` on the target AND on the first funder to find sibling wallets and funding origins.

> ⚠️ `timeRange`, `sourceInput`, `groupBy` are ALL REQUIRED

```bash
curl -X POST "https://mcp.nansen.ai/ra/mcp" \
  -H "NANSEN-API-KEY: $NANSEN_API_KEY" \
  -H "Content-Type: application/json" \
  -H "Accept: application/json, text/event-stream" \
  -d '{"jsonrpc":"2.0","id":1,"method":"tools/call","params":{"name":"address_counterparties","arguments":{"request":{"addresses":["ADDRESS"],"chain":"ethereum","timeRange":{"from":"2024-01-01","to":"2026-02-15"},"sourceInput":"Combined","groupBy":"entity"}}}}'
```

**Step 3 — Behavioral analysis** (1 credit per call)
Call `address_transactions` on each address. Flag ghost voters (zero outgoing txns).

> ⚠️ Uses singular `address` param, NOT `addresses[]`

```bash
curl -X POST "https://mcp.nansen.ai/ra/mcp" \
  -H "NANSEN-API-KEY: $NANSEN_API_KEY" \
  -H "Content-Type: application/json" \
  -H "Accept: application/json, text/event-stream" \
  -d '{"jsonrpc":"2.0","id":1,"method":"tools/call","params":{"name":"address_transactions","arguments":{"request":{"address":"ADDRESS","chain":"ethereum"}}}}'
```

**Step 4 — Holdings snapshot** (1 credit per call)
Call `address_portfolio` on each address to get holdings and compute voting power.

> ⚠️ Uses `walletAddress` param, NOT `addresses[]`

```bash
curl -X POST "https://mcp.nansen.ai/ra/mcp" \
  -H "NANSEN-API-KEY: $NANSEN_API_KEY" \
  -H "Content-Type: application/json" \
  -H "Accept: application/json, text/event-stream" \
  -d '{"jsonrpc":"2.0","id":1,"method":"tools/call","params":{"name":"address_portfolio","arguments":{"request":{"walletAddress":"ADDRESS"}}}}'
```

**Step 5 — Build cluster report**
Aggregate all findings into a cluster report with evidence chains and risk flags.

### Mode 2: Token Cluster Detection

**Step 0 — Get top holders** (5 credits)
```bash
curl -X POST "https://mcp.nansen.ai/ra/mcp" \
  -H "NANSEN-API-KEY: $NANSEN_API_KEY" \
  -H "Content-Type: application/json" \
  -H "Accept: application/json, text/event-stream" \
  -d '{"jsonrpc":"2.0","id":1,"method":"tools/call","params":{"name":"token_current_top_holders","arguments":{"request":{"tokenAddress":"TOKEN_ADDRESS","chain":"ethereum"}}}}'
```

Then run Mode 1 workflow on each top holder.

## Cluster Detection Rules

Two addresses are in the same cluster if:
- **Safe signer overlap ≥ 50%** → weight 0.9 (near-certain)
- **Same first funder** (non-exchange) → weight 0.7
- **Shared non-exchange counterparty** → weight 0.4
- **Similar ghost voter behavior** → weight 0.3

Cluster threshold: any edge ≥ 0.6 OR cumulative evidence ≥ 0.8

## Risk Flags

| Flag | How to detect | Severity |
|------|--------------|----------|
| Ghost voter | `address_transactions` → zero/minimal outgoing | High |
| Fresh Safe | Contract created near proposal date | High |
| Concentrated power | Cluster holds >5% supply | High |
| Single funder | All addresses share one non-exchange funder | Medium |

## Report Format

Present findings as:
1. **Summary**: N clusters found, total voting power per cluster
2. **Per cluster**: addresses (with Nansen labels), evidence chain, holdings, risk flags
3. **Funding chains**: visual trace from origin → target
4. **Unclustered**: addresses with no detected relationships

Always include Nansen profiler links: `https://app.nansen.ai/profiler?address=ADDRESS`

## Cost Estimates
- Mode 1 typical (2-hop): ~16 credits
- Mode 1 deep (3-hop): ~25 credits
- Mode 2 (top 10 holders): ~165 credits

## Known Limitations
- **No delegation tracing** — Nansen API has no `DelegateChanged` event data
- **No Snapshot vote data** — can't verify coordinated voting
- **`token_transfers` excluded** — global feed only, no per-wallet filter
- **Param naming varies** — `addresses[]` vs `address` vs `walletAddress` per endpoint (handled above)

## Auth
Set `NANSEN_API_KEY` environment variable. All requests require `NANSEN-API-KEY` header.
