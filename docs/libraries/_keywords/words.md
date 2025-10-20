# Keywords for libraries

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
| libraries | single | 12 | 1.00x | 1.00x | 2.0x | 24.000 |
| data access | compound | 3 | 1.25x | 1.50x | 2.0x | 11.250 |
| library ecosystem | compound | 3 | 1.25x | 1.50x | 2.0x | 11.250 |
| frameworks | single | 5 | 1.00x | 1.00x | 2.0x | 10.000 |
| dependency injection | compound | 3 | 1.10x | 1.50x | 2.0x | 9.900 |
| application | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| memory management | compound | 2 | 1.25x | 1.50x | 2.0x | 7.500 |
| asp.net core | compound | 3 | 1.10x | 1.50x | 1.5x | 7.425 |
| azure sdk | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| entity framework core | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| high-performance collections | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| third-party | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| asp | single | 4 | 1.00x | 1.00x | 1.5x | 6.000 |
| across | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| base class library | compound | 2 | 1.00x | 1.50x | 2.0x | 6.000 |
| distributed | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| system.text.json | compound | 2 | 1.10x | 1.50x | 1.5x | 4.950 |
| nuget | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
