# System.Text.Json - Q&A Pairs

## Basic Usage Questions

**Q: What is System.Text.Json and when should I use it?**
A: System.Text.Json is a high-performance JSON serialization library built into .NET Core 3.0+. Use it when you need fast JSON serialization with low memory allocation, especially for web APIs, microservices, or Native AOT applications. It's 1.3-5x faster than Newtonsoft.Json in most scenarios.

**Q: How do I serialize an object to JSON with System.Text.Json?**
A: Use `JsonSerializer.Serialize()`:

```csharp
var person = new Person { Name = "John", Age = 30 };
string json = JsonSerializer.Serialize(person);
// Result: {"Name":"John","Age":30}
```

**Q: How do I deserialize JSON to an object?**
A: Use `JsonSerializer.Deserialize<T>()`:

```csharp
string json = """{"Name":"John","Age":30}""";
Person person = JsonSerializer.Deserialize<Person>(json);
```

**Q: How do I serialize to a file asynchronously?**
A: Use `JsonSerializer.SerializeAsync()`:

```csharp
await using var fileStream = File.Create("data.json");
await JsonSerializer.SerializeAsync(fileStream, person);
```

**Q: How do I configure JSON serialization options?**
A: Create a `JsonSerializerOptions` instance:

```csharp
var options = new JsonSerializerOptions
{
    PropertyNamingPolicy = JsonNamingPolicy.CamelCase,
    WriteIndented = true,
    DefaultIgnoreCondition = JsonIgnoreCondition.WhenWritingNull
};
string json = JsonSerializer.Serialize(person, options);
```

## Source Generation Questions

**Q: What is source generation and why should I use it?**
A: Source generation creates serialization code at compile time instead of using reflection at runtime. This provides better performance, smaller memory footprint, and enables Native AOT compatibility. Use it for known types in performance-critical applications.

**Q: How do I set up source generation?**
A: Create a partial context class with JsonSerializable attributes:

```csharp
[JsonSerializable(typeof(Person))]
[JsonSerializable(typeof(List<Person>))]
internal partial class MyJsonContext : JsonSerializerContext { }
```

**Q: How do I use source generation for serialization?**
A: Use the generated context:

```csharp
string json = JsonSerializer.Serialize(person, MyJsonContext.Default.Person);
Person person = JsonSerializer.Deserialize(json, MyJsonContext.Default.Person);
```

**Q: How do I specify source generation mode?**
A: Use the GenerationMode property:

```csharp
[JsonSourceGenerationOptions(GenerationMode = JsonSourceGenerationMode.Serialization)]
[JsonSerializable(typeof(Person))]
internal partial class FastSerializationContext : JsonSerializerContext { }
```

**Q: Can I disable reflection entirely for Native AOT?**
A: Yes, set the MSBuild property in your project file:

```xml
<PropertyGroup>
  <JsonSerializerIsReflectionEnabledByDefault>false</JsonSerializerIsReflectionEnabledByDefault>
</PropertyGroup>
```

## .NET 10 Features Questions

**Q: What are the new JSON features in .NET 10?**
A: .NET 10 adds: 1) Strict serialization options preset, 2) AllowDuplicateProperties option, 3) ReferenceHandler support in source generation, and 4) PipeReader deserialization support.

**Q: How do I use the strict serialization options in .NET 10?**
A: Use the new `JsonSerializerOptions.Strict` preset:

```csharp
var data = JsonSerializer.Deserialize<MyData>(json, JsonSerializerOptions.Strict);
```

**Q: How do I prevent duplicate JSON properties in .NET 10?**
A: Set `AllowDuplicateProperties` to false:

```csharp
var options = new JsonSerializerOptions
{
    AllowDuplicateProperties = false
};
// This will throw if JSON contains duplicate properties
```

**Q: How do I handle circular references with source generation in .NET 10?**
A: Use ReferenceHandler in JsonSourceGenerationOptions:

```csharp
[JsonSourceGenerationOptions(ReferenceHandler = ReferenceHandler.Preserve)]
[JsonSerializable(typeof(Node))]
internal partial class CircularRefContext : JsonSerializerContext { }
```

**Q: How do I deserialize from PipeReader in .NET 10?**
A: Use the new PipeReader overloads:

```csharp
MyObject obj = await JsonSerializer.DeserializeAsync<MyObject>(pipeReader);
```

## Performance & Optimization Questions

**Q: How much faster is System.Text.Json compared to Newtonsoft.Json?**
A: System.Text.Json is typically 1.3-5x faster for serialization and uses 50-80% less memory. Performance gains are highest with source generation and UTF-8 operations.

**Q: How do I get the best performance from System.Text.Json?**
A: 1) Use source generation for known types, 2) Use UTF-8 byte arrays instead of strings, 3) Reuse JsonSerializerOptions instances, 4) Avoid reflection when possible.

**Q: Should I use UTF-8 operations for better performance?**
A: Yes, UTF-8 operations are 5-10% faster:

