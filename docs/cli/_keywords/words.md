# Keywords for cli

Combined local and global scoring:
- Score = count × header_mult × type_mult × global_mult
- header_mult: 1.5x (H1), 1.25x (H2), 1.1x (H3+), 1.0x (none) [compounds only]
- type_mult: 1.5x (compound), 1.0x (single)
- global_mult: 2.0x (<10% of topics), 1.5x (10-25%), 1.0x (≥25%)

Filtering: Includes terms with global_mult ≥ 1.5x OR (count ≥ 10 AND appears in < 50% of topics)
- Distinctive terms (1.5x+) always included
- Common terms (1.0x) included only if substantive (≥10 occurrences) and not overly common (<50% of topics)

| Term | Type | Count | Header Mult | Type Mult | Global Mult | Score |
|------|------|-------|-------------|-----------|-------------|-------|
| cli | single | 23 | 1.00x | 1.00x | 2.0x | 46.000 |
| tools | single | 13 | 1.00x | 1.00x | 2.0x | 26.000 |
| package | single | 11 | 1.00x | 1.00x | 2.0x | 22.000 |
| development | single | 10 | 1.00x | 1.00x | 2.0x | 20.000 |
| commands | single | 9 | 1.00x | 1.00x | 2.0x | 18.000 |
| across | single | 8 | 1.00x | 1.00x | 2.0x | 16.000 |
| global | single | 8 | 1.00x | 1.00x | 2.0x | 16.000 |
| command-line | compound | 5 | 1.00x | 1.50x | 2.0x | 15.000 |
| builds | single | 7 | 1.00x | 1.00x | 2.0x | 14.000 |
| projects | single | 6 | 1.00x | 1.00x | 2.0x | 12.000 |
| consistent | single | 5 | 1.00x | 1.00x | 2.0x | 10.000 |
| sdk | single | 5 | 1.00x | 1.00x | 2.0x | 10.000 |
| development workflow | compound | 3 | 1.10x | 1.50x | 2.0x | 9.900 |
| net cli | compound | 2 | 1.50x | 1.50x | 2.0x | 9.000 |
| cache | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| limitations | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| path | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| solution | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| team | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| tool | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| visual | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| cross-platform | compound | 3 | 1.10x | 1.50x | 1.5x | 7.425 |
| build performance | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| command structure | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| development environments | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| package restore | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| application | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| caching | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| ci | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| downloads | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| experience | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| ide | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
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
| considerations | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
| like | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
