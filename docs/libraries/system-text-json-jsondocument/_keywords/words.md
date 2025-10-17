# Keywords for system-text-json-jsondocument

Combined local and global scoring:
- Score = count × header_mult × type_mult × global_mult
- header_mult: 1.5x (H1), 1.25x (H2), 1.1x (H3+), 1.0x (none) [compounds only]
- type_mult: 1.5x (compound), 1.0x (single)
- global_mult: 2.0x (<10% of topics), 1.5x (10-25%), 1.0x (≥25%)

| Term | Type | Count | Header Mult | Type Mult | Global Mult | Score |
|------|------|-------|-------------|-----------|-------------|-------|
| jsondocument | single | 20 | 1.00x | 1.00x | 2.0x | 40.000 |
| system.text.json.jsondocument | compound | 5 | 1.50x | 1.50x | 2.0x | 22.500 |
| jsonelement | single | 8 | 1.00x | 1.00x | 2.0x | 16.000 |
| metadata extraction | compound | 4 | 1.25x | 1.50x | 2.0x | 15.000 |
| strongly-typed objects | compound | 4 | 1.25x | 1.50x | 2.0x | 15.000 |
| read-only | compound | 5 | 1.10x | 1.50x | 1.5x | 12.375 |
| value | single | 6 | 1.00x | 1.00x | 2.0x | 12.000 |
| conditional deserialization | compound | 3 | 1.25x | 1.50x | 2.0x | 11.250 |
| json arrays | compound | 3 | 1.25x | 1.50x | 2.0x | 11.250 |
| webhook routing | compound | 3 | 1.25x | 1.50x | 2.0x | 11.250 |
| deserialization | single | 7 | 1.00x | 1.00x | 1.5x | 10.500 |
| document | single | 5 | 1.00x | 1.00x | 2.0x | 10.000 |
| extract | single | 5 | 1.00x | 1.00x | 2.0x | 10.000 |
| jsonnode | single | 5 | 1.00x | 1.00x | 2.0x | 10.000 |
| pooled | single | 5 | 1.00x | 1.00x | 2.0x | 10.000 |
| without | single | 6 | 1.00x | 1.00x | 1.5x | 9.000 |
| forward-only | compound | 3 | 1.00x | 1.50x | 2.0x | 9.000 |
| checking | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| minimal | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| mutable | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| process | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| into | single | 5 | 1.00x | 1.00x | 1.5x | 7.500 |
| modification | single | 5 | 1.00x | 1.00x | 1.5x | 7.500 |
| text | single | 5 | 1.00x | 1.00x | 1.5x | 7.500 |
| values | single | 5 | 1.00x | 1.00x | 1.5x | 7.500 |
| object properties | compound | 2 | 1.25x | 1.50x | 2.0x | 7.500 |
| use | single | 6 | 1.00x | 1.00x | 1.0x | 6.000 |
| dom | single | 4 | 1.00x | 1.00x | 1.5x | 6.000 |
| before | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| better | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| check | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| disposal | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| disposed | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| faster | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| full | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| iterate | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| lifetime | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| metadata | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| mutation | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| nested | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| requires | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| routing | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| schema-less | compound | 2 | 1.00x | 1.50x | 2.0x | 6.000 |
| uses | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| strongly-typed | compound | 2 | 1.25x | 1.50x | 1.5x | 5.625 |
| provides | single | 5 | 1.00x | 1.00x | 1.0x | 5.000 |
| instead | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
| iteration | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
| json | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
| large | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
| need | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
| offers | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
| parsing | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
| runtime | single | 3 | 1.00x | 1.00x | 1.0x | 3.000 |
| system | single | 3 | 1.00x | 1.00x | 1.0x | 3.000 |
