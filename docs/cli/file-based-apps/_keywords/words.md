# Keywords for file-based-apps

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
| file-based apps | compound | 14 | 1.50x | 1.50x | 2.0x | 63.000 |
| docs | single | 18 | 1.00x | 1.00x | 2.0x | 36.000 |
| file-based | single | 16 | 1.00x | 1.00x | 2.0x | 32.000 |
| project | single | 14 | 1.00x | 1.00x | 2.0x | 28.000 |
| dotnet | single | 12 | 1.00x | 1.00x | 2.0x | 24.000 |
| scripts | single | 10 | 1.00x | 1.00x | 2.0x | 20.000 |
| com | single | 9 | 1.00x | 1.00x | 2.0x | 18.000 |
| description | single | 9 | 1.00x | 1.00x | 2.0x | 18.000 |
| directives | single | 9 | 1.00x | 1.00x | 2.0x | 18.000 |
| file-based-programs | compound | 6 | 1.00x | 1.50x | 2.0x | 18.000 |
| file-level | compound | 6 | 1.00x | 1.50x | 2.0x | 18.000 |
| githubusercontent | single | 9 | 1.00x | 1.00x | 2.0x | 18.000 |
| https | single | 9 | 1.00x | 1.00x | 2.0x | 18.000 |
| main | single | 9 | 1.00x | 1.00x | 2.0x | 18.000 |
| md | single | 9 | 1.00x | 1.00x | 2.0x | 18.000 |
| raw | single | 9 | 1.00x | 1.00x | 2.0x | 18.000 |
| title | single | 9 | 1.00x | 1.00x | 2.0x | 18.000 |
| full | single | 8 | 1.00x | 1.00x | 2.0x | 16.000 |
| language | single | 8 | 1.00x | 1.00x | 2.0x | 16.000 |
| fundamentals | single | 7 | 1.00x | 1.00x | 2.0x | 14.000 |
| package | single | 7 | 1.00x | 1.00x | 2.0x | 14.000 |
| projects | single | 7 | 1.00x | 1.00x | 2.0x | 14.000 |
| publishing | single | 7 | 1.00x | 1.00x | 2.0x | 14.000 |
| cross-platform | compound | 5 | 1.10x | 1.50x | 1.5x | 12.375 |
| csharp | single | 6 | 1.00x | 1.00x | 2.0x | 12.000 |
| debugging | single | 6 | 1.00x | 1.00x | 2.0x | 12.000 |
| packages | single | 6 | 1.00x | 1.00x | 2.0x | 12.000 |
| scripting | single | 6 | 1.00x | 1.00x | 2.0x | 12.000 |
| single-file | compound | 4 | 1.00x | 1.50x | 2.0x | 12.000 |
| tutorials | single | 6 | 1.00x | 1.00x | 2.0x | 12.000 |
| create | single | 5 | 1.00x | 1.00x | 2.0x | 10.000 |
| setup | single | 5 | 1.00x | 1.00x | 2.0x | 10.000 |
| traditional project | compound | 3 | 1.10x | 1.50x | 2.0x | 9.900 |
| command-line | compound | 3 | 1.00x | 1.50x | 2.0x | 9.000 |
| whats-new | compound | 3 | 1.00x | 1.50x | 2.0x | 9.000 |
| basic | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| complexity | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| migration | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| run | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| structures | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| team | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| utilities | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| while | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| works | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| nuget | single | 5 | 1.00x | 1.00x | 1.5x | 7.500 |
| ascii art | compound | 2 | 1.25x | 1.50x | 2.0x | 7.500 |
| exit codes | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| project structure | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| single file constraint | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| traditional project structure | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| without | single | 4 | 1.00x | 1.00x | 1.5x | 6.000 |
| arguments | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| artifacts | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| both | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| capabilities | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| complex | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| directive | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| dotnet-10 | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| experimentation | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| external | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| input | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| intellisense | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| learning | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| local | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| path | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| proper | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| rather | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| self-contained | compound | 2 | 1.00x | 1.50x | 2.0x | 6.000 |
| shebang | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| shell | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| standalone | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| standard | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| transform | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| unix | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| error handling | compound | 2 | 1.10x | 1.50x | 1.5x | 4.950 |
| considerations | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
