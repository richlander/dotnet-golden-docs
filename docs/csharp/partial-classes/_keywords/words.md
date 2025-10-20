# Keywords for partial-classes

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
| partial | single | 20 | 1.00x | 1.00x | 2.0x | 40.000 |
| declaration | single | 18 | 1.00x | 1.00x | 2.0x | 36.000 |
| declarations | single | 14 | 1.00x | 1.00x | 2.0x | 28.000 |
| implementing | single | 12 | 1.00x | 1.00x | 2.0x | 24.000 |
| partial classes | compound | 5 | 1.50x | 1.50x | 2.0x | 22.500 |
| keyword | single | 8 | 1.00x | 1.00x | 2.0x | 16.000 |
| parts | single | 8 | 1.00x | 1.00x | 2.0x | 16.000 |
| partial members | compound | 4 | 1.25x | 1.50x | 2.0x | 15.000 |
| declaring | single | 7 | 1.00x | 1.00x | 2.0x | 14.000 |
| generators | single | 6 | 1.00x | 1.00x | 2.0x | 12.000 |
| implementations | single | 6 | 1.00x | 1.00x | 2.0x | 12.000 |
| optional | single | 6 | 1.00x | 1.00x | 2.0x | 12.000 |
| separate | single | 6 | 1.00x | 1.00x | 2.0x | 12.000 |
| split | single | 6 | 1.00x | 1.00x | 2.0x | 12.000 |
| auto-property | compound | 3 | 1.00x | 1.50x | 2.0x | 9.000 |
| accessibility | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| cannot | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| class | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| implementation | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| interfaces | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| match | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| one | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| primary | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| signature | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| specify | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| attributes | single | 5 | 1.00x | 1.00x | 1.5x | 7.500 |
| documentation comments | compound | 2 | 1.25x | 1.50x | 2.0x | 7.500 |
| partial types | compound | 2 | 1.25x | 1.50x | 2.0x | 7.500 |
| partial constructors | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| partial events | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| partial indexers | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| partial methods | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| partial properties | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| code | single | 4 | 1.00x | 1.00x | 1.5x | 6.000 |
| no | single | 4 | 1.00x | 1.00x | 1.5x | 6.000 |
| accessors | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| across | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| base | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| both | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| calls | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| classes | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| comments | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| constructors | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| definition | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| developer-written | compound | 2 | 1.00x | 1.50x | 2.0x | 6.000 |
| different | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| include | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| method | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| part | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| platform-specific | compound | 2 | 1.00x | 1.50x | 2.0x | 6.000 |
| windows-specific | compound | 2 | 1.00x | 1.50x | 2.0x | 6.000 |
