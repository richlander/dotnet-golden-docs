# System.Text.Json.JsonSerializer
## Streaming Large Arrays

Process large JSON arrays incrementally without loading entire array into memory.

```csharp
public async Task ProcessLargeDatasetAsync(Stream stream)
{
    var items = JsonSerializer.DeserializeAsyncEnumerable<DataItem>(stream);
    
    int count = 0;
    await foreach (DataItem? item in items)
    {
        if (item != null)
        {
            await ProcessItemAsync(item);
            count++;
            
            if (count % 1000 == 0)
            {
                Console.WriteLine($"Processed {count} items");
            }
        }
    }
}

public class DataItem
{
    public int Id { get; set; }
    public string Name { get; set; } = string.Empty;
    public decimal Value { get; set; }
}

Task ProcessItemAsync(DataItem item) => Task.CompletedTask;
```

## Using Source Generation

Enable compile-time code generation for maximum performance.

```csharp
using System.Text.Json.Serialization;

// Define source generation context
[JsonSerializable(typeof(User))]
[JsonSerializable(typeof(List<User>))]
[JsonSourceGenerationOptions(PropertyNamingPolicy = JsonKnownNamingPolicy.CamelCase)]
public partial class AppJsonContext : JsonSerializerContext { }

var user = new User { Id = 1, Name = "Alice" };

// Use source generation (faster, AOT-compatible)
string json = JsonSerializer.Serialize(user, AppJsonContext.Default.User);
User? deserialized = JsonSerializer.Deserialize(json, AppJsonContext.Default.User);

// Configure as default for all operations
var options = new JsonSerializerOptions
{
    TypeInfoResolver = AppJsonContext.Default
};

string json2 = JsonSerializer.Serialize(user, options);
```

## Custom Converters

Implement custom serialization logic for specific types.

```csharp
using System.Text.Json;
using System.Text.Json.Serialization;

// Custom converter for a type
public class DateOnlyConverter : JsonConverter<DateOnly>
{
    public override DateOnly Read(ref Utf8JsonReader reader, Type typeToConvert, JsonSerializerOptions options)
    {
        return DateOnly.ParseExact(reader.GetString()!, "yyyy-MM-dd");
    }
    
    public override void Write(Utf8JsonWriter writer, DateOnly value, JsonSerializerOptions options)
    {
        writer.WriteStringValue(value.ToString("yyyy-MM-dd"));
    }
}

public class Event
{
    public string Name { get; set; } = string.Empty;
    public DateOnly Date { get; set; }
}

var options = new JsonSerializerOptions
{
    Converters = { new DateOnlyConverter() }
};

var evt = new Event { Name = "Conference", Date = new DateOnly(2024, 6, 15) };
string json = JsonSerializer.Serialize(evt, options);
// {"Name":"Conference","Date":"2024-06-15"}
```
