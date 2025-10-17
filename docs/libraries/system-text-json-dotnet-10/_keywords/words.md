# Keywords for system-text-json-dotnet-10

Combined local and global scoring:
- Score = count × header_mult × type_mult × global_mult
- header_mult: 1.5x (H1), 1.25x (H2), 1.1x (H3+), 1.0x (none) [compounds only]
- type_mult: 1.5x (compound), 1.0x (single)
- global_mult: 2.0x (<10% of topics), 1.5x (10-25%), 1.0x (≥25%)

| Term | Type | Count | Header Mult | Type Mult | Global Mult | Score |
|------|------|-------|-------------|-----------|-------------|-------|
| net 10 | compound | 7 | 1.50x | 1.50x | 2.0x | 31.500 |
| source generation | compound | 9 | 1.25x | 1.50x | 1.5x | 25.312 |
| duplicate detection | compound | 4 | 1.10x | 1.50x | 2.0x | 13.200 |
| strict options | compound | 4 | 1.10x | 1.50x | 2.0x | 13.200 |
| zero-copy | compound | 3 | 1.00x | 1.50x | 2.0x | 9.000 |
| options | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| strict | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| duplicate property detection | compound | 2 | 1.25x | 1.50x | 2.0x | 7.500 |
| system.text.json | compound | 2 | 1.50x | 1.50x | 1.5x | 6.750 |
| high-throughput | compound | 2 | 1.00x | 1.50x | 2.0x | 6.000 |
| pipereader | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| preset | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| scenarios | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| unmapped | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| high-performance | compound | 3 | 1.00x | 1.50x | 1.0x | 4.500 |
| security | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
| streams | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
| provides | single | 4 | 1.00x | 1.00x | 1.0x | 4.000 |
| use | single | 3 | 1.00x | 1.00x | 1.0x | 3.000 |
