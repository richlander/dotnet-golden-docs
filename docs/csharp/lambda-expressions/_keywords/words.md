# Keywords for lambda-expressions

Combined local and global scoring:
- Score = count × header_mult × type_mult × global_mult
- header_mult: 1.5x (H1), 1.25x (H2), 1.1x (H3+), 1.0x (none) [compounds only]
- type_mult: 1.5x (compound), 1.0x (single)
- global_mult: 2.0x (<10% of topics), 1.5x (10-25%), 1.0x (≥25%)

| Term | Type | Count | Header Mult | Type Mult | Global Mult | Score |
|------|------|-------|-------------|-----------|-------------|-------|
| lambda | single | 13 | 1.00x | 1.00x | 2.0x | 26.000 |
| delegate | single | 12 | 1.00x | 1.00x | 2.0x | 24.000 |
| lambdas | single | 11 | 1.00x | 1.00x | 2.0x | 22.000 |
| expression lambdas | compound | 5 | 1.25x | 1.50x | 2.0x | 18.750 |
| expression trees | compound | 5 | 1.25x | 1.50x | 2.0x | 18.750 |
| default parameters | compound | 4 | 1.25x | 1.50x | 2.0x | 15.000 |
| natural type | compound | 4 | 1.25x | 1.50x | 2.0x | 15.000 |
| statement lambdas | compound | 4 | 1.25x | 1.50x | 2.0x | 15.000 |
| parameter | single | 7 | 1.00x | 1.00x | 2.0x | 14.000 |
| parameters | single | 7 | 1.00x | 1.00x | 2.0x | 14.000 |
| lambda expressions | compound | 3 | 1.50x | 1.50x | 2.0x | 13.500 |
| explicit | single | 6 | 1.00x | 1.00x | 2.0x | 12.000 |
| variables | single | 6 | 1.00x | 1.00x | 2.0x | 12.000 |
| natural type inference | compound | 3 | 1.25x | 1.50x | 2.0x | 11.250 |
| parameter modifiers | compound | 3 | 1.25x | 1.50x | 2.0x | 11.250 |
| static lambdas | compound | 3 | 1.25x | 1.50x | 2.0x | 11.250 |
| async lambdas | compound | 2 | 1.25x | 1.50x | 2.0x | 7.500 |
| body | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| capture | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| captures | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| infers | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| instance | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| performance-critical | compound | 2 | 1.00x | 1.50x | 2.0x | 6.000 |
| static | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| use | single | 5 | 1.00x | 1.00x | 1.0x | 5.000 |
