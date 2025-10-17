# Keywords for span-based-string-processing

Combined local and global scoring:
- Score = count × header_mult × type_mult × global_mult
- header_mult: 1.5x (H1), 1.25x (H2), 1.1x (H3+), 1.0x (none) [compounds only]
- type_mult: 1.5x (compound), 1.0x (single)
- global_mult: 2.0x (<10% of topics), 1.5x (10-25%), 1.0x (≥25%)

| Term | Type | Count | Header Mult | Type Mult | Global Mult | Score |
|------|------|-------|-------------|-----------|-------------|-------|
| span-based | compound | 8 | 1.50x | 1.50x | 2.0x | 36.000 |
| utf-8 | single | 20 | 1.00x | 1.00x | 1.5x | 30.000 |
| pattern matching | compound | 8 | 1.25x | 1.50x | 2.0x | 30.000 |
| allocations | single | 11 | 1.00x | 1.00x | 2.0x | 22.000 |
| strings | single | 10 | 1.00x | 1.00x | 2.0x | 20.000 |
| string normalization | compound | 5 | 1.25x | 1.50x | 2.0x | 18.750 |
| without | single | 12 | 1.00x | 1.00x | 1.5x | 18.000 |
| spans | single | 9 | 1.00x | 1.00x | 2.0x | 18.000 |
| text | single | 11 | 1.00x | 1.00x | 1.5x | 16.500 |
| span-based string processing | compound | 3 | 1.50x | 1.50x | 2.0x | 13.500 |
| use | single | 12 | 1.00x | 1.00x | 1.0x | 12.000 |
| buffers | single | 6 | 1.00x | 1.00x | 2.0x | 12.000 |
| string | single | 6 | 1.00x | 1.00x | 2.0x | 12.000 |
| utf-8 string literals | compound | 3 | 1.25x | 1.50x | 2.0x | 11.250 |
| conversion | single | 5 | 1.00x | 1.00x | 2.0x | 10.000 |
| unicode | single | 5 | 1.00x | 1.00x | 2.0x | 10.000 |
| conversions | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| encoding | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| many | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| process | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| processing | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| directly | single | 5 | 1.00x | 1.00x | 1.5x | 7.500 |
| first-class span conversions | compound | 2 | 1.25x | 1.50x | 2.0x | 7.500 |
| utf-8 hex string conversion | compound | 2 | 1.25x | 1.50x | 2.0x | 7.500 |
| utf-8 processing | compound | 2 | 1.25x | 1.50x | 2.0x | 7.500 |
| without string | compound | 2 | 1.25x | 1.50x | 2.0x | 7.500 |
| memory overhead | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| data | single | 4 | 1.00x | 1.00x | 1.5x | 6.000 |
| character | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| converting | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| first-class | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| heap | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| hex | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| normalize | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| overhead | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| searching | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| utf-16 | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| working | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| avoid | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
| instead | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
| high-performance | compound | 2 | 1.25x | 1.50x | 1.0x | 3.750 |
| patterns | single | 3 | 1.00x | 1.00x | 1.0x | 3.000 |
