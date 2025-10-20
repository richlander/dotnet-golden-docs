# Keywords for csharp-14-features

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
| assignment | single | 6 | 1.00x | 1.00x | 2.0x | 12.000 |
| extension | single | 5 | 1.00x | 1.00x | 2.0x | 10.000 |
| compile-time | compound | 4 | 1.00x | 1.50x | 1.5x | 9.000 |
| zero-allocation | compound | 3 | 1.25x | 1.50x | 1.5x | 8.438 |
| enhanced | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| keyword | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| params collections | compound | 2 | 1.25x | 1.50x | 2.0x | 7.500 |
| expression trees | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| first-class span | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| named arguments | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| first-class | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| stack-only | compound | 2 | 1.00x | 1.50x | 2.0x | 6.000 |
