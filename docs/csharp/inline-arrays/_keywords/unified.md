# Unified Local Analysis

Combined 12 compound terms and 205 single words
Total unique terms: 212
Terms with score ≥ 3.0: 54
Total term occurrences: 459
Header-based scoring: enabled

Scoring formula: LocalScore = count × header_multiplier × type_multiplier
- header_multiplier (compounds only): 1.5x (H1), 1.25x (H2), 1.1x (H3+), 1.0x (none)
  - Single words do NOT get header multipliers (prevents arbitrary substring matches)
- type_multiplier: 1.5x (compound), 1.0x (single)
- Minimum score threshold: 3.0 (only terms meeting this threshold are shown)

| Term | Type | Count | Header Mult | Type Mult | Local Score |
|------|------|-------|-------------|-----------|-------------|
| inline arrays | compound | 33 | 1.50x | 1.50x | 74.2 |
| buffers | single | 20 | 1.00x | 1.00x | 20.0 |
| use | single | 20 | 1.00x | 1.00x | 20.0 |
| inline array | compound | 8 | 1.50x | 1.50x | 18.0 |
| fixed-size | compound | 10 | 1.10x | 1.50x | 16.5 |
| buffer | single | 9 | 1.00x | 1.00x | 9.0 |
| considerations | single | 8 | 1.00x | 1.00x | 8.0 |
| unsafe | single | 7 | 1.00x | 1.00x | 7.0 |
| element access | compound | 4 | 1.10x | 1.50x | 6.6 |
| avoid | single | 6 | 1.00x | 1.00x | 6.0 |
| compile-time | compound | 4 | 1.00x | 1.50x | 6.0 |
| heap | single | 6 | 1.00x | 1.00x | 6.0 |
| bounds | single | 5 | 1.00x | 1.00x | 5.0 |
| create | single | 5 | 1.00x | 1.00x | 5.0 |
| interop | single | 5 | 1.00x | 1.00x | 5.0 |
| no | single | 5 | 1.00x | 1.00x | 5.0 |
| runtime | single | 5 | 1.00x | 1.00x | 5.0 |
| lookup tables | compound | 3 | 1.10x | 1.50x | 5.0 |
| stack-allocated | compound | 3 | 1.10x | 1.50x | 5.0 |
| unsafe code | compound | 3 | 1.10x | 1.50x | 5.0 |
| allocations | single | 4 | 1.00x | 1.00x | 4.0 |
| efficient | single | 4 | 1.00x | 1.00x | 4.0 |
| gt | single | 4 | 1.00x | 1.00x | 4.0 |
| iteration | single | 4 | 1.00x | 1.00x | 4.0 |
| known | single | 4 | 1.00x | 1.00x | 4.0 |
| lt | single | 4 | 1.00x | 1.00x | 4.0 |
| need | single | 4 | 1.00x | 1.00x | 4.0 |
| provide | single | 4 | 1.00x | 1.00x | 4.0 |
| without | single | 4 | 1.00x | 1.00x | 4.0 |
| ring buffers | compound | 2 | 1.10x | 1.50x | 3.3 |
| span conversion | compound | 2 | 1.10x | 1.50x | 3.3 |
| cannot | single | 3 | 1.00x | 1.00x | 3.0 |
| checking | single | 3 | 1.00x | 1.00x | 3.0 |
| constraints | single | 3 | 1.00x | 1.00x | 3.0 |
| convert | single | 3 | 1.00x | 1.00x | 3.0 |
| directly | single | 3 | 1.00x | 1.00x | 3.0 |
| don't | single | 3 | 1.00x | 1.00x | 3.0 |
| dynamic | single | 3 | 1.00x | 1.00x | 3.0 |
| embed | single | 3 | 1.00x | 1.00x | 3.0 |
| full | single | 3 | 1.00x | 1.00x | 3.0 |
| gc | single | 3 | 1.00x | 1.00x | 3.0 |
| high-performance | compound | 2 | 1.00x | 1.50x | 3.0 |
| layout | single | 3 | 1.00x | 1.00x | 3.0 |
| length | single | 3 | 1.00x | 1.00x | 3.0 |
| limitations | single | 3 | 1.00x | 1.00x | 3.0 |
| patterns | single | 3 | 1.00x | 1.00x | 3.0 |
| replace | single | 3 | 1.00x | 1.00x | 3.0 |
| simd | single | 3 | 1.00x | 1.00x | 3.0 |
| sizes | single | 3 | 1.00x | 1.00x | 3.0 |
| slicing | single | 3 | 1.00x | 1.00x | 3.0 |
| spans | single | 3 | 1.00x | 1.00x | 3.0 |
| structures | single | 3 | 1.00x | 1.00x | 3.0 |
| want | single | 3 | 1.00x | 1.00x | 3.0 |
| zero-overhead | compound | 2 | 1.00x | 1.50x | 3.0 |
