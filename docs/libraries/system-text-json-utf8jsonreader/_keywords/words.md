# Keywords for system-text-json-utf8jsonreader

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
| parsing | single | 17 | 1.00x | 1.00x | 2.0x | 34.000 |
| utf8jsonreader | single | 12 | 1.00x | 1.00x | 2.0x | 24.000 |
| system.text.json.utf8jsonreader | compound | 5 | 1.50x | 1.50x | 2.0x | 22.500 |
| reading | single | 7 | 1.00x | 1.00x | 2.0x | 14.000 |
| utf-8 | single | 9 | 1.00x | 1.00x | 1.5x | 13.500 |
| values | single | 9 | 1.00x | 1.00x | 1.5x | 13.500 |
| forward-only | compound | 4 | 1.10x | 1.50x | 2.0x | 13.200 |
| process | single | 6 | 1.00x | 1.00x | 2.0x | 12.000 |
| reader | single | 6 | 1.00x | 1.00x | 2.0x | 12.000 |
| token | single | 5 | 1.00x | 1.00x | 2.0x | 10.000 |
| during | single | 6 | 1.00x | 1.00x | 1.5x | 9.000 |
| multi-segment | compound | 3 | 1.00x | 1.50x | 2.0x | 9.000 |
| performance-critical | compound | 3 | 1.00x | 1.50x | 2.0x | 9.000 |
| constant | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| network | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| tokens | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| text | single | 5 | 1.00x | 1.00x | 1.5x | 7.500 |
| zero-allocation | compound | 3 | 1.00x | 1.50x | 1.5x | 6.750 |
| ref struct | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| dom | single | 4 | 1.00x | 1.00x | 1.5x | 6.000 |
| without | single | 4 | 1.00x | 1.00x | 1.5x | 6.000 |
| arrives | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| cannot | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| higher-level | compound | 2 | 1.00x | 1.50x | 2.0x | 6.000 |
| instead | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| needed | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| parse | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| selective | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| skip | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| using | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| data | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
| logic | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
| through | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
