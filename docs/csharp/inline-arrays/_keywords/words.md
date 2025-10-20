# Keywords for inline-arrays

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
| inline arrays | compound | 33 | 1.50x | 1.50x | 2.0x | 148.500 |
| buffers | single | 20 | 1.00x | 1.00x | 2.0x | 40.000 |
| inline array | compound | 8 | 1.50x | 1.50x | 2.0x | 36.000 |
| fixed-size | compound | 10 | 1.10x | 1.50x | 2.0x | 33.000 |
| buffer | single | 9 | 1.00x | 1.00x | 2.0x | 18.000 |
| unsafe | single | 7 | 1.00x | 1.00x | 2.0x | 14.000 |
| element access | compound | 4 | 1.10x | 1.50x | 2.0x | 13.200 |
| considerations | single | 8 | 1.00x | 1.00x | 1.5x | 12.000 |
| heap | single | 6 | 1.00x | 1.00x | 2.0x | 12.000 |
| bounds | single | 5 | 1.00x | 1.00x | 2.0x | 10.000 |
| create | single | 5 | 1.00x | 1.00x | 2.0x | 10.000 |
| interop | single | 5 | 1.00x | 1.00x | 2.0x | 10.000 |
| lookup tables | compound | 3 | 1.10x | 1.50x | 2.0x | 9.900 |
| stack-allocated | compound | 3 | 1.10x | 1.50x | 2.0x | 9.900 |
| unsafe code | compound | 3 | 1.10x | 1.50x | 2.0x | 9.900 |
| avoid | single | 6 | 1.00x | 1.00x | 1.5x | 9.000 |
| compile-time | compound | 4 | 1.00x | 1.50x | 1.5x | 9.000 |
| allocations | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| efficient | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| provide | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| no | single | 5 | 1.00x | 1.00x | 1.5x | 7.500 |
| ring buffers | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| span conversion | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| gt | single | 4 | 1.00x | 1.00x | 1.5x | 6.000 |
| iteration | single | 4 | 1.00x | 1.00x | 1.5x | 6.000 |
| known | single | 4 | 1.00x | 1.00x | 1.5x | 6.000 |
| lt | single | 4 | 1.00x | 1.00x | 1.5x | 6.000 |
| need | single | 4 | 1.00x | 1.00x | 1.5x | 6.000 |
| without | single | 4 | 1.00x | 1.00x | 1.5x | 6.000 |
| cannot | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| checking | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| constraints | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| convert | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| dynamic | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| embed | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| full | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| gc | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| layout | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| length | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| limitations | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| replace | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| simd | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| sizes | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| slicing | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| spans | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| structures | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| want | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| zero-overhead | compound | 2 | 1.00x | 1.50x | 2.0x | 6.000 |
| directly | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
| don't | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
