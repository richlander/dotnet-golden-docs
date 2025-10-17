# Keywords for system-commandline

Combined local and global scoring:
- Score = count × header_mult × type_mult × global_mult
- header_mult: 1.5x (H1), 1.25x (H2), 1.1x (H3+), 1.0x (none) [compounds only]
- type_mult: 1.5x (compound), 1.0x (single)
- global_mult: 2.0x (<10% of topics), 1.5x (10-25%), 1.0x (≥25%)

| Term | Type | Count | Header Mult | Type Mult | Global Mult | Score |
|------|------|-------|-------------|-----------|-------------|-------|
| command-line | compound | 6 | 1.00x | 1.50x | 2.0x | 18.000 |
| system.commandline | compound | 4 | 1.50x | 1.50x | 2.0x | 18.000 |
| parsing | single | 7 | 1.00x | 1.00x | 1.5x | 10.500 |
| response files | compound | 3 | 1.10x | 1.50x | 2.0x | 9.900 |
| binding | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| commandline | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| help | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| hierarchies | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| option | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| use | single | 7 | 1.00x | 1.00x | 1.0x | 7.000 |
| model binding | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| arguments | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| commands | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| console | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| conventions | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| errors | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| expensive | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| subcommands | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| complex | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
| tools | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
