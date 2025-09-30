# Unified Local Analysis

Combined 14 compound terms and 112 single words
Total unique terms: 126
Terms with score ≥ 3.0: 23
Total term occurrences: 196
Header-based scoring: enabled

Scoring formula: LocalScore = count × header_multiplier × type_multiplier
- header_multiplier (compounds only): 1.5x (H1), 1.25x (H2), 1.1x (H3+), 1.0x (none)
  - Single words do NOT get header multipliers (prevents arbitrary matches)
  - Exception: Acronyms (all-caps, 2+ letters) get 1.25x boost regardless
- type_multiplier: 1.5x (compound), 1.0x (single)
- Minimum score threshold: 3.0 (only terms meeting this threshold are shown)

| Term | Type | Count | Header Mult | Type Mult | Local Score |
|------|------|-------|-------------|-----------|-------------|
| libraries | single | 10 | 1.00x | 1.00x | 10.0 |
| asp.net core | compound | 4 | 1.10x | 1.50x | 6.6 |
| data access | compound | 3 | 1.25x | 1.50x | 5.6 |
| library ecosystem | compound | 3 | 1.25x | 1.50x | 5.6 |
| memory management | compound | 3 | 1.25x | 1.50x | 5.6 |
| frameworks | single | 5 | 1.00x | 1.00x | 5.0 |
| dependency injection | compound | 3 | 1.10x | 1.50x | 5.0 |
| high-performance | compound | 3 | 1.10x | 1.50x | 5.0 |
| third-party | compound | 3 | 1.10x | 1.50x | 5.0 |
| application | single | 4 | 1.00x | 1.00x | 4.0 |
| asp | single | 4 | 1.00x | 1.00x | 4.0 |
| system | single | 4 | 1.00x | 1.00x | 4.0 |
| distributed system | compound | 2 | 1.25x | 1.50x | 3.8 |
| system libraries | compound | 2 | 1.25x | 1.50x | 3.8 |
| azure sdk | compound | 2 | 1.10x | 1.50x | 3.3 |
| entity framework core | compound | 2 | 1.10x | 1.50x | 3.3 |
| high-performance collections | compound | 2 | 1.10x | 1.50x | 3.3 |
| across | single | 3 | 1.00x | 1.00x | 3.0 |
| async | single | 3 | 1.00x | 1.00x | 3.0 |
| base class library | compound | 2 | 1.00x | 1.50x | 3.0 |
| bcl | compound | 2 | 1.00x | 1.50x | 3.0 |
| cloud | single | 3 | 1.00x | 1.00x | 3.0 |
| nuget | single | 3 | 1.00x | 1.00x | 3.0 |
