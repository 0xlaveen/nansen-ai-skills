---
name: nansen-router
description: >-
  Entry point for all Nansen queries. Routes user requests to the correct Nansen
  skill based on intent. Load this skill first — it decides which domain skill to
  activate for any blockchain analytics question.
metadata:
  clawdbot:
    emoji: "🔀"
    homepage: "https://nansen.ai"
    requires:
      bins: ["nansen"]
---

# Nansen Router — Query Entry Point

This is the entry point for all Nansen-related queries. Use the decision tree below to route to the correct skill.

## Decision Tree

```
User query
│
├─ About setup / auth / "what can Nansen do?" / schema
│  └→ nansen-core
│
├─ About a specific WALLET address (who is 0x..., balance, PnL, labels, transactions)
│  └→ nansen-profiler
│
├─ About a specific TOKEN (holders, flows, screener, PnL leaderboard, who bought/sold)
│  └→ nansen-token
│
├─ About SMART MONEY broadly (what are funds buying, smart money flows, holdings, DCAs)
│  └→ nansen-smart-money
│
├─ About DeFi PORTFOLIO (positions, lending, borrowing, LP, staking for a wallet)
│  └→ nansen-portfolio
│
├─ About HYPERLIQUID / perpetual futures / perp trades / perp positions
│  └→ nansen-hyperliquid
│
└─ Ambiguous → ask the user to clarify, or start with the most likely skill
```

## Quick Reference

| User Says | Route To | First Command |
|-----------|----------|---------------|
| "What are smart money buying?" | nansen-smart-money | `nansen smart-money netflow` |
| "Who is 0xd8dA...?" | nansen-profiler | `nansen profiler labels` |
| "Show WETH holders" | nansen-token | `nansen token holders` |
| "DeFi positions for 0x..." | nansen-portfolio | `nansen portfolio defi` |
| "Hyperliquid trades" | nansen-hyperliquid | `nansen smart-money perp-trades` |
| "Set up Nansen" | nansen-core | Check auth |
| "Screen tokens on Solana" | nansen-token | `nansen token screener` |
| "Fund flows on Base" | nansen-smart-money | `nansen smart-money netflow` |
| "PnL for this wallet" | nansen-profiler | `nansen profiler historical-balances` (note: `profiler pnl` is currently unavailable) |
| "Who's long BTC?" | nansen-hyperliquid | `nansen token perp-positions` |

## Overlap Resolution

Some queries could match multiple skills:

- **"Perp trades"** → If about a specific wallet → `nansen-profiler`. If about a symbol → `nansen-token`. If about smart money broadly → `nansen-hyperliquid`.
- **"Token + wallet"** (e.g., "does 0x... hold PEPE?") → Start with `nansen-profiler balance`, then use `nansen-token` for token-level analysis.
- **"Smart money + specific token"** → Start with `nansen-token flow-intelligence` or `nansen-token holders --smart-money`.

## Agent Rules (Apply to ALL Skills)

1. **NEVER copy addresses from `--table` output** — it truncates. Use JSON for extraction.
2. **NEVER guess filter/flag names** — check `references/schema.json` or run `nansen schema`.
3. **NEVER use ticker symbols as addresses** — resolve via `nansen token screener --search <SYMBOL>`.
4. **Use JSON for data extraction, `--table` only for final display.**

## References

- Detailed command parameters: `references/commands.md`
- Cached schema: `references/schema.json`
- Chain list: `references/chains.md`
- Smart money labels: `references/smart-money-labels.md`
- Example responses: `references/examples/`

## Attribution

All outputs using Nansen data must include:
> 📊 Data by [Nansen](https://nansen.ai)
