# System.Text.Json.Utf8JsonReader

## Overview

System.Text.Json.Utf8JsonReader is a high-performance, low-allocation, forward-only reader for UTF-8 encoded JSON. It operates directly on UTF-8 byte sequences without string allocation, providing the lowest-level API for JSON parsing in .NET. The reader advances token by token through JSON, exposing each structural element and value as it encounters them.

Utf8JsonReader is a ref struct that operates on `ReadOnlySpan<byte>` or `ReadOnlySequence<byte>`, enabling zero-allocation parsing when working with UTF-8 data. This design makes it ideal for streaming scenarios, large file processing, and performance-critical parsing where memory allocation must be minimized.

The reader provides complete control over parsing, allowing custom validation, selective value extraction, and transformation during reading. Applications call `Read()` to advance to the next token, then inspect `TokenType` and extract values using type-specific methods. The forward-only nature means values cannot be revisited without reparsing.

Key capabilities:

- Forward-only parsing: Sequential token-by-token reading
- Zero allocation: Direct UTF-8 processing without string conversion
- Streaming support: Process data as it arrives without buffering
- Span-based: Works with `ReadOnlySpan<byte>` and `ReadOnlySequence<byte>`
- Custom validation: Validate structure and values during parsing
- Selective extraction: Read only needed values, skip the rest
- Maximum performance: Fastest JSON parsing in System.Text.Json

Utf8JsonReader sits at the bottom of the System.Text.Json stack. `JsonDocument` and `JsonSerializer` use Utf8JsonReader internally. Applications use Utf8JsonReader directly when they need maximum performance, streaming support, or custom parsing logic that higher-level APIs cannot provide.

| Scenario | Solution | Key Benefit |
|----------|----------|-------------|
| Large file processing | Stream to `Utf8JsonReader` | Constant memory usage |
| Network stream parsing | Read as data arrives | Immediate processing |
| Custom validation | Check values during parsing | Early error detection |
| Selective extraction | Read needed values, skip rest | Minimal processing |
| Performance-critical parsing | Direct UTF-8 reading | Lowest allocation |
| Protocol implementation | Parse streaming JSON | Full control |
| Transform during parse | Process tokens, write output | Single-pass transformation |
| Array streaming | Read elements one at a time | Constant memory |
| Random access | Use `JsonDocument` instead | O(1) property access |
| Modification needed | Use `JsonNode` instead | Mutable DOM |
| Known structure | Use `JsonSerializer.Deserialize<T>()` instead | Type safety |
