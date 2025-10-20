# Keywords for system-text-json-jsonserializer

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
| deserialization | single | 13 | 1.00x | 1.00x | 2.0x | 26.000 |
| system.text.json.jsonserializer | compound | 5 | 1.50x | 1.50x | 2.0x | 22.500 |
| serialization | single | 10 | 1.00x | 1.00x | 2.0x | 20.000 |
| source generation | compound | 7 | 1.25x | 1.50x | 1.5x | 19.688 |
| json | single | 12 | 1.00x | 1.00x | 1.5x | 18.000 |
| jsonserializer | single | 9 | 1.00x | 1.00x | 2.0x | 18.000 |
| serialize | single | 8 | 1.00x | 1.00x | 2.0x | 16.000 |
| compile-time | compound | 6 | 1.00x | 1.50x | 1.5x | 13.500 |
| constructor parameters | compound | 3 | 1.25x | 1.50x | 2.0x | 11.250 |
| utf-8 operations | compound | 3 | 1.25x | 1.50x | 2.0x | 11.250 |
| control | single | 7 | 1.00x | 1.00x | 1.5x | 10.500 |
| output | single | 5 | 1.00x | 1.00x | 2.0x | 10.000 |
| circular references | compound | 3 | 1.10x | 1.50x | 2.0x | 9.900 |
| constructor | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| customization | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| deserialize | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| names | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| during | single | 5 | 1.00x | 1.00x | 1.5x | 7.500 |
| text | single | 5 | 1.00x | 1.00x | 1.5x | 7.500 |
| custom converters | compound | 2 | 1.25x | 1.50x | 2.0x | 7.500 |
| json schema | compound | 2 | 1.25x | 1.50x | 2.0x | 7.500 |
| naming policies | compound | 2 | 1.25x | 1.50x | 2.0x | 7.500 |
| nullable reference types | compound | 2 | 1.25x | 1.50x | 2.0x | 7.500 |
| property names | compound | 2 | 1.25x | 1.50x | 2.0x | 7.500 |
| null handling | compound | 2 | 1.10x | 1.50x | 2.0x | 6.600 |
| asp | single | 4 | 1.00x | 1.00x | 1.5x | 6.000 |
| logic | single | 4 | 1.00x | 1.00x | 1.5x | 6.000 |
| utf-8 | single | 4 | 1.00x | 1.00x | 1.5x | 6.000 |
| after | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| annotations | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| api | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| behavior | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| configure | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| deserializing | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| dynamic | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| enforce | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| instead | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| jsonserializeroptions | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| maximum | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| prevent | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| reflection-based | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| serializer | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| serializing | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| strings | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| web | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| dom | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
| values | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
