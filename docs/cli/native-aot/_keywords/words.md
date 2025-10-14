# Keywords for native-aot

Combined local and global scoring:
- Score = count × header_mult × type_mult × global_mult
- header_mult: 1.5x (H1), 1.25x (H2), 1.1x (H3+), 1.0x (none) [compounds only]
- type_mult: 1.5x (compound), 1.0x (single)
- global_mult: 2.0x (<10% of topics), 1.5x (10-25%), 1.0x (≥25%)

| Term | Type | Count | Header Mult | Type Mult | Global Mult | Score |
|------|------|-------|-------------|-----------|-------------|-------|
| native aot | compound | 10 | 1.50x | 1.50x | 1.5x | 33.750 |
| compilation | single | 9 | 1.00x | 1.00x | 1.5x | 13.500 |
| runtime | single | 11 | 1.00x | 1.00x | 1.0x | 11.000 |
| source generation | compound | 4 | 1.10x | 1.50x | 1.5x | 9.900 |
| no | single | 6 | 1.00x | 1.00x | 1.5x | 9.000 |
| reflection-based | compound | 4 | 1.00x | 1.50x | 1.5x | 9.000 |
| jit | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| supported | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| using native aot | compound | 2 | 1.25x | 1.50x | 2.0x | 7.500 |
| code | single | 7 | 1.00x | 1.00x | 1.0x | 7.000 |
| self-contained | compound | 3 | 1.00x | 1.50x | 1.5x | 6.750 |
| system.text.json source generation | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| smaller | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| generic methods | compound | 2 | 1.10x | 1.50x | 1.5x | 4.950 |
| deployment | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
| single-file | compound | 2 | 1.00x | 1.50x | 1.5x | 4.500 |
| startup | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
| without | single | 3 | 1.00x | 1.00x | 1.0x | 3.000 |
