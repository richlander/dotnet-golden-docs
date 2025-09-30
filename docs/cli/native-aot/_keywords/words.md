# Unified Local Analysis

Combined 5 compound terms and 178 single words
Total unique terms: 183
Terms with score ≥ 3.0: 13
Total term occurrences: 246
Header-based scoring: enabled

Scoring formula: LocalScore = count × header_multiplier × type_multiplier
- header_multiplier (compounds only): 1.5x (H1), 1.25x (H2), 1.1x (H3+), 1.0x (none)
  - Single words do NOT get header multipliers (prevents arbitrary matches)
  - Exception: Acronyms (all-caps, 2+ letters) get 1.25x boost regardless
- type_multiplier: 1.5x (compound), 1.0x (single)
- Minimum score threshold: 3.0 (only terms meeting this threshold are shown)

| Term | Type | Count | Header Mult | Type Mult | Local Score |
|------|------|-------|-------------|-----------|-------------|
| native aot | compound | 6 | 1.50x | 1.50x | 13.5 |
| runtime | single | 7 | 1.00x | 1.00x | 7.0 |
| no | single | 6 | 1.00x | 1.00x | 6.0 |
| code | single | 5 | 1.00x | 1.00x | 5.0 |
| compilation | single | 5 | 1.00x | 1.00x | 5.0 |
| self-contained | compound | 3 | 1.00x | 1.50x | 4.5 |
| jit | single | 4 | 1.00x | 1.00x | 4.0 |
| supported | single | 4 | 1.00x | 1.00x | 4.0 |
| aot-compatible | compound | 2 | 1.10x | 1.50x | 3.3 |
| cross-compilation | compound | 2 | 1.10x | 1.50x | 3.3 |
| single-file | compound | 2 | 1.00x | 1.50x | 3.0 |
| startup | single | 3 | 1.00x | 1.00x | 3.0 |
| without | single | 3 | 1.00x | 1.00x | 3.0 |
