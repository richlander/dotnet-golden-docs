# Keywords for object-initialization

Combined local and global scoring:
- Score = count × header_mult × type_mult × global_mult
- header_mult: 1.5x (H1), 1.25x (H2), 1.1x (H3+), 1.0x (none) [compounds only]
- type_mult: 1.5x (compound), 1.0x (single)
- global_mult: 2.0x (<10% of topics), 1.5x (10-25%), 1.0x (≥25%)

| Term | Type | Count | Header Mult | Type Mult | Global Mult | Score |
|------|------|-------|-------------|-----------|-------------|-------|
| object initialization | compound | 9 | 1.50x | 1.50x | 2.0x | 40.500 |
| anonymous types | compound | 8 | 1.25x | 1.50x | 2.0x | 30.000 |
| collection properties | compound | 8 | 1.25x | 1.50x | 2.0x | 30.000 |
| init properties | compound | 6 | 1.10x | 1.50x | 2.0x | 19.800 |
| required members | compound | 5 | 1.25x | 1.50x | 2.0x | 18.750 |
| objects | single | 8 | 1.00x | 1.00x | 2.0x | 16.000 |
| constructor | single | 7 | 1.00x | 1.00x | 2.0x | 14.000 |
| initialization | single | 7 | 1.00x | 1.00x | 2.0x | 14.000 |
| initializers | single | 7 | 1.00x | 1.00x | 2.0x | 14.000 |
| properties | single | 7 | 1.00x | 1.00x | 2.0x | 14.000 |
| collection expressions | compound | 5 | 1.10x | 1.50x | 1.5x | 12.375 |
| init-only properties | compound | 3 | 1.25x | 1.50x | 2.0x | 11.250 |
| constructors | single | 5 | 1.00x | 1.00x | 2.0x | 10.000 |
| object | single | 5 | 1.00x | 1.00x | 2.0x | 10.000 |
| use | single | 9 | 1.00x | 1.00x | 1.0x | 9.000 |
| immutable | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| parameters | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| records | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| required | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| factory methods | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| during | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| init-only | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| initialize | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| known | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| nested | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| pre-size | compound | 2 | 1.00x | 1.50x | 2.0x | 6.000 |
| setting | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| patterns | single | 5 | 1.00x | 1.00x | 1.0x | 5.000 |
| syntax | single | 3 | 1.00x | 1.00x | 1.0x | 3.000 |
