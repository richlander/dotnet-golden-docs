# Keywords for system-collections-generic-iasyncenumerable

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
| async linq | compound | 7 | 1.10x | 1.50x | 2.0x | 23.100 |
| data | single | 11 | 1.00x | 1.00x | 1.5x | 16.500 |
| iteration | single | 11 | 1.00x | 1.00x | 1.5x | 16.500 |
| iasyncenumerable | single | 7 | 1.00x | 1.00x | 2.0x | 14.000 |
| deferred execution | compound | 4 | 1.10x | 1.50x | 2.0x | 13.200 |
| async | single | 6 | 1.00x | 1.00x | 2.0x | 12.000 |
| consider | single | 6 | 1.00x | 1.00x | 2.0x | 12.000 |
| each | single | 6 | 1.00x | 1.00x | 2.0x | 12.000 |
| enumeration | single | 6 | 1.00x | 1.00x | 2.0x | 12.000 |
| considerations | single | 7 | 1.00x | 1.00x | 1.5x | 10.500 |
| loading | single | 5 | 1.00x | 1.00x | 2.0x | 10.000 |
| gt | single | 6 | 1.00x | 1.00x | 1.5x | 9.000 |
| lt | single | 6 | 1.00x | 1.00x | 1.5x | 9.000 |
| producer-consumer | compound | 3 | 1.00x | 1.50x | 2.0x | 9.000 |
| database | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| linq | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| materialize | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| operators | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| paginated | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| sources | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| streams | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| during | single | 5 | 1.00x | 1.00x | 1.5x | 7.500 |
| into | single | 5 | 1.00x | 1.00x | 1.5x | 7.500 |
| like | single | 5 | 1.00x | 1.00x | 1.5x | 7.500 |
| system.text.json | compound | 3 | 1.10x | 1.50x | 1.5x | 7.425 |
| 8.0 | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| async data | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| cancellation support | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| entity framework core | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| handle exceptions | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| net core 3.0 | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| datasets | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| ienumerable | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| long-running | compound | 2 | 1.00x | 1.50x | 2.0x | 6.000 |
| pipelines | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| queries | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| asp.net core | compound | 2 | 1.10x | 1.50x | 1.5x | 4.950 |
| error handling | compound | 2 | 1.10x | 1.50x | 1.5x | 4.950 |
| asp | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
| avoid | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
| control | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
| don't | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
| multiple | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
| need | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
| no | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
| nuget | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
| without | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
