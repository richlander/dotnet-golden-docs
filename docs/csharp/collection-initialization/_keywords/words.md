# Keywords for collection-initialization

Combined local and global scoring:
- Score = count × header_mult × type_mult × global_mult
- header_mult: 1.5x (H1), 1.25x (H2), 1.1x (H3+), 1.0x (none) [compounds only]
- type_mult: 1.5x (compound), 1.0x (single)
- global_mult: 2.0x (<10% of topics), 1.5x (10-25%), 1.0x (≥25%)

| Term | Type | Count | Header Mult | Type Mult | Global Mult | Score |
|------|------|-------|-------------|-----------|-------------|-------|
| collection expressions | compound | 12 | 1.25x | 1.50x | 1.5x | 33.750 |
| collection initialization | compound | 6 | 1.50x | 1.50x | 2.0x | 27.000 |
| syntax | single | 8 | 1.00x | 1.00x | 1.5x | 12.000 |
| target-typed new | compound | 3 | 1.25x | 1.50x | 2.0x | 11.250 |
| collection types | compound | 3 | 1.10x | 1.50x | 2.0x | 9.900 |
| collection initializer syntax | compound | 2 | 1.25x | 1.50x | 2.0x | 7.500 |
| values | single | 6 | 1.00x | 1.00x | 1.0x | 6.000 |
| collections | single | 4 | 1.00x | 1.00x | 1.5x | 6.000 |
| capacity | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| dictionaries | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| dictionary | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| elements | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| existing | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| know | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| offer | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| target-typed | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| upfront | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| known | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
| method | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
| provide | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
| patterns | single | 4 | 1.00x | 1.00x | 1.0x | 4.000 |
| use | single | 4 | 1.00x | 1.00x | 1.0x | 4.000 |
