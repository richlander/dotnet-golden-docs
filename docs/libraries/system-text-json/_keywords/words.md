# Keywords for system-text-json

Combined local and global scoring:
- Score = count × header_mult × type_mult × global_mult
- header_mult: 1.5x (H1), 1.25x (H2), 1.1x (H3+), 1.0x (none) [compounds only]
- type_mult: 1.5x (compound), 1.0x (single)
- global_mult: 2.0x (<10% of topics), 1.5x (10-25%), 1.0x (≥25%)

| Term | Type | Count | Header Mult | Type Mult | Global Mult | Score |
|------|------|-------|-------------|-----------|-------------|-------|
| json | single | 15 | 1.00x | 1.00x | 1.5x | 22.500 |
| source generation | compound | 7 | 1.10x | 1.50x | 1.5x | 17.325 |
| system.text.json | compound | 5 | 1.50x | 1.50x | 1.5x | 16.875 |
| newtonsoft.json | compound | 4 | 1.10x | 1.50x | 2.0x | 13.200 |
| serialization | single | 7 | 1.00x | 1.00x | 1.5x | 10.500 |
| default | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| newtonsoft | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| compile-time | compound | 3 | 1.00x | 1.50x | 1.5x | 6.750 |
| limits | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| requires | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| text | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| apis | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
| system | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
| utf-8 | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
| configuration | single | 4 | 1.00x | 1.00x | 1.0x | 4.000 |
| use | single | 3 | 1.00x | 1.00x | 1.0x | 3.000 |
