# Keywords for string-search-operations

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
| string search | compound | 4 | 1.50x | 1.50x | 2.0x | 18.000 |
| searchvalues | single | 7 | 1.00x | 1.00x | 2.0x | 14.000 |
| string search operations | compound | 3 | 1.50x | 1.50x | 2.0x | 13.500 |
| contains | single | 6 | 1.00x | 1.00x | 2.0x | 12.000 |
| indexof | single | 6 | 1.00x | 1.00x | 2.0x | 12.000 |
| searching | single | 6 | 1.00x | 1.00x | 2.0x | 12.000 |
| repeated | single | 5 | 1.00x | 1.00x | 2.0x | 10.000 |
| searches | single | 5 | 1.00x | 1.00x | 2.0x | 10.000 |
| allocation-free | compound | 3 | 1.00x | 1.50x | 2.0x | 9.000 |
| character | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| complex | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| string.contains | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| multi-value | compound | 2 | 1.00x | 1.50x | 2.0x | 6.000 |
| pattern-based | compound | 2 | 1.00x | 1.50x | 2.0x | 6.000 |
| regular | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| search | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| substring | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| vs | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
