# Keywords for async-await

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
| async | single | 26 | 1.00x | 1.00x | 2.0x | 52.000 |
| async operations | compound | 8 | 1.10x | 1.50x | 2.0x | 26.400 |
| await | single | 11 | 1.00x | 1.00x | 2.0x | 22.000 |
| operations | single | 11 | 1.00x | 1.00x | 2.0x | 22.000 |
| task | single | 7 | 1.00x | 1.00x | 2.0x | 14.000 |
| async methods | compound | 4 | 1.10x | 1.50x | 2.0x | 13.200 |
| considerations | single | 8 | 1.00x | 1.00x | 1.5x | 12.000 |
| async code | compound | 3 | 1.10x | 1.50x | 2.0x | 9.900 |
| avoid | single | 6 | 1.00x | 1.00x | 1.5x | 9.000 |
| threads | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| error handling | compound | 3 | 1.10x | 1.50x | 1.5x | 7.425 |
| system.text.json | compound | 3 | 1.10x | 1.50x | 1.5x | 7.425 |
| async initialization | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| async void | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| cancellation support | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| cpu-bound work | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| entity framework core | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| event handlers | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| high-performance scenarios | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| json serialization | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| lock statements | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| state machine | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| don't | single | 4 | 1.00x | 1.00x | 1.5x | 6.000 |
| gt | single | 4 | 1.00x | 1.00x | 1.5x | 6.000 |
| lt | single | 4 | 1.00x | 1.00x | 1.5x | 6.000 |
| asynchronous | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| can't | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| code | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| concurrent | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| cpu-bound | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| database | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| doesn't | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| long-running | compound | 2 | 1.00x | 1.50x | 2.0x | 6.000 |
| non-blocking | compound | 2 | 1.00x | 1.50x | 2.0x | 6.000 |
| o-bound | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| parallel | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| queries | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| requests | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| scalability | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| synchronization | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| synchronous | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| tasks | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| throughout | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| timeouts | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| write | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| asp.net core | compound | 2 | 1.10x | 1.50x | 1.5x | 4.950 |
| asp | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
