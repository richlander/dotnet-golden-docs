# Unified Local Analysis

Combined 7 compound terms and 109 single words
Total unique terms: 113
Terms with score ≥ 3.0: 13
Total term occurrences: 154
Header-based scoring: enabled

Scoring formula: LocalScore = count × header_multiplier × type_multiplier
- header_multiplier (compounds only): 1.5x (H1), 1.25x (H2), 1.1x (H3+), 1.0x (none)
  - Single words do NOT get header multipliers (prevents arbitrary substring matches)
- type_multiplier: 1.5x (compound), 1.0x (single)
- Minimum score threshold: 3.0 (only terms meeting this threshold are shown)

| Term | Type | Count | Header Mult | Type Mult | Local Score |
|------|------|-------|-------------|-----------|-------------|
| assignment | single | 6 | 1.00x | 1.00x | 6.0 |
| compile-time | compound | 4 | 1.00x | 1.50x | 6.0 |
| patterns | single | 6 | 1.00x | 1.00x | 6.0 |
| zero-allocation | compound | 3 | 1.25x | 1.50x | 5.6 |
| extension | single | 5 | 1.00x | 1.00x | 5.0 |
| enhanced | single | 4 | 1.00x | 1.00x | 4.0 |
| keyword | single | 4 | 1.00x | 1.00x | 4.0 |
| params collections | compound | 2 | 1.25x | 1.50x | 3.8 |
| expression trees | compound | 2 | 1.10x | 1.50x | 3.3 |
| first-class span | compound | 2 | 1.10x | 1.50x | 3.3 |
| named arguments | compound | 2 | 1.10x | 1.50x | 3.3 |
| first-class | single | 3 | 1.00x | 1.00x | 3.0 |
| stack-only | compound | 2 | 1.00x | 1.50x | 3.0 |
