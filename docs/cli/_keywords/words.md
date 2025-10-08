# Keywords for cli

Combined local and global scoring:
- Score = count × header_mult × type_mult × global_mult
- header_mult: 1.5x (H1), 1.25x (H2), 1.1x (H3+), 1.0x (none) [compounds only]
- type_mult: 1.5x (compound), 1.0x (single)
- global_mult: 2.0x (<10% of topics), 1.5x (10-25%), 1.0x (≥25%)

| Term | Type | Count | Header Mult | Type Mult | Global Mult | Score |
|------|------|-------|-------------|-----------|-------------|-------|
| cli | single | 23 | 1.00x | 1.00x | 2.0x | 46.000 |
| package | single | 11 | 1.00x | 1.00x | 2.0x | 22.000 |
| development | single | 10 | 1.00x | 1.00x | 2.0x | 20.000 |
| tools | single | 13 | 1.00x | 1.00x | 1.5x | 19.500 |
| global | single | 8 | 1.00x | 1.00x | 2.0x | 16.000 |
| builds | single | 7 | 1.00x | 1.00x | 2.0x | 14.000 |
| commands | single | 9 | 1.00x | 1.00x | 1.5x | 13.500 |
| across | single | 8 | 1.00x | 1.00x | 1.5x | 12.000 |
| projects | single | 6 | 1.00x | 1.00x | 2.0x | 12.000 |
| command-line | compound | 5 | 1.00x | 1.50x | 1.5x | 11.250 |
| consistent | single | 5 | 1.00x | 1.00x | 2.0x | 10.000 |
| sdk | single | 5 | 1.00x | 1.00x | 2.0x | 10.000 |
| development workflow | compound | 3 | 1.10x | 1.50x | 2.0x | 9.900 |
| integration | single | 6 | 1.00x | 1.00x | 1.5x | 9.000 |
| net cli | compound | 2 | 1.50x | 1.50x | 2.0x | 9.000 |
| runtime | single | 8 | 1.00x | 1.00x | 1.0x | 8.000 |
| cache | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| limitations | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| path | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| solution | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| team | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| tool | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| visual | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| build performance | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| command structure | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| development environments | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| package restore | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| patterns | single | 6 | 1.00x | 1.00x | 1.0x | 6.000 |
| multiple | single | 4 | 1.00x | 1.00x | 1.5x | 6.000 |
| system | single | 4 | 1.00x | 1.00x | 1.5x | 6.000 |
| windows | single | 4 | 1.00x | 1.00x | 1.5x | 6.000 |
| building | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| downloads | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| efficient | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| experience | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| ide | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| issues | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| large | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| operating | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| organization | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| permissions | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| pipeline | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| primary | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| project | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| require | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| restore | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| solutions | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| studio | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| systems | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| versions | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| provides | single | 5 | 1.00x | 1.00x | 1.0x | 5.000 |
| support | single | 5 | 1.00x | 1.00x | 1.0x | 5.000 |
| cross-platform | compound | 3 | 1.10x | 1.50x | 1.0x | 4.950 |
| application | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
| caching | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
| ci | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
| considerations | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
| like | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
| code | single | 4 | 1.00x | 1.00x | 1.0x | 4.000 |
| configuration | single | 3 | 1.00x | 1.00x | 1.0x | 3.000 |
