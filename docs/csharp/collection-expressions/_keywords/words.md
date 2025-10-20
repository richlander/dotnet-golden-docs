# Keywords for collection-expressions

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
| collection expressions | compound | 16 | 1.50x | 1.50x | 2.0x | 72.000 |
| collection types | compound | 4 | 1.10x | 1.50x | 2.0x | 13.200 |
| target type | compound | 4 | 1.10x | 1.50x | 2.0x | 13.200 |
| syntax | single | 6 | 1.00x | 1.00x | 2.0x | 12.000 |
| spread | single | 5 | 1.00x | 1.00x | 2.0x | 10.000 |
| familiar | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| spread element | compound | 2 | 1.25x | 1.50x | 2.0x | 7.500 |
| using collection expressions | compound | 2 | 1.25x | 1.50x | 2.0x | 7.500 |
| compile-time constants | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| inline arrays | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| combine | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| concise | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| javascript | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| provide | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| python | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
