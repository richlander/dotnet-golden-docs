# System.Text.Json.Utf8JsonWriter
## Flushing and Disposal

Control when data is written to underlying stream.

```csharp
await using var fileStream = File.Create("output.json");
await using var writer = new Utf8JsonWriter(fileStream);

writer.WriteStartObject();

// Write lots of data
for (int i = 0; i < 10000; i++)
{
    writer.WriteString($"key{i}", $"value{i}");
    
    // Flush periodically to avoid buffering too much
    if (i % 1000 == 0)
    {
        await writer.FlushAsync();
    }
}

writer.WriteEndObject();

// Final flush happens automatically on disposal
// But explicit flush ensures data is written
await writer.FlushAsync();
```

## Performance Optimization

Maximize performance using best practices.

```csharp
// Use ArrayBufferWriter for zero-allocation
var bufferWriter = new ArrayBufferWriter<byte>();
using var writer = new Utf8JsonWriter(bufferWriter);

// Disable indentation for smaller output
var options = new JsonWriterOptions { Indented = false };

// Reuse writer for multiple operations (if possible)
// Note: Dispose between complete JSON documents

// Use UTF-8 string literals to avoid encoding overhead
ReadOnlySpan<byte> propertyNameUtf8 = "propertyName"u8;
writer.WritePropertyName(propertyNameUtf8);

// Batch flush operations
int itemCount = 0;
foreach (var item in items)
{
    WriteItem(writer, item);
    
    if (++itemCount % 100 == 0)
    {
        writer.Flush();
    }
}
```

## Considerations

### Manual Structure Validation

Writer validates that JSON structure is valid (matching start/end pairs, properties in objects). However, it does not validate business logic, such as required fields or value ranges. Implement validation separately.
