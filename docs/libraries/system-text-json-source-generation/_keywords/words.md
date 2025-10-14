# Keywords for system-text-json-source-generation

Combined local and global scoring:
- Score = count × header_mult × type_mult × global_mult
- header_mult: 1.5x (H1), 1.25x (H2), 1.1x (H3+), 1.0x (none) [compounds only]
- type_mult: 1.5x (compound), 1.0x (single)
- global_mult: 2.0x (<10% of topics), 1.5x (10-25%), 1.0x (≥25%)

| Term | Type | Count | Header Mult | Type Mult | Global Mult | Score |
|------|------|-------|-------------|-----------|-------------|-------|
| source generation | compound | 7 | 1.50x | 1.50x | 1.5x | 23.625 |
| system.text.json source generation | compound | 5 | 1.50x | 1.50x | 2.0x | 22.500 |
| naming policies | compound | 4 | 1.25x | 1.50x | 2.0x | 15.000 |
| compile-time | compound | 9 | 1.00x | 1.50x | 1.0x | 13.500 |
| aot compatibility | compound | 3 | 1.10x | 1.50x | 2.0x | 9.900 |
| native aot applications | compound | 3 | 1.10x | 1.50x | 2.0x | 9.900 |
| aot-compatible | compound | 3 | 1.00x | 1.50x | 2.0x | 9.000 |
| generic methods | compound | 3 | 1.25x | 1.50x | 1.5x | 8.438 |
| runtime | single | 8 | 1.00x | 1.00x | 1.0x | 8.000 |
| asp.net core web apis | compound | 2 | 1.25x | 1.50x | 2.0x | 7.500 |
| multiple contexts | compound | 2 | 1.25x | 1.50x | 2.0x | 7.500 |
| native aot | compound | 3 | 1.10x | 1.50x | 1.5x | 7.425 |
| reflection-based | compound | 3 | 1.00x | 1.50x | 1.5x | 6.750 |
| code | single | 6 | 1.00x | 1.00x | 1.0x | 6.000 |
| attributes | single | 4 | 1.00x | 1.00x | 1.5x | 6.000 |
| serialization | single | 4 | 1.00x | 1.00x | 1.5x | 6.000 |
| utf-8 | single | 4 | 1.00x | 1.00x | 1.5x | 6.000 |
| mandatory | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| use | single | 5 | 1.00x | 1.00x | 1.0x | 5.000 |
| performance optimization | compound | 2 | 1.10x | 1.50x | 1.5x | 4.950 |
| apis | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
| asp | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
| overhead | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
| startup | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
| system | single | 3 | 1.00x | 1.00x | 1.0x | 3.000 |
| text | single | 3 | 1.00x | 1.00x | 1.0x | 3.000 |
