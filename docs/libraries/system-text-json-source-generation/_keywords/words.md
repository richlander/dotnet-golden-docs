# Keywords for system-text-json-source-generation

Combined local and global scoring:
- Score = count × header_mult × type_mult × global_mult
- header_mult: 1.5x (H1), 1.25x (H2), 1.1x (H3+), 1.0x (none) [compounds only]
- type_mult: 1.5x (compound), 1.0x (single)
- global_mult: 2.0x (<10% of topics), 1.5x (10-25%), 1.0x (≥25%)

| Term | Type | Count | Header Mult | Type Mult | Global Mult | Score |
|------|------|-------|-------------|-----------|-------------|-------|
| source generation | compound | 13 | 1.50x | 1.50x | 1.5x | 43.875 |
| json | single | 16 | 1.00x | 1.00x | 1.5x | 24.000 |
| reflection-based | compound | 5 | 1.00x | 1.50x | 2.0x | 15.000 |
| serialization | single | 9 | 1.00x | 1.00x | 1.5x | 13.500 |
| aot applications | compound | 4 | 1.10x | 1.50x | 2.0x | 13.200 |
| context | single | 6 | 1.00x | 1.00x | 2.0x | 12.000 |
| errors | single | 6 | 1.00x | 1.00x | 2.0x | 12.000 |
| naming | single | 6 | 1.00x | 1.00x | 2.0x | 12.000 |
| newtonsoft.json | compound | 3 | 1.25x | 1.50x | 2.0x | 11.250 |
| scenarios | single | 5 | 1.00x | 1.00x | 2.0x | 10.000 |
| aot compatibility | compound | 3 | 1.10x | 1.50x | 2.0x | 9.900 |
| system.text.json source generation | compound | 2 | 1.50x | 1.50x | 2.0x | 9.000 |
| code | single | 8 | 1.00x | 1.00x | 1.0x | 8.000 |
| runtime | single | 8 | 1.00x | 1.00x | 1.0x | 8.000 |
| migration | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| newtonsoft | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| overhead | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| text | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| these | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| property naming policies | compound | 2 | 1.25x | 1.50x | 2.0x | 7.500 |
| native aot | compound | 3 | 1.10x | 1.50x | 1.5x | 7.425 |
| patterns | single | 7 | 1.00x | 1.00x | 1.0x | 7.000 |
| compile-time | compound | 3 | 1.00x | 1.50x | 1.5x | 6.750 |
| system.text.json | compound | 2 | 1.50x | 1.50x | 1.5x | 6.750 |
| aot compilation | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| let source generation handle | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| source generation handle naming | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| unconstrained generics | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| system | single | 4 | 1.00x | 1.00x | 1.5x | 6.000 |
| utf-8 | single | 4 | 1.00x | 1.00x | 1.5x | 6.000 |
| cannot | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| deployments | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| generic | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| jsonpropertyname | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| need | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| parameters | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| type-safe | compound | 2 | 1.00x | 1.50x | 2.0x | 6.000 |
| usage | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| warnings | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| works | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| use | single | 5 | 1.00x | 1.00x | 1.0x | 5.000 |
| common | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
| enables | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
| high-performance | compound | 2 | 1.00x | 1.50x | 1.5x | 4.500 |
| options | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
| using | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
