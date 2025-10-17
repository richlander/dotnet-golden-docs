# System.Text.Json.Utf8JsonWriter
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
