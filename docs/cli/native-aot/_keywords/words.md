# Unified Local Analysis

Combined 7 compound terms and 237 single words
Total unique terms: 244
Terms with score ≥ 3.0: 21
Total term occurrences: 357
Header-based scoring: enabled

Scoring formula: LocalScore = count × header_multiplier × type_multiplier
- header_multiplier (compounds only): 1.5x (H1), 1.25x (H2), 1.1x (H3+), 1.0x (none)
  - Single words do NOT get header multipliers (prevents arbitrary matches)
  - Exception: Acronyms (all-caps, 2+ letters) get 1.25x boost regardless
- type_multiplier: 1.5x (compound), 1.0x (single)
- Minimum score threshold: 3.0 (only terms meeting this threshold are shown)

| Term | Type | Count | Header Mult | Type Mult | Local Score |
|------|------|-------|-------------|-----------|-------------|
| native aot | compound | 9 | 1.50x | 1.50x | 20.2 |
| runtime | single | 11 | 1.00x | 1.00x | 11.0 |
| code | single | 7 | 1.00x | 1.00x | 7.0 |
| compilation | single | 7 | 1.00x | 1.00x | 7.0 |
| json | single | 7 | 1.00x | 1.00x | 7.0 |
| source generation | compound | 4 | 1.10x | 1.50x | 6.6 |
| no | single | 6 | 1.00x | 1.00x | 6.0 |
| reflection-based | compound | 4 | 1.00x | 1.50x | 6.0 |
| self-contained | compound | 3 | 1.00x | 1.50x | 4.5 |
| jit | single | 4 | 1.00x | 1.00x | 4.0 |
| reflection | single | 4 | 1.00x | 1.00x | 4.0 |
| serialization | single | 4 | 1.00x | 1.00x | 4.0 |
| supported | single | 4 | 1.00x | 1.00x | 4.0 |
| generic methods | compound | 2 | 1.10x | 1.50x | 3.3 |
| system.text.json source generation | compound | 2 | 1.10x | 1.50x | 3.3 |
| common | single | 3 | 1.00x | 1.00x | 3.0 |
| deployment | single | 3 | 1.00x | 1.00x | 3.0 |
| single-file | compound | 2 | 1.00x | 1.50x | 3.0 |
| smaller | single | 3 | 1.00x | 1.00x | 3.0 |
| startup | single | 3 | 1.00x | 1.00x | 3.0 |
| without | single | 3 | 1.00x | 1.00x | 3.0 |
