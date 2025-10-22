# Keywords for system-collections-generic-ienumerable

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
| deferred execution | compound | 8 | 1.10x | 1.50x | 2.0x | 26.400 |
| ienumerable | single | 13 | 1.00x | 1.00x | 2.0x | 26.000 |
| sequences | single | 13 | 1.00x | 1.00x | 2.0x | 26.000 |
| need | single | 12 | 1.00x | 1.00x | 1.5x | 18.000 |
| iteration | single | 11 | 1.00x | 1.00x | 1.5x | 16.500 |
| multiple | single | 11 | 1.00x | 1.00x | 1.5x | 16.500 |
| enumeration | single | 7 | 1.00x | 1.00x | 2.0x | 14.000 |
| linq | single | 7 | 1.00x | 1.00x | 2.0x | 14.000 |
| gt | single | 9 | 1.00x | 1.00x | 1.5x | 13.500 |
| lt | single | 9 | 1.00x | 1.00x | 1.5x | 13.500 |
| side effects | compound | 4 | 1.10x | 1.50x | 2.0x | 13.200 |
| consider | single | 6 | 1.00x | 1.00x | 2.0x | 12.000 |
| iterator | single | 6 | 1.00x | 1.00x | 2.0x | 12.000 |
| modification | single | 6 | 1.00x | 1.00x | 2.0x | 12.000 |
| considerations | single | 7 | 1.00x | 1.00x | 1.5x | 10.500 |
| large | single | 5 | 1.00x | 1.00x | 2.0x | 10.000 |
| materialize | single | 5 | 1.00x | 1.00x | 2.0x | 10.000 |
| queries | single | 5 | 1.00x | 1.00x | 2.0x | 10.000 |
| sequence | single | 5 | 1.00x | 1.00x | 2.0x | 10.000 |
| yield return | compound | 3 | 1.10x | 1.50x | 2.0x | 9.900 |
| concrete | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| count | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| each | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| entire | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| indexing | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| return | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| times | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| want | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| into | single | 5 | 1.00x | 1.00x | 1.5x | 7.500 |
| entity framework | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| infinite sequences | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| large sequences | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| linq integration | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| linq query operations | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| method syntax | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| non-generic | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| query syntax | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| random access | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| no | single | 4 | 1.00x | 1.00x | 1.5x | 6.000 |
| aggregation | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| capabilities | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| chain | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| creates | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| doesn't | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| elements | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| etc | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| expensive | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| filtering | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| flexibility | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| foreach | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| iasyncenumerable | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| implement | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| iterate | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| materialization | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| query | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| results | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| supports | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| thread-safety | compound | 2 | 1.00x | 1.50x | 2.0x | 6.000 |
| transformation | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| avoid | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
| data | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
| read-only | compound | 2 | 1.00x | 1.50x | 1.5x | 4.500 |
