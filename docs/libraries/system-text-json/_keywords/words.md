# Unified Local Analysis

Combined 3 compound terms and 148 single words
Total unique terms: 151
Terms with score ≥ 3.0: 15
Total term occurrences: 214
Header-based scoring: enabled

Scoring formula: LocalScore = count × header_multiplier × type_multiplier
- header_multiplier (compounds only): 1.5x (H1), 1.25x (H2), 1.1x (H3+), 1.0x (none)
  - Single words do NOT get header multipliers (prevents arbitrary matches)
  - Exception: Acronyms (all-caps, 2+ letters) get 1.25x boost regardless
- type_multiplier: 1.5x (compound), 1.0x (single)
- Minimum score threshold: 3.0 (only terms meeting this threshold are shown)

| Term | Type | Count | Header Mult | Type Mult | Local Score |
|------|------|-------|-------------|-----------|-------------|
| source generation | compound | 7 | 1.10x | 1.50x | 11.6 |
| json | single | 10 | 1.00x | 1.00x | 10.0 |
| compile-time | compound | 3 | 1.00x | 1.50x | 4.5 |
| default | single | 4 | 1.00x | 1.00x | 4.0 |
| newtonsoft | single | 4 | 1.00x | 1.00x | 4.0 |
| high-performance | compound | 2 | 1.10x | 1.50x | 3.3 |
| apis | single | 3 | 1.00x | 1.00x | 3.0 |
| limits | single | 3 | 1.00x | 1.00x | 3.0 |
| operations | single | 3 | 1.00x | 1.00x | 3.0 |
| performance | single | 3 | 1.00x | 1.00x | 3.0 |
| requires | single | 3 | 1.00x | 1.00x | 3.0 |
| serialization | single | 3 | 1.00x | 1.00x | 3.0 |
| text | single | 3 | 1.00x | 1.00x | 3.0 |
| use | single | 3 | 1.00x | 1.00x | 3.0 |
| utf-8 | single | 3 | 1.00x | 1.00x | 3.0 |
