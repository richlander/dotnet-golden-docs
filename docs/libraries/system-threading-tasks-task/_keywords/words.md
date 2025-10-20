# Keywords for system-threading-tasks-task

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
| task | single | 33 | 1.00x | 1.00x | 2.0x | 66.000 |
| tasks | single | 28 | 1.00x | 1.00x | 2.0x | 56.000 |
| await | single | 7 | 1.00x | 1.00x | 2.0x | 14.000 |
| considerations | single | 8 | 1.00x | 1.00x | 1.5x | 12.000 |
| run | single | 6 | 1.00x | 1.00x | 2.0x | 12.000 |
| cpu-bound work | compound | 3 | 1.10x | 1.50x | 2.0x | 9.900 |
| exception handling | compound | 3 | 1.10x | 1.50x | 2.0x | 9.900 |
| don't | single | 6 | 1.00x | 1.00x | 1.5x | 9.000 |
| complete | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| consider | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| cpu-bound | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| vs | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| asp.net core | compound | 3 | 1.10x | 1.50x | 1.5x | 7.425 |
| entity framework core | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| json serialization | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| synchronous completion | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| task status | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| task.run | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| avoid | single | 4 | 1.00x | 1.00x | 1.5x | 6.000 |
| gt | single | 4 | 1.00x | 1.00x | 1.5x | 6.000 |
| lt | single | 4 | 1.00x | 1.00x | 1.5x | 6.000 |
| always | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| background | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| cache | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| completion | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| creation | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| exceptions | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| hot | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| manual | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| parallel | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| progress | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| returning | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| synchronization | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| timeout | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| asp | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
| control | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
| need | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
