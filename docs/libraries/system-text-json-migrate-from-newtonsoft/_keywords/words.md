# Keywords for system-text-json-migrate-from-newtonsoft

Combined local and global scoring:
- Score = count × header_mult × type_mult × global_mult
- header_mult: 1.5x (H1), 1.25x (H2), 1.1x (H3+), 1.0x (none) [compounds only]
- type_mult: 1.5x (compound), 1.0x (single)
- global_mult: 2.0x (<10% of topics), 1.5x (10-25%), 1.0x (≥25%)

| Term | Type | Count | Header Mult | Type Mult | Global Mult | Score |
|------|------|-------|-------------|-----------|-------------|-------|
| newtonsoft.json | compound | 16 | 1.50x | 1.50x | 2.0x | 72.000 |
| system.text.json | compound | 17 | 1.50x | 1.50x | 1.5x | 57.375 |
| newtonsoft | single | 16 | 1.00x | 1.00x | 2.0x | 32.000 |
| json | single | 24 | 1.00x | 1.00x | 1.0x | 24.000 |
| custom converters | compound | 5 | 1.25x | 1.50x | 2.0x | 18.750 |
| system | single | 16 | 1.00x | 1.00x | 1.0x | 16.000 |
| text | single | 15 | 1.00x | 1.00x | 1.0x | 15.000 |
| configurable | single | 6 | 1.00x | 1.00x | 2.0x | 12.000 |
| serialization | single | 6 | 1.00x | 1.00x | 1.5x | 9.000 |
| different | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| jsonnode | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| mappings | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| rejected | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| attributes | single | 5 | 1.00x | 1.00x | 1.5x | 7.500 |
| trailing commas | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| dom | single | 4 | 1.00x | 1.00x | 1.5x | 6.000 |
| differences | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| equivalent | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| existing | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| namespaces | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| quotes | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| serialized | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| read-only | compound | 2 | 1.10x | 1.50x | 1.5x | 4.950 |
| behavior | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
