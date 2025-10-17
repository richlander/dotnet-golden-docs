# System.Text.Json.Utf8JsonWriter
## Transform During Writing

Convert data structures while generating JSON.

```csharp
public async Task TransformAndWriteAsync(Stream output, IEnumerable<DataRow> rows)
{
    await using var writer = new Utf8JsonWriter(output, 
        new JsonWriterOptions { Indented = false });
    
    writer.WriteStartArray();
    
    foreach (var row in rows)
    {
        writer.WriteStartObject();
        
        // Transform property names to camelCase
        writer.WriteString("userId", row.USER_ID);
        writer.WriteString("fullName", row.FULL_NAME);
        writer.WriteString("emailAddress", row.EMAIL_ADDRESS);
        
        // Calculate and add derived values
        writer.WriteBoolean("isActive", row.STATUS == "ACTIVE");
        writer.WriteNumber("daysSinceCreated", 
            (DateTime.UtcNow - row.CREATED_DATE).Days);
        
        writer.WriteEndObject();
    }
    
    writer.WriteEndArray();
    
    await writer.FlushAsync();
}

public class DataRow
{
    public string USER_ID { get; set; } = string.Empty;
    public string FULL_NAME { get; set; } = string.Empty;
    public string EMAIL_ADDRESS { get; set; } = string.Empty;
    public string STATUS { get; set; } = string.Empty;
    public DateTime CREATED_DATE { get; set; }
}
```

## Writing to Memory Pooled Buffers

Reuse buffers for multiple operations.

```csharp
public class JsonGenerator
{
    private readonly ArrayPool<byte> _pool = ArrayPool<byte>.Shared;
    
    public async Task<byte[]> GenerateJsonAsync(object data)
    {
        var bufferWriter = new ArrayBufferWriter<byte>();
        await using var writer = new Utf8JsonWriter(bufferWriter);
        
        WriteObject(writer, data);
        
        await writer.FlushAsync();
        
        return bufferWriter.WrittenMemory.ToArray();
    }
    
    private void WriteObject(Utf8JsonWriter writer, object data)
    {
        writer.WriteStartObject();
        writer.WriteString("data", data.ToString() ?? string.Empty);
        writer.WriteString("timestamp", DateTime.UtcNow.ToString("O"));
        writer.WriteEndObject();
    }
}
```

## Validation and Error Handling

Writer validates structure automatically.

```csharp
try
{
    using var stream = new MemoryStream();
    using var writer = new Utf8JsonWriter(stream);
    
    writer.WriteStartObject();
    writer.WriteString("key", "value");
    
    // Error: Cannot write property without name inside object
    // writer.WriteStringValue("orphan"); // Throws InvalidOperationException
    
    // Error: Mismatched end
    // writer.WriteEndArray(); // Throws InvalidOperationException
    
    writer.WriteEndObject(); // Correct
    
    writer.Flush();
}
catch (InvalidOperationException ex)
{
    Console.WriteLine($"Invalid JSON structure: {ex.Message}");
}
```
