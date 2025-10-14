# Unified Local Analysis

Combined 13 compound terms and 152 single words
Total unique terms: 162
Terms with score ≥ 3.0: 26
Total term occurrences: 265
Header-based scoring: enabled

Scoring formula: LocalScore = count × header_multiplier × type_multiplier
- header_multiplier (compounds only): 1.5x (H1), 1.25x (H2), 1.1x (H3+), 1.0x (none)
  - Single words do NOT get header multipliers (prevents arbitrary substring matches)
- type_multiplier: 1.5x (compound), 1.0x (single)
- Minimum score threshold: 3.0 (only terms meeting this threshold are shown)

| Term | Type | Count | Header Mult | Type Mult | Local Score |
|------|------|-------|-------------|-----------|-------------|
| source generation | compound | 7 | 1.50x | 1.50x | 15.8 |
| compile-time | compound | 9 | 1.00x | 1.50x | 13.5 |
| system.text.json source generation | compound | 5 | 1.50x | 1.50x | 11.2 |
| runtime | single | 8 | 1.00x | 1.00x | 8.0 |
| naming policies | compound | 4 | 1.25x | 1.50x | 7.5 |
| code | single | 6 | 1.00x | 1.00x | 6.0 |
| generic methods | compound | 3 | 1.25x | 1.50x | 5.6 |
| use | single | 5 | 1.00x | 1.00x | 5.0 |
| aot compatibility | compound | 3 | 1.10x | 1.50x | 5.0 |
| native aot | compound | 3 | 1.10x | 1.50x | 5.0 |
| native aot applications | compound | 3 | 1.10x | 1.50x | 5.0 |
| aot-compatible | compound | 3 | 1.00x | 1.50x | 4.5 |
| reflection-based | compound | 3 | 1.00x | 1.50x | 4.5 |
| attributes | single | 4 | 1.00x | 1.00x | 4.0 |
| serialization | single | 4 | 1.00x | 1.00x | 4.0 |
| utf-8 | single | 4 | 1.00x | 1.00x | 4.0 |
| asp.net core web apis | compound | 2 | 1.25x | 1.50x | 3.8 |
| multiple contexts | compound | 2 | 1.25x | 1.50x | 3.8 |
| performance optimization | compound | 2 | 1.10x | 1.50x | 3.3 |
| apis | single | 3 | 1.00x | 1.00x | 3.0 |
| asp | single | 3 | 1.00x | 1.00x | 3.0 |
| mandatory | single | 3 | 1.00x | 1.00x | 3.0 |
| overhead | single | 3 | 1.00x | 1.00x | 3.0 |
| startup | single | 3 | 1.00x | 1.00x | 3.0 |
| system | single | 3 | 1.00x | 1.00x | 3.0 |
| text | single | 3 | 1.00x | 1.00x | 3.0 |
