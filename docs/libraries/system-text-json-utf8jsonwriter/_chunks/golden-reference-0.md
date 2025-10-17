# System.Text.Json.Utf8JsonWriter

## Overview

System.Text.Json.Utf8JsonWriter is a high-performance, low-allocation writer for UTF-8 encoded JSON. It writes JSON directly to UTF-8 byte streams without intermediate string allocation, providing maximum performance for JSON generation. The writer enforces valid JSON structure at runtime and offers complete control over formatting and output.

Utf8JsonWriter operates on `IBufferWriter<byte>` or `Stream`, enabling zero-allocation writing when paired with pooled buffers. This design makes it ideal for generating large JSON documents, streaming responses, and performance-critical serialization where memory allocation must be minimized.

The writer validates JSON structure as you write. Attempting to write invalid JSON throws exceptions immediately, preventing malformed output. Applications call type-specific write methods like `WriteString()`, `WriteNumber()`, and `WriteBoolean()` to add values, with `WriteStartObject()` and `WriteStartArray()` for structural elements.

Key capabilities:

- Direct UTF-8 writing: No string allocation during generation
- Structural validation: Enforces valid JSON at runtime
- Streaming output: Write directly to streams without buffering
- Formatting control: Indented or compact output
- Custom naming: Control property name casing and escaping
- Buffer pooling: Zero-allocation with `ArrayBufferWriter<byte>`
- Maximum performance: Fastest JSON generation in System.Text.Json

Utf8JsonWriter sits at the bottom of the System.Text.Json stack. `JsonSerializer` uses Utf8JsonWriter internally for serialization. Applications use Utf8JsonWriter directly when they need maximum performance, streaming output, or custom JSON generation logic that higher-level APIs cannot provide.

| Scenario | Solution | Key Benefit |
|----------|----------|-------------|
| Large file generation | Write to file stream | Constant memory usage |
| HTTP response streaming | Write to response body | Immediate transmission |
| Custom serialization | Direct writer control | Full flexibility |
| Protocol implementation | Generate streaming JSON | Precise control |
| Performance-critical output | Direct UTF-8 writing | Lowest allocation |
| Dynamic JSON building | Write values conditionally | Runtime structure |
| Bulk data export | Stream to writer | Memory efficient |
| Real-time APIs | Write as data arrives | Low latency |
| Known structure | Use `JsonSerializer.Serialize<T>()` instead | Type safety |
| Simple objects | Use `JsonSerializer.Serialize()` instead | Easier API |
