# Unified Local Analysis

Combined 5 compound terms and 107 single words
Total unique terms: 112
Terms with score ≥ 3.0: 17
Total term occurrences: 173
Header-based scoring: enabled

Scoring formula: LocalScore = count × header_multiplier × type_multiplier
- header_multiplier (compounds only): 1.5x (H1), 1.25x (H2), 1.1x (H3+), 1.0x (none)
  - Single words do NOT get header multipliers (prevents arbitrary substring matches)
- type_multiplier: 1.5x (compound), 1.0x (single)
- Minimum score threshold: 3.0 (only terms meeting this threshold are shown)

| Term | Type | Count | Header Mult | Type Mult | Local Score |
|------|------|-------|-------------|-----------|-------------|
| build | single | 15 | 1.00x | 1.00x | 15.0 |
| configuration | single | 5 | 1.00x | 1.00x | 5.0 |
| ci | single | 4 | 1.00x | 1.00x | 4.0 |
| build acceleration | compound | 2 | 1.25x | 1.50x | 3.8 |
| performance optimization | compound | 2 | 1.25x | 1.50x | 3.8 |
| custom build configurations | compound | 2 | 1.10x | 1.50x | 3.3 |
| dependency resolution | compound | 2 | 1.10x | 1.50x | 3.3 |
| msbuild integration | compound | 2 | 1.10x | 1.50x | 3.3 |
| analysis | single | 3 | 1.00x | 1.00x | 3.0 |
| builds | single | 3 | 1.00x | 1.00x | 3.0 |
| code | single | 3 | 1.00x | 1.00x | 3.0 |
| commands | single | 3 | 1.00x | 1.00x | 3.0 |
| compilation | single | 3 | 1.00x | 1.00x | 3.0 |
| multiple | single | 3 | 1.00x | 1.00x | 3.0 |
| nuget | single | 3 | 1.00x | 1.00x | 3.0 |
| parallel | single | 3 | 1.00x | 1.00x | 3.0 |
| workflows | single | 3 | 1.00x | 1.00x | 3.0 |
