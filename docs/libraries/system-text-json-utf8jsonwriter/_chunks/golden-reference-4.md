# System.Text.Json.Utf8JsonWriter
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
