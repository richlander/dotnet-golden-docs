# Keywords for system-text-json-utf8jsonwriter

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
| writing | single | 16 | 1.00x | 1.00x | 2.0x | 32.000 |
| utf8jsonwriter | single | 12 | 1.00x | 1.00x | 2.0x | 24.000 |
| system.text.json.utf8jsonwriter | compound | 5 | 1.50x | 1.50x | 2.0x | 22.500 |
| output | single | 9 | 1.00x | 1.00x | 2.0x | 18.000 |
| write | single | 9 | 1.00x | 1.00x | 2.0x | 18.000 |
| writer | single | 8 | 1.00x | 1.00x | 2.0x | 16.000 |
| control | single | 8 | 1.00x | 1.00x | 1.5x | 12.000 |
| stream | single | 5 | 1.00x | 1.00x | 2.0x | 10.000 |
| performance-critical | compound | 3 | 1.00x | 1.50x | 2.0x | 9.000 |
| formatting | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| generate | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| streams | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| text | single | 5 | 1.00x | 1.00x | 1.5x | 7.500 |
| utf-8 | single | 5 | 1.00x | 1.00x | 1.5x | 7.500 |
| values | single | 5 | 1.00x | 1.00x | 1.5x | 7.500 |
| custom serialization | compound | 2 | 1.25x | 1.50x | 2.0x | 7.500 |
| pooled buffers | compound | 2 | 1.25x | 1.50x | 2.0x | 7.500 |
| simple objects | compound | 2 | 1.25x | 1.50x | 2.0x | 7.500 |
| writing arrays | compound | 2 | 1.25x | 1.50x | 2.0x | 7.500 |
| zero-allocation | compound | 3 | 1.00x | 1.50x | 1.5x | 6.750 |
| directly | single | 4 | 1.00x | 1.00x | 1.5x | 6.000 |
| json | single | 4 | 1.00x | 1.00x | 1.5x | 6.000 |
| logic | single | 4 | 1.00x | 1.00x | 1.5x | 6.000 |
| complex | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| encoding | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| maximum | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| real-time | compound | 2 | 1.00x | 1.50x | 2.0x | 6.000 |
| responses | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| type-specific | compound | 2 | 1.00x | 1.50x | 2.0x | 6.000 |
| valid | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| validates | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
