# Unified Local Analysis

Combined 13 compound terms and 143 single words
Total unique terms: 150
Terms with score ≥ 3.0: 34
Total term occurrences: 282
Header-based scoring: enabled

Scoring formula: LocalScore = count × header_multiplier × type_multiplier
- header_multiplier (compounds only): 1.5x (H1), 1.25x (H2), 1.1x (H3+), 1.0x (none)
  - Single words do NOT get header multipliers (prevents arbitrary substring matches)
- type_multiplier: 1.5x (compound), 1.0x (single)
- Minimum score threshold: 3.0 (only terms meeting this threshold are shown)

| Term | Type | Count | Header Mult | Type Mult | Local Score |
|------|------|-------|-------------|-----------|-------------|
| read-only | compound | 5 | 1.25x | 1.50x | 9.4 |
| accessor | single | 9 | 1.00x | 1.00x | 9.0 |
| backing | single | 8 | 1.00x | 1.00x | 8.0 |
| keyword | single | 8 | 1.00x | 1.00x | 8.0 |
| auto-implemented properties | compound | 4 | 1.25x | 1.50x | 7.5 |
| computed properties | compound | 4 | 1.25x | 1.50x | 7.5 |
| init-only properties | compound | 4 | 1.25x | 1.50x | 7.5 |
| field | single | 7 | 1.00x | 1.00x | 7.0 |
| backing fields | compound | 3 | 1.50x | 1.50x | 6.8 |
| primary | single | 6 | 1.00x | 1.00x | 6.0 |
| records | single | 6 | 1.00x | 1.00x | 6.0 |
| use | single | 6 | 1.00x | 1.00x | 6.0 |
| field-backed properties | compound | 3 | 1.25x | 1.50x | 5.6 |
| required properties | compound | 3 | 1.25x | 1.50x | 5.6 |
| cannot | single | 5 | 1.00x | 1.00x | 5.0 |
| auto-property | compound | 3 | 1.00x | 1.50x | 4.5 |
| accessors | single | 4 | 1.00x | 1.00x | 4.0 |
| auto-implemented | single | 4 | 1.00x | 1.00x | 4.0 |
| constructors | single | 4 | 1.00x | 1.00x | 4.0 |
| logic | single | 4 | 1.00x | 1.00x | 4.0 |
| need | single | 4 | 1.00x | 1.00x | 4.0 |
| restrictive | single | 4 | 1.00x | 1.00x | 4.0 |
| access modifiers | compound | 2 | 1.25x | 1.50x | 3.8 |
| init-only | compound | 2 | 1.25x | 1.50x | 3.8 |
| compiler-generated | compound | 2 | 1.00x | 1.50x | 3.0 |
| compiler-synthesized | compound | 2 | 1.00x | 1.50x | 3.0 |
| construction | single | 3 | 1.00x | 1.00x | 3.0 |
| constructor | single | 3 | 1.00x | 1.00x | 3.0 |
| directly | single | 3 | 1.00x | 1.00x | 3.0 |
| expression-bodied | compound | 2 | 1.00x | 1.50x | 3.0 |
| field-backed | single | 3 | 1.00x | 1.00x | 3.0 |
| initializers | single | 3 | 1.00x | 1.00x | 3.0 |
| set | single | 3 | 1.00x | 1.00x | 3.0 |
| setter | single | 3 | 1.00x | 1.00x | 3.0 |
