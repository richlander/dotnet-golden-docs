# Keywords for dotnet

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
| net | single | 29 | 1.00x | 1.00x | 2.0x | 58.000 |
| libraries | single | 11 | 1.00x | 1.00x | 2.0x | 22.000 |
| while | single | 10 | 1.00x | 1.00x | 2.0x | 20.000 |
| memory management | compound | 6 | 1.10x | 1.50x | 2.0x | 19.800 |
| cross-platform | compound | 7 | 1.25x | 1.50x | 1.5x | 19.688 |
| like | single | 10 | 1.00x | 1.00x | 1.5x | 15.000 |
| open-source | compound | 5 | 1.00x | 1.50x | 2.0x | 15.000 |
| tools | single | 7 | 1.00x | 1.00x | 2.0x | 14.000 |
| runtime | single | 12 | 1.00x | 1.00x | 1.0x | 12.000 |
| code | single | 8 | 1.00x | 1.00x | 1.5x | 12.000 |
| languages | single | 6 | 1.00x | 1.00x | 2.0x | 12.000 |
| modern | single | 6 | 1.00x | 1.00x | 2.0x | 12.000 |
| community | single | 5 | 1.00x | 1.00x | 2.0x | 10.000 |
| enables | single | 5 | 1.00x | 1.00x | 2.0x | 10.000 |
| functionality | single | 5 | 1.00x | 1.00x | 2.0x | 10.000 |
| supported | single | 5 | 1.00x | 1.00x | 2.0x | 10.000 |
| via | single | 5 | 1.00x | 1.00x | 2.0x | 10.000 |
| windows | single | 5 | 1.00x | 1.00x | 2.0x | 10.000 |
| industry standards | compound | 3 | 1.10x | 1.50x | 2.0x | 9.900 |
| garbage collector | compound | 3 | 1.00x | 1.50x | 2.0x | 9.000 |
| high-level | compound | 3 | 1.00x | 1.50x | 2.0x | 9.000 |
| low-level | compound | 3 | 1.00x | 1.50x | 2.0x | 9.000 |
| across | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| components | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| developers | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| linux | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| many | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| pillars | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| programming | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| set | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| multiple | single | 5 | 1.00x | 1.00x | 1.5x | 7.500 |
| actively | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| android | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| architecture | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| been | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| building | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| chip | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| enable | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| extensive | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| gc | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| higher-level | compound | 2 | 1.00x | 1.50x | 2.0x | 6.000 |
| interop | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| ios | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| it's | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| low-cost | compound | 2 | 1.00x | 1.50x | 2.0x | 6.000 |
| macos | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| manual | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| object-oriented | compound | 2 | 1.00x | 1.50x | 2.0x | 6.000 |
| offers | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| platforms | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| productivity | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| run | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| self-tuning | compound | 2 | 1.00x | 1.50x | 2.0x | 6.000 |
| solutions | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| targeting | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| thousands | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| used | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| visual | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| asp | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
| nuget | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
