# Keywords for assembly-trimming

Combined local and global scoring:
- Score = count × header_mult × type_mult × global_mult
- header_mult: 1.5x (H1), 1.25x (H2), 1.1x (H3+), 1.0x (none) [compounds only]
- type_mult: 1.5x (compound), 1.0x (single)
- global_mult: 2.0x (<10% of topics), 1.5x (10-25%), 1.0x (≥25%)

| Term | Type | Count | Header Mult | Type Mult | Global Mult | Score |
|------|------|-------|-------------|-----------|-------------|-------|
| trimming | single | 8 | 1.00x | 1.00x | 2.0x | 16.000 |
| assembly trimming | compound | 2 | 1.50x | 1.50x | 2.0x | 9.000 |
| analysis | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| reduced | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| test | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| code | single | 7 | 1.00x | 1.00x | 1.0x | 7.000 |
| desktop applications | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| framework integration | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| library development | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| deployment | single | 4 | 1.00x | 1.00x | 1.5x | 6.000 |
| build-time | compound | 2 | 1.00x | 1.50x | 2.0x | 6.000 |
| disabled | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| faster | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| generators | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| readytorun | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| reduction | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| trimmed | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| unused | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| application | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
| common | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
| compile-time | compound | 2 | 1.00x | 1.50x | 1.5x | 4.500 |
| self-contained | compound | 2 | 1.00x | 1.50x | 1.5x | 4.500 |
| single-file | compound | 2 | 1.00x | 1.50x | 1.5x | 4.500 |
| startup | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
| support | single | 3 | 1.00x | 1.00x | 1.0x | 3.000 |
