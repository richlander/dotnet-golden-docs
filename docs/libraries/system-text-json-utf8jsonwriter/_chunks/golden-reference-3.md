# System.Text.Json.Utf8JsonWriter
## Using with ArrayBufferWriter

Achieve zero-allocation writing with pooled buffers.

```csharp
// Use ArrayBufferWriter for zero-allocation writing
var bufferWriter = new ArrayBufferWriter<byte>();
using var writer = new Utf8JsonWriter(bufferWriter);

writer.WriteStartObject();
writer.WriteString("name", "Alice");
writer.WriteNumber("age", 30);
writer.WriteEndObject();

writer.Flush();

// Get result without additional allocation
ReadOnlySpan<byte> utf8Json = bufferWriter.WrittenSpan;

// Or write to stream
ReadOnlyMemory<byte> written = bufferWriter.WrittenMemory;
await stream.WriteAsync(written);
```

## Using with File Streams

Generate large JSON files with constant memory usage.

```csharp
public async Task ExportDataAsync(string filePath, IEnumerable<Record> records)
{
    await using var fileStream = File.Create(filePath);
    await using var writer = new Utf8JsonWriter(fileStream, new JsonWriterOptions 
    { 
        Indented = true 
    });
    
    writer.WriteStartObject();
    writer.WritePropertyName("records");
    writer.WriteStartArray();
    
    int count = 0;
    foreach (var record in records)
    {
        writer.WriteStartObject();
        writer.WriteNumber("id", record.Id);
        writer.WriteString("name", record.Name);
        writer.WriteString("timestamp", record.Timestamp.ToString("O"));
        writer.WriteEndObject();
        
        count++;
        if (count % 1000 == 0)
        {
            await writer.FlushAsync();
        }
    }
    
    writer.WriteEndArray();
    writer.WriteEndObject();
    
    await writer.FlushAsync();
}

public class Record
{
    public int Id { get; set; }
    public string Name { get; set; } = string.Empty;
    public DateTime Timestamp { get; set; }
}
```

## Using with HTTP Response Streams

Stream JSON responses directly to clients.

```csharp
public async Task WriteResponseAsync(HttpContext context, IAsyncEnumerable<Item> items)
{
    context.Response.ContentType = "application/json";
    
    await using var writer = new Utf8JsonWriter(context.Response.Body, 
        new JsonWriterOptions { Indented = false });
    
    writer.WriteStartObject();
    writer.WritePropertyName("items");
    writer.WriteStartArray();
    
    await foreach (var item in items)
    {
        writer.WriteStartObject();
        writer.WriteNumber("id", item.Id);
        writer.WriteString("name", item.Name);
        writer.WriteNumber("price", item.Price);
        writer.WriteEndObject();
        
        // Flush periodically for streaming
        await writer.FlushAsync();
    }
    
    writer.WriteEndArray();
    writer.WriteString("timestamp", DateTime.UtcNow.ToString("O"));
    writer.WriteEndObject();
    
    await writer.FlushAsync();
}

public class Item
{
    public int Id { get; set; }
    public string Name { get; set; } = string.Empty;
    public decimal Price { get; set; }
}
```
