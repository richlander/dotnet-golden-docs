# Keywords for type-extensions

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
| extension | single | 16 | 1.00x | 1.00x | 2.0x | 32.000 |
| extension members | compound | 8 | 1.10x | 1.50x | 2.0x | 26.400 |
| extensions | single | 10 | 1.00x | 1.00x | 2.0x | 20.000 |
| extension methods | compound | 5 | 1.10x | 1.50x | 2.0x | 16.500 |
| operators | single | 7 | 1.00x | 1.00x | 2.0x | 14.000 |
| extension method | compound | 3 | 1.10x | 1.50x | 2.0x | 9.900 |
| extension operators | compound | 3 | 1.10x | 1.50x | 2.0x | 9.900 |
| type extensions | compound | 2 | 1.50x | 1.50x | 2.0x | 9.000 |
| blocks | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| operator | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| static | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| modern syntax | compound | 2 | 1.25x | 1.50x | 2.0x | 7.500 |
| adapter pattern | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| binary compatibility | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| domain-specific | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| extension syntax | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| group related extensions | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| new code | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| add | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| enable | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| existing | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| fluent | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| interfaces | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| original | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| query | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| third-party | compound | 2 | 1.00x | 1.50x | 2.0x | 6.000 |
| unified | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| control | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
| don't | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
