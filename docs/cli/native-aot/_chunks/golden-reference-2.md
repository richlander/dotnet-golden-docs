# Publish file-based app (new in .NET 10)
## Relationships & Integration
### ASP.NET Core Integration (.NET 8+)

```csharp
var builder = WebApplication.CreateSlimBuilder(args);
builder.Services.ConfigureHttpJsonOptions(options =>
{
    options.SerializerOptions.TypeInfoResolverChain.Insert(0, AppJsonSerializerContext.Default);
});

var app = builder.Build();
app.MapGet("/", () => "Hello World!");
app.Run();

[JsonSerializable(typeof(WeatherForecast))]
internal partial class AppJsonSerializerContext : JsonSerializerContext { }
```

### Cross-Compilation Support

Limited cross-architecture compilation is supported:

- Windows: x64 ↔ ARM64 with appropriate VS components
- macOS: x64 ↔ ARM64 with XCode toolchain
- Linux: Platform-dependent toolchain setup required

### System.Text.Json Source Generation

System.Text.Json source generation is essential for Native AOT because it replaces reflection-based JSON serialization with compile-time code generation. Traditional JSON serialization uses runtime reflection, which is incompatible with AOT compilation.

```csharp
// ❌ Reflection-based - causes IL2026/IL3050 warnings in AOT
var json = JsonSerializer.Serialize(person);

// ✅ Source generation - AOT compatible
var json = JsonSerializer.Serialize(person, PersonContext.Default.Person);
```

#### Setting Up Source Generation

```csharp
// Define your data model
public class Person
{
    public string FirstName { get; set; } = string.Empty;
    public string LastName { get; set; } = string.Empty;
    public int Age { get; set; }
}

// Create JsonSerializerContext
[JsonSerializable(typeof(Person))]
[JsonSerializable(typeof(List<Person>))]
[JsonSourceGenerationOptions(
    PropertyNamingPolicy = JsonKnownNamingPolicy.CamelCase,
    WriteIndented = true)]
public partial class PersonContext : JsonSerializerContext { }

// Use source-generated serialization
var person = new Person { FirstName = "John", LastName = "Doe", Age = 30 };
string json = JsonSerializer.Serialize(person, PersonContext.Default.Person);
Person result = JsonSerializer.Deserialize(json, PersonContext.Default.Person)!;
```
