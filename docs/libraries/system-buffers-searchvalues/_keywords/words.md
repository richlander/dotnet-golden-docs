# Keywords for system-buffers-searchvalues

Combined local and global scoring:
- Score = count × header_mult × type_mult × global_mult
- header_mult: 1.5x (H1), 1.25x (H2), 1.1x (H3+), 1.0x (none) [compounds only]
- type_mult: 1.5x (compound), 1.0x (single)
- global_mult: 2.0x (<10% of topics), 1.5x (10-25%), 1.0x (≥25%)

| Term | Type | Count | Header Mult | Type Mult | Global Mult | Score |
|------|------|-------|-------------|-----------|-------------|-------|
| searchvalues | single | 16 | 1.00x | 1.00x | 2.0x | 32.000 |
| searches | single | 7 | 1.00x | 1.00x | 2.0x | 14.000 |
| allocation-free | compound | 4 | 1.00x | 1.50x | 2.0x | 12.000 |
| characters | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| creating searchvalues | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| character | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| once | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| pre-computed | compound | 2 | 1.00x | 1.50x | 2.0x | 6.000 |
| searching | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| set | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| span-based | compound | 2 | 1.00x | 1.50x | 2.0x | 6.000 |
| substring | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| used | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| high-performance | compound | 2 | 1.25x | 1.50x | 1.5x | 5.625 |
| values | single | 5 | 1.00x | 1.00x | 1.0x | 5.000 |
| multiple | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
| provides | single | 4 | 1.00x | 1.00x | 1.0x | 4.000 |
