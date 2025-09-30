# Unified Local Analysis

Combined 7 compound terms and 145 single words
Total unique terms: 151
Terms with score ≥ 3.0: 20
Total term occurrences: 219
Header-based scoring: enabled

Scoring formula: LocalScore = count × header_multiplier × type_multiplier
- header_multiplier (compounds only): 1.5x (H1), 1.25x (H2), 1.1x (H3+), 1.0x (none)
  - Single words do NOT get header multipliers (prevents arbitrary matches)
  - Exception: Acronyms (all-caps, 2+ letters) get 1.25x boost regardless
- type_multiplier: 1.5x (compound), 1.0x (single)
- Minimum score threshold: 3.0 (only terms meeting this threshold are shown)

| Term | Type | Count | Header Mult | Type Mult | Local Score |
|------|------|-------|-------------|-----------|-------------|
| compile-time | compound | 4 | 1.00x | 1.50x | 6.0 |
| extension | single | 5 | 1.00x | 1.00x | 5.0 |
| span | single | 5 | 1.00x | 1.00x | 5.0 |
| support | single | 5 | 1.00x | 1.00x | 5.0 |
| zero-allocation | compound | 3 | 1.10x | 1.50x | 5.0 |
| assignment | single | 4 | 1.00x | 1.00x | 4.0 |
| code | single | 4 | 1.00x | 1.00x | 4.0 |
| enhanced | single | 4 | 1.00x | 1.00x | 4.0 |
| operations | single | 4 | 1.00x | 1.00x | 4.0 |
| patterns | single | 4 | 1.00x | 1.00x | 4.0 |
| compound assignment operators | compound | 2 | 1.10x | 1.50x | 3.3 |
| expression trees | compound | 2 | 1.10x | 1.50x | 3.3 |
| first-class span | compound | 2 | 1.10x | 1.50x | 3.3 |
| named arguments | compound | 2 | 1.10x | 1.50x | 3.3 |
| extensions | single | 3 | 1.00x | 1.00x | 3.0 |
| keyword | single | 3 | 1.00x | 1.00x | 3.0 |
| lambda | single | 3 | 1.00x | 1.00x | 3.0 |
| partial | single | 3 | 1.00x | 1.00x | 3.0 |
| ref | single | 3 | 1.00x | 1.00x | 3.0 |
| stack-only | compound | 2 | 1.00x | 1.50x | 3.0 |
