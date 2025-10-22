# Keywords for microsoft-extensions-ai

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
| ai | single | 32 | 1.00x | 1.00x | 2.0x | 64.000 |
| microsoft.extensions.ai | compound | 5 | 1.50x | 1.50x | 2.0x | 22.500 |
| services | single | 10 | 1.00x | 1.00x | 2.0x | 20.000 |
| middleware | single | 9 | 1.00x | 1.00x | 2.0x | 18.000 |
| dependency injection | compound | 5 | 1.10x | 1.50x | 2.0x | 16.500 |
| middleware composition | compound | 5 | 1.10x | 1.50x | 2.0x | 16.500 |
| function calling | compound | 4 | 1.25x | 1.50x | 2.0x | 15.000 |
| caching | single | 6 | 1.00x | 1.00x | 2.0x | 12.000 |
| interfaces | single | 6 | 1.00x | 1.00x | 2.0x | 12.000 |
| service | single | 6 | 1.00x | 1.00x | 2.0x | 12.000 |
| microsoft | single | 5 | 1.00x | 1.00x | 2.0x | 10.000 |
| familiar | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| functionality | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| observability | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| provider | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| providers | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| like | single | 5 | 1.00x | 1.00x | 1.5x | 7.500 |
| embedding generation | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| memory management | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| tool invocation | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| allowing | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| architecture | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| capabilities | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| changes | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| chat | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| function | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| implement | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| opentelemetry | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| standard | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| strongly-typed | compound | 2 | 1.00x | 1.50x | 2.0x | 6.000 |
| telemetry | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| vs | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| error handling | compound | 2 | 1.10x | 1.50x | 1.5x | 4.950 |
