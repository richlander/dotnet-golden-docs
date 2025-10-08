# Keywords for dotnet-10-library-improvements

Combined local and global scoring:
- Score = count × header_mult × type_mult × global_mult
- header_mult: 1.5x (H1), 1.25x (H2), 1.1x (H3+), 1.0x (none) [compounds only]
- type_mult: 1.5x (compound), 1.0x (single)
- global_mult: 2.0x (<10% of topics), 1.5x (10-25%), 1.0x (≥25%)

| Term | Type | Count | Header Mult | Type Mult | Global Mult | Score |
|------|------|-------|-------------|-----------|-------------|-------|
| security | single | 9 | 1.00x | 1.00x | 2.0x | 18.000 |
| json | single | 9 | 1.00x | 1.00x | 1.5x | 13.500 |
| net 10 | compound | 2 | 1.50x | 1.50x | 2.0x | 9.000 |
| span-based | compound | 3 | 1.00x | 1.50x | 2.0x | 9.000 |
| improvements | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| apis | single | 5 | 1.00x | 1.00x | 1.5x | 7.500 |
| high-performance text processing | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| post-quantum cryptography | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| algorithms | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| comparison | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| cryptography | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| duplicate | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| hex | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| numericordering | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| post-quantum | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| processing | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| quantum-resistant | compound | 2 | 1.00x | 1.50x | 2.0x | 6.000 |
| high-performance | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
| options | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
| serialization | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
| utf-8 | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
| patterns | single | 4 | 1.00x | 1.00x | 1.0x | 4.000 |
| support | single | 4 | 1.00x | 1.00x | 1.0x | 4.000 |
| cross-platform | compound | 2 | 1.00x | 1.50x | 1.0x | 3.000 |
