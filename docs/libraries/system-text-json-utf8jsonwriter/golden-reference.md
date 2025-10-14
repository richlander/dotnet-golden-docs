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

## Quick Start

```csharp
using System.Text.Json;

// Write to memory stream
using var stream = new MemoryStream();
using var writer = new Utf8JsonWriter(stream, new JsonWriterOptions { Indented = true });

writer.WriteStartObject();
writer.WriteString("name", "Alice");
writer.WriteNumber("age", 30);
writer.WriteBoolean("active", true);
writer.WriteEndObject();

writer.Flush();

// Get JSON as string
string json = Encoding.UTF8.GetString(stream.ToArray());
Console.WriteLine(json);
// {
//   "name": "Alice",
//   "age": 30,
//   "active": true
// }
```

## Writing Simple Objects

Create JSON objects with primitive properties.

```csharp
using var stream = new MemoryStream();
using var writer = new Utf8JsonWriter(stream);

writer.WriteStartObject();

// Write different value types
writer.WriteString("id", "12345");
writer.WriteNumber("count", 42);
writer.WriteBoolean("enabled", true);
writer.WriteNull("metadata");

writer.WriteEndObject();

writer.Flush();
```

## Writing Arrays

Generate JSON arrays with type-specific elements.

```csharp
using var stream = new MemoryStream();
using var writer = new Utf8JsonWriter(stream);

writer.WriteStartObject();

// Array of numbers
writer.WritePropertyName("numbers");
writer.WriteStartArray();
writer.WriteNumberValue(10);
writer.WriteNumberValue(20);
writer.WriteNumberValue(30);
writer.WriteEndArray();

// Array of strings
writer.WritePropertyName("tags");
writer.WriteStartArray();
writer.WriteStringValue("featured");
writer.WriteStringValue("new");
writer.WriteStringValue("sale");
writer.WriteEndArray();

writer.WriteEndObject();
writer.Flush();
```

## Writing Nested Objects

Create deeply nested JSON structures.

```csharp
using var stream = new MemoryStream();
using var writer = new Utf8JsonWriter(stream, new JsonWriterOptions { Indented = true });

writer.WriteStartObject();

writer.WriteString("userId", "123");

// Nested profile object
writer.WritePropertyName("profile");
writer.WriteStartObject();
writer.WriteString("name", "Alice");

// Deeply nested contact object
writer.WritePropertyName("contact");
writer.WriteStartObject();
writer.WriteString("email", "alice@example.com");
writer.WriteString("phone", "555-1234");
writer.WriteEndObject();

writer.WriteEndObject();

writer.WriteEndObject();

writer.Flush();
```

## Writing with Formatting Options

Control JSON output formatting.

```csharp
// Indented output for readability
var indentedOptions = new JsonWriterOptions 
{ 
    Indented = true,
    Encoder = System.Text.Encodings.Web.JavaScriptEncoder.UnsafeRelaxedJsonEscaping
};

using var writer1 = new Utf8JsonWriter(stream, indentedOptions);
writer1.WriteStartObject();
writer1.WriteString("key", "value");
writer1.WriteEndObject();

// Compact output for size
var compactOptions = new JsonWriterOptions { Indented = false };

using var writer2 = new Utf8JsonWriter(stream, compactOptions);
writer2.WriteStartObject();
writer2.WriteString("key", "value");
writer2.WriteEndObject();
```

## Writing Arrays of Objects

Generate arrays containing complex objects.

```csharp
using var stream = new MemoryStream();
using var writer = new Utf8JsonWriter(stream, new JsonWriterOptions { Indented = true });

writer.WriteStartObject();
writer.WritePropertyName("products");
writer.WriteStartArray();

// First product
writer.WriteStartObject();
writer.WriteNumber("id", 1);
writer.WriteString("name", "Widget");
writer.WriteNumber("price", 29.99);
writer.WriteEndObject();

// Second product
writer.WriteStartObject();
writer.WriteNumber("id", 2);
writer.WriteString("name", "Gadget");
writer.WriteNumber("price", 49.99);
writer.WriteEndObject();

writer.WriteEndArray();
writer.WriteEndObject();

writer.Flush();
```

## Writing Conditional Properties

Add properties based on runtime conditions.

```csharp
public void WriteUser(Utf8JsonWriter writer, User user)
{
    writer.WriteStartObject();
    
    writer.WriteString("id", user.Id);
    writer.WriteString("name", user.Name);
    
    // Optional properties
    if (!string.IsNullOrEmpty(user.Email))
    {
        writer.WriteString("email", user.Email);
    }
    
    if (user.IsPremium)
    {
        writer.WriteBoolean("premium", true);
        writer.WritePropertyName("features");
        writer.WriteStartArray();
        foreach (var feature in user.PremiumFeatures)
        {
            writer.WriteStringValue(feature);
        }
        writer.WriteEndArray();
    }
    
    writer.WriteEndObject();
}

public class User
{
    public string Id { get; set; } = string.Empty;
    public string Name { get; set; } = string.Empty;
    public string? Email { get; set; }
    public bool IsPremium { get; set; }
    public List<string> PremiumFeatures { get; set; } = new();
}
```

