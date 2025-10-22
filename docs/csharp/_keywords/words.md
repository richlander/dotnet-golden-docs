# Keywords for csharp

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
| language | single | 19 | 1.00x | 1.00x | 2.0x | 38.000 |
| features | single | 11 | 1.00x | 1.00x | 2.0x | 22.000 |
| memory management | compound | 6 | 1.10x | 1.50x | 2.0x | 19.800 |
| libraries | single | 9 | 1.00x | 1.00x | 2.0x | 18.000 |
| like | single | 11 | 1.00x | 1.00x | 1.5x | 16.500 |
| programming | single | 8 | 1.00x | 1.00x | 2.0x | 16.000 |
| object-oriented | compound | 5 | 1.00x | 1.50x | 2.0x | 15.000 |
| cross-platform | compound | 5 | 1.10x | 1.50x | 1.5x | 12.375 |
| applications | single | 6 | 1.00x | 1.00x | 2.0x | 12.000 |
| enables | single | 6 | 1.00x | 1.00x | 2.0x | 12.000 |
| low-level | compound | 4 | 1.00x | 1.50x | 2.0x | 12.000 |
| while | single | 6 | 1.00x | 1.00x | 2.0x | 12.000 |
| language features | compound | 3 | 1.25x | 1.50x | 2.0x | 11.250 |
| developers | single | 5 | 1.00x | 1.00x | 2.0x | 10.000 |
| using | single | 5 | 1.00x | 1.00x | 2.0x | 10.000 |
| asynchronous programming | compound | 3 | 1.10x | 1.50x | 2.0x | 9.900 |
| data | single | 6 | 1.00x | 1.00x | 1.5x | 9.000 |
| high-level | compound | 3 | 1.00x | 1.50x | 2.0x | 9.000 |
| memory-safety | compound | 3 | 1.00x | 1.50x | 2.0x | 9.000 |
| both | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| capabilities | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| compiler | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| concepts | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| define | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| enable | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| functional | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| introduce | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| languages | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| net | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| offers | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| control | single | 5 | 1.00x | 1.00x | 1.5x | 7.500 |
| cloud-native development | compound | 2 | 1.25x | 1.50x | 2.0x | 7.500 |
| mobile applications | compound | 2 | 1.25x | 1.50x | 2.0x | 7.500 |
| compile-time | compound | 3 | 1.00x | 1.50x | 1.5x | 6.750 |
| type system | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| version compatibility | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| abstraction | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| code | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| constructs | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| extensible | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| frameworks | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| language-integrated | compound | 2 | 1.00x | 1.50x | 2.0x | 6.000 |
| mainstream | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| many | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| pattern-based | compound | 2 | 1.00x | 1.50x | 2.0x | 6.000 |
| platform-specific | compound | 2 | 1.00x | 1.50x | 2.0x | 6.000 |
| provide | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| range | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| run | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| support | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| tools | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| understanding | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| web | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| windows | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| write | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| through | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
