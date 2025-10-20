# Keywords for json-streaming-io

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
| json streaming | compound | 4 | 1.50x | 1.50x | 2.0x | 18.000 |
| streaming | single | 9 | 1.00x | 1.00x | 2.0x | 18.000 |
| large | single | 8 | 1.00x | 1.00x | 2.0x | 16.000 |
| streams | single | 8 | 1.00x | 1.00x | 2.0x | 16.000 |
| utf-8 | single | 7 | 1.00x | 1.00x | 1.5x | 10.500 |
| pipeline | single | 5 | 1.00x | 1.00x | 2.0x | 10.000 |
| streaming apis | compound | 3 | 1.10x | 1.50x | 2.0x | 9.900 |
| buffer | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| memory-efficient parsing | compound | 2 | 1.25x | 1.50x | 2.0x | 7.500 |
| stream-based serialization | compound | 2 | 1.25x | 1.50x | 2.0x | 7.500 |
| utf-8 direct processing | compound | 2 | 1.25x | 1.50x | 2.0x | 7.500 |
| high-throughput | compound | 2 | 1.00x | 1.50x | 2.0x | 6.000 |
| http | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| incrementally | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| memory-efficient | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| non-blocking | compound | 2 | 1.00x | 1.50x | 2.0x | 6.000 |
| pipelines | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| pipes | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| processing | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| real-time | compound | 2 | 1.00x | 1.50x | 2.0x | 6.000 |
| stream | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| asp | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
| directly | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
