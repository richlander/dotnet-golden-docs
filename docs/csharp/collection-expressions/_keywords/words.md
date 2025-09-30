# Unified Local Analysis

Combined 8 compound terms and 152 single words
Total unique terms: 160
Terms with score ≥ 3.0: 19
Total term occurrences: 244
Header-based scoring: enabled

Scoring formula: LocalScore = count × header_multiplier × type_multiplier
- header_multiplier (compounds only): 1.5x (H1), 1.25x (H2), 1.1x (H3+), 1.0x (none)
  - Single words do NOT get header multipliers (prevents arbitrary matches)
  - Exception: Acronyms (all-caps, 2+ letters) get 1.25x boost regardless
- type_multiplier: 1.5x (compound), 1.0x (single)
- Minimum score threshold: 3.0 (only terms meeting this threshold are shown)

| Term | Type | Count | Header Mult | Type Mult | Local Score |
|------|------|-------|-------------|-----------|-------------|
| collection expressions | compound | 16 | 1.50x | 1.50x | 36.0 |
| collection types | compound | 5 | 1.10x | 1.50x | 8.2 |
| target type | compound | 5 | 1.10x | 1.50x | 8.2 |
| syntax | single | 8 | 1.00x | 1.00x | 8.0 |
| collections | single | 6 | 1.00x | 1.00x | 6.0 |
| spread | single | 5 | 1.00x | 1.00x | 5.0 |
| familiar | single | 4 | 1.00x | 1.00x | 4.0 |
| params | single | 4 | 1.00x | 1.00x | 4.0 |
| use | single | 4 | 1.00x | 1.00x | 4.0 |
| spread element | compound | 2 | 1.25x | 1.50x | 3.8 |
| type inference | compound | 2 | 1.25x | 1.50x | 3.8 |
| compile-time | compound | 2 | 1.10x | 1.50x | 3.3 |
| compile-time constants | compound | 2 | 1.10x | 1.50x | 3.3 |
| inline arrays | compound | 2 | 1.10x | 1.50x | 3.3 |
| combine | single | 3 | 1.00x | 1.00x | 3.0 |
| concise | single | 3 | 1.00x | 1.00x | 3.0 |
| javascript | single | 3 | 1.00x | 1.00x | 3.0 |
| provide | single | 3 | 1.00x | 1.00x | 3.0 |
| python | single | 3 | 1.00x | 1.00x | 3.0 |
