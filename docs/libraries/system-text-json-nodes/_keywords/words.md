# Keywords for system-text-json-nodes

Combined local and global scoring:
- Score = count × header_mult × type_mult × global_mult
- header_mult: 1.5x (H1), 1.25x (H2), 1.1x (H3+), 1.0x (none) [compounds only]
- type_mult: 1.5x (compound), 1.0x (single)
- global_mult: 2.0x (<10% of topics), 1.5x (10-25%), 1.0x (≥25%)

| Term | Type | Count | Header Mult | Type Mult | Global Mult | Score |
|------|------|-------|-------------|-----------|-------------|-------|
| json | single | 32 | 1.00x | 1.00x | 1.0x | 32.000 |
| system.text.json.nodes | compound | 6 | 1.50x | 1.50x | 2.0x | 27.000 |
| json documents | compound | 6 | 1.25x | 1.50x | 2.0x | 22.500 |
| nodes | single | 10 | 1.00x | 1.00x | 2.0x | 20.000 |
| strongly-typed | compound | 7 | 1.25x | 1.50x | 1.5x | 19.688 |
| read-only | compound | 6 | 1.00x | 1.50x | 1.5x | 13.500 |
| type safety | compound | 4 | 1.10x | 1.50x | 2.0x | 13.200 |
| strongly-typed objects | compound | 3 | 1.25x | 1.50x | 2.0x | 11.250 |
| access | single | 7 | 1.00x | 1.00x | 1.5x | 10.500 |
| runtime | single | 10 | 1.00x | 1.00x | 1.0x | 10.000 |
| better | single | 5 | 1.00x | 1.00x | 2.0x | 10.000 |
| between | single | 5 | 1.00x | 1.00x | 2.0x | 10.000 |
| flexibility | single | 5 | 1.00x | 1.00x | 2.0x | 10.000 |
| parse | single | 5 | 1.00x | 1.00x | 2.0x | 10.000 |
| type-safe | compound | 3 | 1.00x | 1.50x | 2.0x | 9.000 |
| indexer | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| merging | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| modify | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| structure | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| unknown | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| dynamic | single | 5 | 1.00x | 1.00x | 1.5x | 7.500 |
| into | single | 5 | 1.00x | 1.00x | 1.5x | 7.500 |
| building json | compound | 2 | 1.25x | 1.50x | 2.0x | 7.500 |
| json proxy middleware | compound | 2 | 1.25x | 1.50x | 2.0x | 7.500 |
| reading values | compound | 2 | 1.25x | 1.50x | 2.0x | 7.500 |
| use | single | 7 | 1.00x | 1.00x | 1.0x | 7.000 |
| compile-time | compound | 4 | 1.00x | 1.50x | 1.0x | 6.000 |
| text | single | 6 | 1.00x | 1.00x | 1.0x | 6.000 |
| mutable | single | 4 | 1.00x | 1.00x | 1.5x | 6.000 |
| property | single | 4 | 1.00x | 1.00x | 1.5x | 6.000 |
| construction | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| document object model | compound | 2 | 1.00x | 1.50x | 2.0x | 6.000 |
| sources | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| tree | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| provides | single | 5 | 1.00x | 1.00x | 1.0x | 5.000 |
| values | single | 5 | 1.00x | 1.00x | 1.0x | 5.000 |
| without | single | 5 | 1.00x | 1.00x | 1.0x | 5.000 |
| dom | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
| known | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
| modification | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
| multiple | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
| offers | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
| structures | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
| system | single | 4 | 1.00x | 1.00x | 1.0x | 4.000 |
| code | single | 3 | 1.00x | 1.00x | 1.0x | 3.000 |
