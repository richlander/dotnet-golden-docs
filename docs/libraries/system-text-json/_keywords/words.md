# Keywords for system-text-json

Combined local and global scoring:
- Score = count × header_mult × type_mult × global_mult
- header_mult: 1.5x (H1), 1.25x (H2), 1.1x (H3+), 1.0x (none) [compounds only]
- type_mult: 1.5x (compound), 1.0x (single)
- global_mult: 2.0x (<10% of topics), 1.5x (10-25%), 1.0x (≥25%)

| Term | Type | Count | Header Mult | Type Mult | Global Mult | Score |
|------|------|-------|-------------|-----------|-------------|-------|
| source generation | compound | 27 | 1.25x | 1.50x | 1.5x | 75.938 |
| json | single | 70 | 1.00x | 1.00x | 1.0x | 70.000 |
| system.text.json | compound | 20 | 1.50x | 1.50x | 1.5x | 67.500 |
| apis | single | 22 | 1.00x | 1.00x | 1.5x | 33.000 |
| read-only | compound | 14 | 1.00x | 1.50x | 1.5x | 31.500 |
| serialization | single | 21 | 1.00x | 1.00x | 1.5x | 31.500 |
| use | single | 31 | 1.00x | 1.00x | 1.0x | 31.000 |
| api | single | 14 | 1.00x | 1.00x | 2.0x | 28.000 |
| scenarios | single | 14 | 1.00x | 1.00x | 2.0x | 28.000 |
| minimal | single | 17 | 1.00x | 1.00x | 1.5x | 25.500 |
| configuration | single | 12 | 1.00x | 1.00x | 2.0x | 24.000 |
| asp.net core | compound | 6 | 1.25x | 1.50x | 2.0x | 22.500 |
| system | single | 21 | 1.00x | 1.00x | 1.0x | 21.000 |
| large | single | 10 | 1.00x | 1.00x | 2.0x | 20.000 |
| compile-time | compound | 13 | 1.00x | 1.50x | 1.0x | 19.500 |
| dynamic | single | 13 | 1.00x | 1.00x | 1.5x | 19.500 |
| net | single | 13 | 1.00x | 1.00x | 1.5x | 19.500 |
| provides | single | 19 | 1.00x | 1.00x | 1.0x | 19.000 |
| text | single | 19 | 1.00x | 1.00x | 1.0x | 19.000 |
| utf-8 | single | 12 | 1.00x | 1.00x | 1.5x | 18.000 |
| default | single | 9 | 1.00x | 1.00x | 2.0x | 18.000 |
| known | single | 11 | 1.00x | 1.00x | 1.5x | 16.500 |
| streaming | single | 11 | 1.00x | 1.00x | 1.5x | 16.500 |
| web | single | 11 | 1.00x | 1.00x | 1.5x | 16.500 |
| packagereference | single | 8 | 1.00x | 1.00x | 2.0x | 16.000 |
| see | single | 8 | 1.00x | 1.00x | 2.0x | 16.000 |
| deserialization | single | 10 | 1.00x | 1.00x | 1.5x | 15.000 |
| documentation | single | 7 | 1.00x | 1.00x | 2.0x | 14.000 |
| strict | single | 7 | 1.00x | 1.00x | 2.0x | 14.000 |
| version | single | 7 | 1.00x | 1.00x | 2.0x | 14.000 |
| dom | single | 9 | 1.00x | 1.00x | 1.5x | 13.500 |
| high-performance | compound | 6 | 1.00x | 1.50x | 1.5x | 13.500 |
| overhead | single | 9 | 1.00x | 1.00x | 1.5x | 13.500 |
| asp | single | 8 | 1.00x | 1.00x | 1.5x | 12.000 |
| into | single | 8 | 1.00x | 1.00x | 1.5x | 12.000 |
| mutable | single | 8 | 1.00x | 1.00x | 1.5x | 12.000 |
| parsing | single | 8 | 1.00x | 1.00x | 1.5x | 12.000 |
| processing | single | 8 | 1.00x | 1.00x | 1.5x | 12.000 |
| between | single | 6 | 1.00x | 1.00x | 2.0x | 12.000 |
| loading | single | 6 | 1.00x | 1.00x | 2.0x | 12.000 |
| migration | single | 6 | 1.00x | 1.00x | 2.0x | 12.000 |
| need | single | 6 | 1.00x | 1.00x | 2.0x | 12.000 |
| low-level | compound | 5 | 1.00x | 1.50x | 1.5x | 11.250 |
| performance-critical | compound | 5 | 1.00x | 1.50x | 1.5x | 11.250 |
| chat responses | compound | 3 | 1.25x | 1.50x | 2.0x | 11.250 |
| configuration files | compound | 3 | 1.25x | 1.50x | 2.0x | 11.250 |
| document object model | compound | 3 | 1.25x | 1.50x | 2.0x | 11.250 |
| structured chat responses | compound | 3 | 1.25x | 1.50x | 2.0x | 11.250 |
| without | single | 11 | 1.00x | 1.00x | 1.0x | 11.000 |
| no | single | 7 | 1.00x | 1.00x | 1.5x | 10.500 |
| runtime | single | 10 | 1.00x | 1.00x | 1.0x | 10.000 |
| automatically | single | 5 | 1.00x | 1.00x | 2.0x | 10.000 |
| context | single | 5 | 1.00x | 1.00x | 2.0x | 10.000 |
| each | single | 5 | 1.00x | 1.00x | 2.0x | 10.000 |
| enabling | single | 5 | 1.00x | 1.00x | 2.0x | 10.000 |
| entire | single | 5 | 1.00x | 1.00x | 2.0x | 10.000 |
| flexibility | single | 5 | 1.00x | 1.00x | 2.0x | 10.000 |
| http | single | 5 | 1.00x | 1.00x | 2.0x | 10.000 |
| responses | single | 5 | 1.00x | 1.00x | 2.0x | 10.000 |
| newtonsoft.json | compound | 3 | 1.10x | 1.50x | 2.0x | 9.900 |
| code | single | 9 | 1.00x | 1.00x | 1.0x | 9.000 |
| logic | single | 6 | 1.00x | 1.00x | 1.5x | 9.000 |
| maximum | single | 6 | 1.00x | 1.00x | 1.5x | 9.000 |
| validation | single | 6 | 1.00x | 1.00x | 1.5x | 9.000 |
| high-throughput | compound | 3 | 1.00x | 1.50x | 2.0x | 9.000 |
| real-time | compound | 3 | 1.00x | 1.50x | 2.0x | 9.000 |
| add | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| chat | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| explicit | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| format | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| gen | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| in-box | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| needed | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| pipelines | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| requires | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| scenario | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| services | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| sources | single | 4 | 1.00x | 1.00x | 2.0x | 8.000 |
| applications | single | 5 | 1.00x | 1.00x | 1.5x | 7.500 |
| control | single | 5 | 1.00x | 1.00x | 1.5x | 7.500 |
| options | single | 5 | 1.00x | 1.00x | 1.5x | 7.500 |
| asp.net core integration | compound | 2 | 1.25x | 1.50x | 2.0x | 7.500 |
| httpclient extensions | compound | 2 | 1.25x | 1.50x | 2.0x | 7.500 |
| large file streaming | compound | 2 | 1.25x | 1.50x | 2.0x | 7.500 |
| right api | compound | 2 | 1.25x | 1.50x | 2.0x | 7.500 |
| using source generation | compound | 2 | 1.25x | 1.50x | 2.0x | 7.500 |
| support | single | 7 | 1.00x | 1.00x | 1.0x | 7.000 |
| forward-only | compound | 3 | 1.00x | 1.50x | 1.5x | 6.750 |
| high-level | compound | 3 | 1.00x | 1.50x | 1.5x | 6.750 |
| reflection-based | compound | 3 | 1.00x | 1.50x | 1.5x | 6.750 |
| strongly-typed | compound | 3 | 1.00x | 1.50x | 1.5x | 6.750 |
| zero-allocation | compound | 3 | 1.00x | 1.50x | 1.5x | 6.750 |
| direct | single | 4 | 1.00x | 1.00x | 1.5x | 6.000 |
| enables | single | 4 | 1.00x | 1.00x | 1.5x | 6.000 |
| extensions | single | 4 | 1.00x | 1.00x | 1.5x | 6.000 |
| features | single | 4 | 1.00x | 1.00x | 1.5x | 6.000 |
| method | single | 4 | 1.00x | 1.00x | 1.5x | 6.000 |
| modification | single | 4 | 1.00x | 1.00x | 1.5x | 6.000 |
| output | single | 4 | 1.00x | 1.00x | 1.5x | 6.000 |
| package | single | 4 | 1.00x | 1.00x | 1.5x | 6.000 |
| structures | single | 4 | 1.00x | 1.00x | 1.5x | 6.000 |
| adding | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| arrays | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| avoid | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| calls | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| common | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| constant | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| custom | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| defaults | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| defined | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| deserialize | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| different | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| directly | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| early | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| encoding | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| errors | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| extension | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| files | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| instances | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| jsonserializer | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| limits | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| major | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| mode | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| modify | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| modifying | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| newer | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| newtonsoft | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| production | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| providing | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| requiring | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| reuse | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| serializer | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| stream | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| type-safe | compound | 2 | 1.00x | 1.50x | 2.0x | 6.000 |
| types | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| uses | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| warning | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| working | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| works | single | 3 | 1.00x | 1.00x | 2.0x | 6.000 |
| generic methods | compound | 2 | 1.25x | 1.50x | 1.5x | 5.625 |
| performance optimization | compound | 2 | 1.25x | 1.50x | 1.5x | 5.625 |
| across | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
| async | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
| attributes | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
| behavior | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
| both | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
| offers | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
| require | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
| security | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
| through | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
| while | single | 3 | 1.00x | 1.00x | 1.5x | 4.500 |
| patterns | single | 4 | 1.00x | 1.00x | 1.0x | 4.000 |
