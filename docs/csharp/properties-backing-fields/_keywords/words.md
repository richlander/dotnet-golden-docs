# Keywords for properties-backing-fields

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
| accessor | single | 9 | 1.00x | 1.00x | 2.0x | 18.000 |
| backing | single | 8 | 1.00x | 1.00x | 2.0x | 16.000 |
| keyword | single | 8 | 1.00x | 1.00x | 2.0x | 16.000 |
| auto-implemented properties | compound | 4 | 1.25x | 1.50x | 2.0x | 15.000 |
| computed properties | compound | 4 | 1.25x | 1.50x | 2.0x | 15.000 |
| init-only properties | compound | 4 | 1.25x | 1.50x | 2.0x | 15.000 |
| read-only | compound | 5 | 1.25x | 1.50x | 1.5x | 14.062 |
| field | single | 7 | 1.00x | 1.00x | 2.0x | 14.000 |
| backing fields | compound | 3 | 1.50x | 1.50x | 2.0x | 13.500 |
| primary | single | 6 | 1.00x | 1.00x | 2.0x | 12.000 |
| records | single | 6 | 1.00x | 1.00x | 2.0x | 12.000 |
| field-backed properties | compound | 3 | 1.25x | 1.50x | 2.0x | 11.250 |
| required properties | compound | 3 | 1.25x | 1.50x | 2.0x | 11.250 |
| cannot | single | 5 | 1.00x | 1.00x | 2.0x | 10.000 |
| auto-property | compound | 3 | 1.00x | 1.50x | 2.0x | 9.000 |
| accessors | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| auto-implemented | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| constructors | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| restrictive | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| access modifiers | compound | 2 | 1.25x | 1.50x | 2.0x | 7.500 |
| init-only | compound | 2 | 1.25x | 1.50x | 2.0x | 7.500 |
| logic | single | 4 | 1.00x | 1.00x | 1.5x | 6.000 |
| need | single | 4 | 1.00x | 1.00x | 1.5x | 6.000 |
| compiler-generated | compound | 2 | 1.00x | 1.50x | 2.0x | 6.000 |
| compiler-synthesized | compound | 2 | 1.00x | 1.50x | 2.0x | 6.000 |
| construction | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| constructor | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| expression-bodied | compound | 2 | 1.00x | 1.50x | 2.0x | 6.000 |
| field-backed | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| initializers | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| set | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| setter | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| directly | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
