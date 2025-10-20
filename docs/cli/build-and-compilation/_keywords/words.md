# Keywords for build-and-compilation

Combined local and global scoring:
- Score = count × header_mult × type_mult × global_mult
- header_mult: 1.5x (H1), 1.25x (H2), 1.1x (H3+), 1.0x (none) [compounds only]
- type_mult: 1.5x (compound), 1.0x (single)
- global_mult: 2.0x (<10% of topics), 1.5x (10-25%), 1.0x (≥25%)

Filtering: Includes terms with global_mult ≥ 1.5x OR (count ≥ 10 AND appears in < 50% of topics)
- Distinctive terms (1.5x+) always included
- Common terms (1.0x) included only if substantive (≥10 occurrences) and not overly common (<50% of topics)

| Term | Type | Count | Header Mult | Type Mult | Global Mult | Score |
|------|------|-------|-------------|-----------|-------------|-------|
| build | single | 15 | 1.00x | 1.00x | 2.0x | 30.000 |
| compilation | single | 5 | 1.00x | 1.00x | 2.0x | 10.000 |
| ci | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| build acceleration | compound | 2 | 1.25x | 1.50x | 2.0x | 7.500 |
| performance optimization | compound | 2 | 1.25x | 1.50x | 2.0x | 7.500 |
| custom build configurations | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| dependency resolution | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| msbuild integration | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| builds | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| commands | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| parallel | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| workflows | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| nuget | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
