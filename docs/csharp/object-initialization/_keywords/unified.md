# Unified Local Analysis

Combined 9 compound terms and 106 single words
Total unique terms: 114
Terms with score ≥ 3.0: 24
Total term occurrences: 210
Header-based scoring: enabled

Scoring formula: LocalScore = count × header_multiplier × type_multiplier
- header_multiplier (compounds only): 1.5x (H1), 1.25x (H2), 1.1x (H3+), 1.0x (none)
  - Single words do NOT get header multipliers (prevents arbitrary substring matches)
- type_multiplier: 1.5x (compound), 1.0x (single)
- Minimum score threshold: 3.0 (only terms meeting this threshold are shown)

| Term | Type | Count | Header Mult | Type Mult | Local Score |
|------|------|-------|-------------|-----------|-------------|
| object initialization | compound | 10 | 1.50x | 1.50x | 22.5 |
| anonymous types | compound | 8 | 1.25x | 1.50x | 15.0 |
| collection properties | compound | 8 | 1.25x | 1.50x | 15.0 |
| init properties | compound | 6 | 1.10x | 1.50x | 9.9 |
| required members | compound | 5 | 1.25x | 1.50x | 9.4 |
| use | single | 9 | 1.00x | 1.00x | 9.0 |
| collection expressions | compound | 5 | 1.10x | 1.50x | 8.2 |
| initializers | single | 7 | 1.00x | 1.00x | 7.0 |
| init-only properties | compound | 3 | 1.25x | 1.50x | 5.6 |
| constructor | single | 4 | 1.00x | 1.00x | 4.0 |
| immutable | single | 4 | 1.00x | 1.00x | 4.0 |
| patterns | single | 4 | 1.00x | 1.00x | 4.0 |
| records | single | 4 | 1.00x | 1.00x | 4.0 |
| factory methods | compound | 2 | 1.10x | 1.50x | 3.3 |
| constructors | single | 3 | 1.00x | 1.00x | 3.0 |
| during | single | 3 | 1.00x | 1.00x | 3.0 |
| init-only | single | 3 | 1.00x | 1.00x | 3.0 |
| initialization | single | 3 | 1.00x | 1.00x | 3.0 |
| initialize | single | 3 | 1.00x | 1.00x | 3.0 |
| known | single | 3 | 1.00x | 1.00x | 3.0 |
| nested | single | 3 | 1.00x | 1.00x | 3.0 |
| object | single | 3 | 1.00x | 1.00x | 3.0 |
| pre-size | compound | 2 | 1.00x | 1.50x | 3.0 |
| setting | single | 3 | 1.00x | 1.00x | 3.0 |
