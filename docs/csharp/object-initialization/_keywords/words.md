# Unified Local Analysis

Combined 9 compound terms and 98 single words
Total unique terms: 107
Terms with score ≥ 3.0: 22
Total term occurrences: 171
Header-based scoring: enabled

Scoring formula: LocalScore = count × header_multiplier × type_multiplier
- header_multiplier (compounds only): 1.5x (H1), 1.25x (H2), 1.1x (H3+), 1.0x (none)
  - Single words do NOT get header multipliers (prevents arbitrary matches)
  - Exception: Acronyms (all-caps, 2+ letters) get 1.25x boost regardless
- type_multiplier: 1.5x (compound), 1.0x (single)
- Minimum score threshold: 3.0 (only terms meeting this threshold are shown)

| Term | Type | Count | Header Mult | Type Mult | Local Score |
|------|------|-------|-------------|-----------|-------------|
| object initialization | compound | 6 | 1.50x | 1.50x | 13.5 |
| anonymous types | compound | 6 | 1.25x | 1.50x | 11.2 |
| properties | single | 6 | 1.00x | 1.00x | 6.0 |
| required members | compound | 3 | 1.25x | 1.50x | 5.6 |
| use | single | 5 | 1.00x | 1.00x | 5.0 |
| init properties | compound | 3 | 1.10x | 1.50x | 5.0 |
| basic | single | 4 | 1.00x | 1.00x | 4.0 |
| code | single | 4 | 1.00x | 1.00x | 4.0 |
| constructor | single | 4 | 1.00x | 1.00x | 4.0 |
| object | single | 4 | 1.00x | 1.00x | 4.0 |
| objects | single | 4 | 1.00x | 1.00x | 4.0 |
| anti-patterns | compound | 2 | 1.25x | 1.50x | 3.8 |
| collection initialization within | compound | 2 | 1.25x | 1.50x | 3.8 |
| init-only properties | compound | 2 | 1.25x | 1.50x | 3.8 |
| initialization within objects | compound | 2 | 1.25x | 1.50x | 3.8 |
| object initializer syntax | compound | 2 | 1.25x | 1.50x | 3.8 |
| constructors | single | 3 | 1.00x | 1.00x | 3.0 |
| immutable | single | 3 | 1.00x | 1.00x | 3.0 |
| modern | single | 3 | 1.00x | 1.00x | 3.0 |
| patterns | single | 3 | 1.00x | 1.00x | 3.0 |
| records | single | 3 | 1.00x | 1.00x | 3.0 |
| required | single | 3 | 1.00x | 1.00x | 3.0 |
