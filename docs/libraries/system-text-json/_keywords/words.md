# Keywords for system-text-json

Combined local and global scoring:
- Score = count × header_mult × type_mult × global_mult
- header_mult: 1.5x (H1), 1.25x (H2), 1.1x (H3+), 1.0x (none) [compounds only]
- type_mult: 1.5x (compound), 1.0x (single)
- global_mult: 2.0x (<10% of topics), 1.5x (10-25%), 1.0x (≥25%)

| Term | Type | Count | Header Mult | Type Mult | Global Mult | Score |
|------|------|-------|-------------|-----------|-------------|-------|
| source generation | compound | 23 | 1.25x | 1.50x | 1.5x | 64.688 |
| system.text.json | compound | 14 | 1.50x | 1.50x | 1.5x | 47.250 |
| json | single | 29 | 1.00x | 1.00x | 1.5x | 43.500 |
| minimal | single | 19 | 1.00x | 1.00x | 2.0x | 38.000 |
| api | single | 14 | 1.00x | 1.00x | 2.0x | 28.000 |
| apis | single | 14 | 1.00x | 1.00x | 2.0x | 28.000 |
| compile-time | compound | 11 | 1.00x | 1.50x | 1.5x | 24.750 |
| read-only | compound | 10 | 1.00x | 1.50x | 1.5x | 22.500 |
| dynamic | single | 11 | 1.00x | 1.00x | 2.0x | 22.000 |
| use | single | 19 | 1.00x | 1.00x | 1.0x | 19.000 |
| newtonsoft.json | compound | 5 | 1.25x | 1.50x | 2.0x | 18.750 |
| text | single | 12 | 1.00x | 1.00x | 1.5x | 18.000 |
| configuration | single | 9 | 1.00x | 1.00x | 2.0x | 18.000 |
| serialization | single | 9 | 1.00x | 1.00x | 2.0x | 18.000 |
| asp.net core | compound | 6 | 1.25x | 1.50x | 1.5x | 16.875 |
| dom | single | 11 | 1.00x | 1.00x | 1.5x | 16.500 |
| known | single | 11 | 1.00x | 1.00x | 1.5x | 16.500 |
| mutable | single | 8 | 1.00x | 1.00x | 2.0x | 16.000 |
| web | single | 8 | 1.00x | 1.00x | 2.0x | 16.000 |
| low-level | compound | 5 | 1.00x | 1.50x | 2.0x | 15.000 |
| system | single | 14 | 1.00x | 1.00x | 1.0x | 14.000 |
| deserialization | single | 8 | 1.00x | 1.00x | 1.5x | 12.000 |
| packagereference | single | 6 | 1.00x | 1.00x | 2.0x | 12.000 |
| configuration files | compound | 3 | 1.25x | 1.50x | 2.0x | 11.250 |
| no | single | 7 | 1.00x | 1.00x | 1.5x | 10.500 |
| utf-8 | single | 7 | 1.00x | 1.00x | 1.5x | 10.500 |
| add | single | 5 | 1.00x | 1.00x | 2.0x | 10.000 |
| fastest | single | 5 | 1.00x | 1.00x | 2.0x | 10.000 |
| limits | single | 5 | 1.00x | 1.00x | 2.0x | 10.000 |
| maximum | single | 5 | 1.00x | 1.00x | 2.0x | 10.000 |
| migration | single | 5 | 1.00x | 1.00x | 2.0x | 10.000 |
| newtonsoft | single | 5 | 1.00x | 1.00x | 2.0x | 10.000 |
| scenarios | single | 5 | 1.00x | 1.00x | 2.0x | 10.000 |
| see | single | 5 | 1.00x | 1.00x | 2.0x | 10.000 |
| responses | single | 6 | 1.00x | 1.00x | 1.5x | 9.000 |
| high-level | compound | 3 | 1.00x | 1.50x | 2.0x | 9.000 |
| asp | single | 8 | 1.00x | 1.00x | 1.0x | 8.000 |
| provides | single | 8 | 1.00x | 1.00x | 1.0x | 8.000 |
| changes | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| common | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| default | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| depth | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| different | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| each | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| gen | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| loading | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| loose | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| needed | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| serializer | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| high-performance | compound | 5 | 1.00x | 1.50x | 1.0x | 7.500 |
| large | single | 5 | 1.00x | 1.00x | 1.5x | 7.500 |
| logic | single | 5 | 1.00x | 1.00x | 1.5x | 7.500 |
| parsing | single | 5 | 1.00x | 1.00x | 1.5x | 7.500 |
| asp.net core integration | compound | 2 | 1.25x | 1.50x | 2.0x | 7.500 |
| httpclient extensions | compound | 2 | 1.25x | 1.50x | 2.0x | 7.500 |
| right api | compound | 2 | 1.25x | 1.50x | 2.0x | 7.500 |
| reflection-based | compound | 3 | 1.00x | 1.50x | 1.5x | 6.750 |
| extensions | single | 4 | 1.00x | 1.00x | 1.5x | 6.000 |
| component-specific | compound | 2 | 1.00x | 1.50x | 2.0x | 6.000 |
| config | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| constant | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| context | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| documentation | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| early | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| enables | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| errors | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| extension | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| forward-only | compound | 2 | 1.00x | 1.50x | 2.0x | 6.000 |
| high-throughput | compound | 2 | 1.00x | 1.50x | 2.0x | 6.000 |
| http | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| in-box | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| jsonserializer | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| mode | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| prevent | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| prevents | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| production | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| real-time | compound | 2 | 1.00x | 1.50x | 2.0x | 6.000 |
| scenario | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| structured | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| trim-friendly | compound | 2 | 1.00x | 1.50x | 2.0x | 6.000 |
| unexpected | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| untrusted | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| uses | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| code | single | 5 | 1.00x | 1.00x | 1.0x | 5.000 |
| runtime | single | 5 | 1.00x | 1.00x | 1.0x | 5.000 |
| attributes | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
| control | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
| into | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
| microsoft | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
| modification | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
| security | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
| strongly-typed | compound | 2 | 1.00x | 1.50x | 1.5x | 4.500 |
| zero-allocation | compound | 2 | 1.00x | 1.50x | 1.5x | 4.500 |
| patterns | single | 3 | 1.00x | 1.00x | 1.0x | 3.000 |