```csharp
byte[] utf8Json = JsonSerializer.SerializeToUtf8Bytes(person);
Person person = JsonSerializer.Deserialize<Person>(utf8Json);
```

**Q: How do I reuse JsonSerializerOptions for better performance?**
A: Create a static or singleton instance:

```csharp
private static readonly JsonSerializerOptions s_options = new()
{
    PropertyNamingPolicy = JsonNamingPolicy.CamelCase
};
// Reuse s_options across multiple calls
```

## Integration Questions

**Q: How do I use System.Text.Json with ASP.NET Core?**
A: It's the default serializer. Configure it in Program.cs:

```csharp
builder.Services.ConfigureHttpJsonOptions(options =>
{
    options.SerializerOptions.PropertyNamingPolicy = JsonNamingPolicy.CamelCase;
});
```

**Q: How do I use System.Text.Json with HttpClient?**
A: Use the extension methods from System.Net.Http.Json:

```csharp
HttpResponseMessage response = await httpClient.PostAsJsonAsync("api/data", person);
Person result = await response.Content.ReadFromJsonAsync<Person>();
```

**Q: How do I combine multiple source generation contexts?**
A: Use JsonTypeInfoResolver.Combine:

```csharp
var options = new JsonSerializerOptions
{
    TypeInfoResolver = JsonTypeInfoResolver.Combine(
        PersonContext.Default,
        ProductContext.Default)
};
```

## Migration & Compatibility Questions

**Q: How do I migrate from Newtonsoft.Json to System.Text.Json?**
A: Key changes: 1) Change namespace to System.Text.Json, 2) Replace [JsonProperty] with [JsonPropertyName], 3) Handle DateTime format differences, 4) Replace custom converters.

**Q: What Newtonsoft.Json features are not supported?**
A: System.Text.Json doesn't support: ISerializable interface, SerializableAttribute, complex constructor scenarios without JsonConstructor, and some advanced polymorphic scenarios.

**Q: Can I use System.Text.Json with .NET Framework?**
A: Yes, install the System.Text.Json NuGet package. It supports .NET Framework 4.6.2+ and .NET Standard 2.0+.

**Q: How do I handle DateTime serialization differences?**
A: System.Text.Json uses ISO 8601 format by default. For custom formats, use JsonConverter:

```csharp
[JsonConverter(typeof(CustomDateTimeConverter))]
public DateTime CreatedDate { get; set; }
```

## Error Handling & Troubleshooting Questions

**Q: How do I handle JSON deserialization errors?**
A: Wrap in try-catch and handle JsonException:

```csharp
try
{
    var obj = JsonSerializer.Deserialize<MyObject>(json);
}
catch (JsonException ex)
{
    // Handle malformed JSON
    Console.WriteLine($"JSON error: {ex.Message}");
}
```

**Q: Why am I getting "JsonException: The JSON value could not be converted"?**
A: This typically occurs when: 1) JSON structure doesn't match the target type, 2) Missing required properties, 3) Type conversion issues. Check your JSON format and class structure.

**Q: How do I debug serialization issues?**
A: 1) Enable indented output with WriteIndented = true, 2) Use JsonSerializerOptions.Web for ASP.NET Core compatibility, 3) Add logging to see the JSON being produced.

**Q: What causes "System.InvalidOperationException: JsonSerializerOptions instance must be marked as read-only"?**
A: This happens when modifying JsonSerializerOptions after first use. Create options before first serialization call or use separate instances.

## Advanced Scenarios Questions

**Q: How do I implement custom JSON converters?**
A: Create a class inheriting from JsonConverter<T>:

```csharp
public class CustomDateConverter : JsonConverter<DateTime>
{
    public override DateTime Read(ref Utf8JsonReader reader, Type typeToConvert, JsonSerializerOptions options) =>
        DateTime.ParseExact(reader.GetString(), "yyyy-MM-dd", null);

    public override void Write(Utf8JsonWriter writer, DateTime value, JsonSerializerOptions options) =>
        writer.WriteStringValue(value.ToString("yyyy-MM-dd"));
}
```

**Q: How do I handle polymorphic serialization?**
A: Use type discriminators with JsonDerivedType attributes:

```csharp
[JsonDerivedType(typeof(Dog), "dog")]
[JsonDerivedType(typeof(Cat), "cat")]
public abstract class Animal { }
```

**Q: How do I serialize private properties or fields?**
A: Use JsonInclude attribute:

```csharp
public class Person
{
    [JsonInclude]
    private string _id;

    [JsonInclude]
    public string Name { get; private set; }
}
```

**Q: How do I handle large JSON files efficiently?**
A: Use streaming APIs:

```csharp
await using var stream = File.OpenRead("large.json");
var data = JsonSerializer.DeserializeAsyncEnumerable<Item>(stream);
await foreach (var item in data)
{
    ProcessItem(item);
}
```
