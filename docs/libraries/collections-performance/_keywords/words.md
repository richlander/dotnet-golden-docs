# Keywords for collections-performance

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
| stack allocation | compound | 7 | 1.25x | 1.50x | 2.0x | 26.250 |
| array interface devirtualization | compound | 6 | 1.10x | 1.50x | 2.0x | 19.800 |
| small arrays | compound | 5 | 1.25x | 1.50x | 2.0x | 18.750 |
| collections performance | compound | 4 | 1.50x | 1.50x | 2.0x | 18.000 |
| both | single | 7 | 1.00x | 1.00x | 2.0x | 14.000 |
| escape | single | 6 | 1.00x | 1.00x | 2.0x | 12.000 |
| optimizations | single | 6 | 1.00x | 1.00x | 2.0x | 12.000 |
| don't | single | 7 | 1.00x | 1.00x | 1.5x | 10.500 |
| through | single | 7 | 1.00x | 1.00x | 1.5x | 10.500 |
| benefit | single | 5 | 1.00x | 1.00x | 2.0x | 10.000 |
| enumeration | single | 5 | 1.00x | 1.00x | 2.0x | 10.000 |
| interfaces | single | 5 | 1.00x | 1.00x | 2.0x | 10.000 |
| insertion-order | compound | 3 | 1.00x | 1.50x | 2.0x | 9.000 |
| automatic | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| devirtualization | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| index | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| small | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| updates | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| iteration | single | 5 | 1.00x | 1.00x | 1.5x | 7.500 |
| automatic stack allocation | compound | 2 | 1.25x | 1.50x | 2.0x | 7.500 |
| index access | compound | 2 | 1.25x | 1.50x | 2.0x | 7.500 |
| escape analysis | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| fast lookups | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| struct fields | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| temporary collections | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| no | single | 4 | 1.00x | 1.00x | 1.5x | 6.000 |
| abstraction | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| accessed | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| applies | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| changes | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| dictionary | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| direct | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| efficiently | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| eliminates | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| enable | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| fixed-size | compound | 2 | 1.00x | 1.50x | 2.0x | 6.000 |
| heap | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| interface | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| jit | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| method | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| order | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| ordereddictionary | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| overloads | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| predictable | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| semantics | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| stack-allocates | compound | 2 | 1.00x | 1.50x | 2.0x | 6.000 |
| these | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| versions | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| zero-allocation | compound | 2 | 1.00x | 1.50x | 1.5x | 4.500 |