## Writing Raw JSON Values

Include pre-formatted JSON within output.

```csharp
using var stream = new MemoryStream();
using var writer = new Utf8JsonWriter(stream, new JsonWriterOptions { Indented = true });

writer.WriteStartObject();

writer.WriteString("id", "123");

// Write raw JSON value (already formatted)
string existingJson = """{"nested":"data","count":42}""";
writer.WritePropertyName("rawData");
writer.WriteRawValue(existingJson);

writer.WriteEndObject();

writer.Flush();

// Result:
// {
//   "id": "123",
//   "rawData": {"nested":"data","count":42}
// }
```

## Writing Different Number Types

Write integers, decimals, and floating-point numbers.

```csharp
using var stream = new MemoryStream();
using var writer = new Utf8JsonWriter(stream);

writer.WriteStartObject();

// Different number types
writer.WriteNumber("integer", 42);
writer.WriteNumber("long", 9223372036854775807L);
writer.WriteNumber("double", 3.14159);
writer.WriteNumber("decimal", 99.99m);
writer.WriteNumber("float", 2.5f);

writer.WriteEndObject();

writer.Flush();
```

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

## Writing DateTime and DateTimeOffset

Serialize date and time values in ISO 8601 format.

```csharp
using var stream = new MemoryStream();
using var writer = new Utf8JsonWriter(stream);

writer.WriteStartObject();

// DateTime in ISO 8601 format
writer.WriteString("createdAt", DateTime.UtcNow);

// DateTimeOffset with timezone
writer.WriteString("updatedAt", DateTimeOffset.UtcNow);

// Custom format (write as string)
writer.WriteString("customDate", DateTime.Now.ToString("yyyy-MM-dd"));

writer.WriteEndObject();

writer.Flush();
```

## Writing Guid Values

Serialize Guid values as strings.

```csharp
using var stream = new MemoryStream();
using var writer = new Utf8JsonWriter(stream);

writer.WriteStartObject();

Guid id = Guid.NewGuid();
writer.WriteString("id", id);
writer.WriteString("correlationId", Guid.NewGuid());

writer.WriteEndObject();

writer.Flush();
```

## Writing Property Names from Variables

Use dynamic property names from runtime values.

```csharp
using var stream = new MemoryStream();
using var writer = new Utf8JsonWriter(stream);

writer.WriteStartObject();

// Dynamic property names
var properties = new Dictionary<string, string>
{
    ["firstName"] = "Alice",
    ["lastName"] = "Smith",
    ["email"] = "alice@example.com"
};

foreach (var kvp in properties)
{
    writer.WriteString(kvp.Key, kvp.Value);
}

writer.WriteEndObject();

writer.Flush();
```

## Custom Serialization Logic

Implement custom serialization for complex types.

```csharp
public class CustomSerializer
{
    public async Task SerializeProductAsync(Stream stream, Product product)
    {
        await using var writer = new Utf8JsonWriter(stream, 
            new JsonWriterOptions { Indented = true });
        
        WriteProduct(writer, product);
        
        await writer.FlushAsync();
    }
    
    private void WriteProduct(Utf8JsonWriter writer, Product product)
    {
        writer.WriteStartObject();
        
        writer.WriteNumber("id", product.Id);
        writer.WriteString("name", product.Name);
        writer.WriteNumber("price", product.Price);
        
        // Custom array serialization
        writer.WritePropertyName("tags");
        writer.WriteStartArray();
        foreach (var tag in product.Tags)
        {
            writer.WriteStringValue(tag.ToLowerInvariant());
        }
        writer.WriteEndArray();
        
        // Nested object
        if (product.Metadata != null)
        {
            writer.WritePropertyName("metadata");
            WriteMetadata(writer, product.Metadata);
        }
        
        writer.WriteEndObject();
    }
    
    private void WriteMetadata(Utf8JsonWriter writer, Dictionary<string, object> metadata)
    {
        writer.WriteStartObject();
        
        foreach (var kvp in metadata)
        {
            writer.WritePropertyName(kvp.Key);
            
            switch (kvp.Value)
            {
                case string s:
                    writer.WriteStringValue(s);
                    break;
                case int i:
                    writer.WriteNumberValue(i);
                    break;
                case bool b:
                    writer.WriteBooleanValue(b);
                    break;
                default:
                    writer.WriteNullValue();
                    break;
            }
        }
        
        writer.WriteEndObject();
    }
}

public class Product
{
    public int Id { get; set; }
    public string Name { get; set; } = string.Empty;
    public decimal Price { get; set; }
    public List<string> Tags { get; set; } = new();
    public Dictionary<string, object>? Metadata { get; set; }
}
```

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
