# Keywords for microsoft-extensions-http-resilience

Combined local and global scoring:
- Score = count × header_mult × type_mult × global_mult
- header_mult: 1.5x (H1), 1.25x (H2), 1.1x (H3+), 1.0x (none) [compounds only]
- type_mult: 1.5x (compound), 1.0x (single)
- global_mult: 2.0x (<10% of topics), 1.5x (10-25%), 1.0x (≥25%)

| Term | Type | Count | Header Mult | Type Mult | Global Mult | Score |
|------|------|-------|-------------|-----------|-------------|-------|
| resilience | single | 25 | 1.00x | 1.00x | 2.0x | 50.000 |
| http | single | 9 | 1.00x | 1.00x | 2.0x | 18.000 |
| communication | single | 7 | 1.00x | 1.00x | 2.0x | 14.000 |
| microsoft.extensions.http.resilience | compound | 3 | 1.50x | 1.50x | 2.0x | 13.500 |
| monitoring | single | 6 | 1.00x | 1.00x | 2.0x | 12.000 |
| strategies | single | 6 | 1.00x | 1.00x | 2.0x | 12.000 |
| standard | single | 7 | 1.00x | 1.00x | 1.5x | 10.500 |
| built | single | 5 | 1.00x | 1.00x | 2.0x | 10.000 |
| circuit | single | 5 | 1.00x | 1.00x | 2.0x | 10.000 |
| httpclient | single | 5 | 1.00x | 1.00x | 2.0x | 10.000 |
| polly | single | 5 | 1.00x | 1.00x | 2.0x | 10.000 |
| reliability | single | 5 | 1.00x | 1.00x | 2.0x | 10.000 |
| circuit breaker | compound | 3 | 1.10x | 1.50x | 2.0x | 9.900 |
| pre-configured | compound | 3 | 1.00x | 1.50x | 2.0x | 9.000 |
| configuration | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| distributed | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| fault | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| hedging | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| microservices | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| pipeline | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| tolerance | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| microsoft | single | 5 | 1.00x | 1.00x | 1.5x | 7.500 |
| through | single | 5 | 1.00x | 1.00x | 1.5x | 7.500 |
| custom resilience | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| resource management | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| patterns | single | 6 | 1.00x | 1.00x | 1.0x | 6.000 |
| comprehensive | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| essential | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| factory | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| failures | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| providing | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| reliable | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| retry | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| extensions | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
| require | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
