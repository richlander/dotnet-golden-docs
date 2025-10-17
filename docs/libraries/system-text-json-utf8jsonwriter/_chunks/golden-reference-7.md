# System.Text.Json.Utf8JsonWriter
## Related Concepts
### Escaping and Encoding

Writer automatically escapes special characters in strings. Control encoding behavior through `JsonWriterOptions.Encoder`. The default encoder is safe but may over-escape some characters.

```csharp
var options = new JsonWriterOptions
{
    Encoder = System.Text.Encodings.Web.JavaScriptEncoder.UnsafeRelaxedJsonEscaping
};
```

### Async vs Sync Flushing

Use `FlushAsync()` for async scenarios to avoid blocking. Synchronous `Flush()` is fine for CPU-bound operations or when already in synchronous context.

### Stream Ownership

Utf8JsonWriter does not dispose the underlying stream. Manage stream lifetime separately.

```csharp
await using var stream = File.Create("output.json");
await using var writer = new Utf8JsonWriter(stream);
// Write JSON
// Writer disposed, stream still open
// Stream disposed by its own using statement
```

### Performance vs Convenience

Utf8JsonWriter requires more code than `JsonSerializer.Serialize()` but offers better performance for streaming and custom scenarios. Use `JsonSerializer` for simple objects and Utf8JsonWriter for complex, streaming, or performance-critical generation.

## Related Concepts

**Used by System.Text.Json.Utf8JsonWriter:**

- `IBufferWriter<byte>` (buffer abstraction)
- `Stream` (output destination)
- UTF-8 encoding (direct byte writing)

**Uses System.Text.Json.Utf8JsonWriter:**

- `JsonSerializer` (serialization implementation)
- Custom serializers (specialized generation logic)
- Protocol implementations (streaming JSON protocols)
- Export tools (bulk data generation)
- Real-time APIs (streaming responses)

**Alternative to System.Text.Json.Utf8JsonWriter:**

- `JsonSerializer.Serialize<T>()` (strongly-typed, easier API)
- `JsonNode.ToJsonString()` (DOM-based generation)
- String concatenation (not recommended for JSON)
