# System.Text.Json

## Overview

System.Text.Json is a high-performance JSON serialization library built into .NET. It provides a complete JSON processing stack from low-level UTF-8 readers/writers to high-level serialization APIs. The library serves as the default JSON handler for ASP.NET Core, HttpClient extensions, and configuration systems.

The library provides multiple APIs organized in layers, each serving different performance and flexibility needs:

**High-level APIs** - Simple, strongly-typed operations:
- `JsonSerializer` - Convert between .NET objects and JSON with minimal code
- Supports reflection-based serialization and compile-time source generation

**Document Object Model (DOM)** - Dynamic JSON without defined types:
- `JsonDocument` - Read-only DOM with pooled memory for minimal allocation
- `JsonNode` - Mutable DOM for building and modifying JSON at runtime

**Low-level APIs** - Maximum control and performance:
- `Utf8JsonReader` - Forward-only, zero-allocation JSON parsing
- `Utf8JsonWriter` - Direct UTF-8 JSON writing with minimal overhead

Most applications use `JsonSerializer` for serialization/deserialization and occasionally drop to DOM APIs for dynamic scenarios. The low-level reader/writer APIs are primarily for library authors and custom serialization logic.

**Design principles:**
- **Performance first** - Built on `Span<T>`, UTF-8 operations, and vectorization
- **AOT compatible** - Source generation eliminates reflection for Native AOT scenarios
- **Secure by default** - Depth limits, controlled type resolution, no arbitrary code execution
- **Web optimized** - UTF-8 native, streaming support, minimal allocation

**Integration points:**
- Default serializer for ASP.NET Core web APIs and Minimal APIs
- Powers `HttpClient` JSON extension methods (`GetFromJsonAsync`, `PostAsJsonAsync`)
- Configuration system JSON parsing (`appsettings.json`)
- Microsoft.Extensions.AI structured chat responses

## Quick Reference

Common scenarios with minimal code examples. See component-specific documentation for detailed coverage.

**Basic serialization:**
```csharp
using System.Text.Json;

// Object to JSON
var product = new Product(1, "Laptop", 999.99m);
string json = JsonSerializer.Serialize(product);

// JSON to object
Product item = JsonSerializer.Deserialize<Product>(jsonString)!;
```

**Web API defaults (camelCase):**
```csharp
// Use ASP.NET Core conventions
string json = JsonSerializer.Serialize(obj, JsonSerializerOptions.Web);
```

**Source generation (maximum performance):**
```csharp
[JsonSerializable(typeof(Product))]
internal partial class AppJsonContext : JsonSerializerContext { }

// Use generated code
string json = JsonSerializer.Serialize(product, AppJsonContext.Default.Product);
```

**File I/O (async):**
```csharp
// Write to file
await using var stream = File.Create("data.json");
await JsonSerializer.SerializeAsync(stream, data);

// Read from file
await using var stream = File.OpenRead("data.json");
var data = await JsonSerializer.DeserializeAsync<Data>(stream);
```

**HTTP client extensions:**
```csharp
// GET with deserialization
var user = await httpClient.GetFromJsonAsync<User>("https://api.example.com/users/123");

// POST with serialization
await httpClient.PostAsJsonAsync("https://api.example.com/users", newUser);
```

**Dynamic JSON (read-only, minimal allocation):**
```csharp
using JsonDocument doc = JsonDocument.Parse(json);
string name = doc.RootElement.GetProperty("name").GetString()!;
```

**Dynamic JSON (mutable):**
```csharp
JsonNode data = JsonNode.Parse(json)!;
data["status"] = "updated";
string modified = data.ToJsonString();
```

**Stream large arrays:**
```csharp
await using var stream = File.OpenRead("large-data.json");
await foreach (var item in JsonSerializer.DeserializeAsyncEnumerable<Product>(stream))
{
    await ProcessAsync(item);
}
```

**Custom naming (snake_case, camelCase):**
```csharp
var options = new JsonSerializerOptions
{
    PropertyNamingPolicy = JsonNamingPolicy.SnakeCaseLower
};
string json = JsonSerializer.Serialize(obj, options);
```

**Configuration files (strict validation):**
```csharp
var config = JsonSerializer.Deserialize<AppConfig>(
    configJson, 
    JsonSerializerOptions.Strict);
```

## Choosing the Right API

System.Text.Json provides multiple approaches optimized for different scenarios. Choose based on whether JSON structure is known at compile time, whether modification is needed, and performance requirements.

### Decision tree

1. **Is JSON structure known at compile time?**
   - Use `JsonSerializer.Deserialize<T>()` with defined types

2. **Do you need to modify the JSON?**
   - Use `JsonNode` (mutable DOM)

3. **Read-only access to dynamic JSON?**
   - For most scenarios, use `JsonDocument` (read-only DOM, pooled memory)
   - For custom serialization logic, use ``Utf8JsonReader` and `Utf8JsonReader` (forward-only)

### API comparison

| API | Use When | Performance | Memory | Mutability | Typing |
|-----|----------|-------------|--------|------------|--------|
| `JsonSerializer<T>` + source gen | Known types, max performance | Fastest | Minimal | Objects | Strong |
| `JsonSerializer<T>` + reflection | Known types, development | Fast | Low | Objects | Strong |
| `JsonDocument` | Read-only dynamic JSON | Fast | Minimal (pooled) | Read-only | Loose |
| `JsonNode` | Mutable dynamic JSON | Moderate | Moderate | Mutable | Loose |
| `Utf8JsonReader` | Custom parsing, streaming | Fastest | Minimal | N/A | Loose |
| `Utf8JsonWriter` | Custom writing, streaming | Fastest | Minimal | N/A | Loose |

### Code comparison

```csharp
// 1. Strongly-typed (fastest with source generation, type-safe)
public record User(int Id, string Name, string Email);

[JsonSerializable(typeof(User))]
partial class AppContext : JsonSerializerContext { }

var user = JsonSerializer.Deserialize(json, AppContext.Default.User)!;
// Pros: Type safety, IntelliSense, best performance, AOT compatible
// Cons: Requires type definition, inflexible for changing schemas

// 2. JsonDocument (read-only, minimal allocation)
using JsonDocument doc = JsonDocument.Parse(json);
string name = doc.RootElement.GetProperty("name").GetString()!;
int id = doc.RootElement.GetProperty("id").GetInt32();
// Pros: No types needed, fast, low allocation, pooled memory
// Cons: Read-only, requires disposal, no modification

// 3. JsonNode (mutable, flexible)
JsonNode node = JsonNode.Parse(json)!;
string name = node["name"]!.GetValue<string>();
node["status"] = "updated";  // Can modify
string modified = node.ToJsonString();
// Pros: Can modify, no disposal, flexible
// Cons: Higher allocation, slower, no type safety

// 4. Utf8JsonReader (lowest level, maximum control)
var reader = new Utf8JsonReader(utf8Json);
while (reader.Read())
{
    if (reader.TokenType == JsonTokenType.PropertyName && 
        reader.GetString() == "name")
    {
        reader.Read();
        string name = reader.GetString()!;
    }
}
// Pros: Zero allocation, maximum performance, streaming
// Cons: Complex API, manual state management, forward-only
```

### Scenario recommendations

| Scenario | Recommended API | Rationale |
|----------|----------------|-----------|
| Web API responses | `JsonSerializer<T>` + source gen | Known types, performance critical, AOT compatible |
| Configuration loading | `JsonSerializer<T>` + strict mode | Known schema, early validation needed |
| Webhook routing | `JsonDocument` | Extract event type without full deserialization |
| Middleware/proxies | `JsonNode` | May need to modify, structure varies |
| Large file processing | `DeserializeAsyncEnumerable<T>()` | Constant memory for large arrays |
| Custom converters | `Utf8JsonReader`/`Utf8JsonWriter` | Fine control over format |
| HTTP client calls | `GetFromJsonAsync<T>()` | Known response types, convenience |
| Dynamic config merging | `JsonNode` | Runtime modification of JSON structure |
| Log parsing | `JsonDocument` | Read-only extraction of specific fields |
| Real-time APIs | `JsonSerializer<T>` + source gen | Lowest latency, minimal GC pressure |

### Performance hierarchy (fastest to slowest)

1. `JsonSerializer.Deserialize<T>()` with source generation
2. `Utf8JsonReader` (manual parsing)
3. `JsonDocument.Parse()` (read-only DOM)
4. `JsonSerializer.Deserialize<T>()` with reflection
5. `JsonNode.Parse()` (mutable DOM)

## Component Documentation

For detailed coverage of each API, see the component-specific documentation:

- **[JsonSerializer](../system-text-json-jsonserializer/golden-reference.md)** - High-level serialization and deserialization with options, converters, and source generation
- **[JsonDocument](../system-text-json-jsondocument/golden-reference.md)** - Read-only DOM with pooled memory for efficient navigation
- **[JsonNode](../system-text-json-nodes/golden-reference.md)** - Mutable DOM for building and modifying JSON dynamically
- **[Utf8JsonReader](../system-text-json-utf8jsonreader/golden-reference.md)** - Low-level forward-only reader for custom parsing
- **[Utf8JsonWriter](../system-text-json-utf8jsonwriter/golden-reference.md)** - Low-level writer for custom JSON generation
- **[Source Generation](../system-text-json-source-generation/golden-reference.md)** - Compile-time code generation for performance and AOT compatibility
- **[Migration from Newtonsoft.Json](../system-text-json-migrate-from-newtonsoft/golden-reference.md)** - API mappings and migration guide

## Source Generation

Source generation produces JSON serialization code at compile time, eliminating reflection overhead and enabling Native AOT deployment. It's essential for high-performance scenarios and applications requiring ahead-of-time compilation.

**How it works:**

Define a `JsonSerializerContext` with all types you'll serialize:

```csharp
[JsonSerializable(typeof(User))]
[JsonSerializable(typeof(Product))]
[JsonSerializable(typeof(List<Order>))]
internal partial class AppJsonContext : JsonSerializerContext { }
```

The source generator produces serialization code at compile time. Use the generated context when serializing:

```csharp
// Pass JsonTypeInfo<T> for type-safe operations
string json = JsonSerializer.Serialize(user, AppJsonContext.Default.User);
User user = JsonSerializer.Deserialize(json, AppJsonContext.Default.User)!;

// Or configure options with the context
var options = new JsonSerializerOptions
{
    TypeInfoResolver = AppJsonContext.Default
};
string json = JsonSerializer.Serialize(user, options);
```

**Benefits:**

- **1.3-5x faster** than reflection-based serialization
- **50-90% less memory** allocation during serialization
- **Native AOT compatible** - enables ahead-of-time compilation
- **Trim-friendly** - unused types are removed from published output
- **Compile-time errors** - catches missing type registrations at build time

**When to use source generation:**

- ASP.NET Core web APIs (production deployments)
- Native AOT applications
- High-throughput services (>1000 req/sec)
- Real-time APIs with latency requirements
- Microservices optimizing cold start time
- Applications with strict memory budgets

**When reflection is acceptable:**

- Development and prototyping
- Low-traffic applications
- Administrative tools and CLI apps
- Unit tests and integration tests
- Applications where startup time doesn't matter

**ASP.NET Core integration:**

Configure source generation globally for all API responses:

```csharp
// In Program.cs
services.ConfigureHttpJsonOptions(options =>
{
    options.SerializerOptions.TypeInfoResolver = AppJsonContext.Default;
});

// Controllers automatically use source generation
[HttpGet("/users/{id}")]
public ActionResult<User> GetUser(int id)
{
    return userService.GetUser(id);
}
```

**See:** [System.Text.Json Source Generation documentation](../system-text-json-source-generation/golden-reference.md)

## ASP.NET Core Integration

ASP.NET Core uses System.Text.Json as the default serializer for web APIs, Minimal APIs, and MVC. Source generation provides significant performance improvements for API responses since response types are known at compile time.

**Configure globally:**

```csharp
// In Program.cs - applies to all API responses
services.ConfigureHttpJsonOptions(options =>
{
    options.SerializerOptions.TypeInfoResolver = AppJsonContext.Default;
    options.SerializerOptions.PropertyNamingPolicy = JsonNamingPolicy.CamelCase;
});
```

**Define serialization context:**

```csharp
[JsonSerializable(typeof(User))]
[JsonSerializable(typeof(List<Product>))]
[JsonSerializable(typeof(ApiResponse))]
[JsonSerializable(typeof(ErrorDetails))]
internal partial class AppJsonContext : JsonSerializerContext { }
```

**Controllers automatically use configuration:**

```csharp
[ApiController]
[Route("api/[controller]")]
public class UsersController : ControllerBase
{
    // Return type uses source generation automatically
    [HttpGet("{id}")]
    public ActionResult<User> GetUser(int id)
    {
        return userService.GetUser(id);
    }

    // Request body deserialization uses source generation
    [HttpPost]
    public ActionResult<User> CreateUser(User user)
    {
        return userService.Create(user);
    }
}
```

**Minimal APIs:**

```csharp
app.MapGet("/users/{id}", (int id, IUserService users) =>
    Results.Ok(users.GetUser(id)));

app.MapPost("/users", (User user, IUserService users) =>
    Results.Created($"/users/{user.Id}", users.Create(user)));
```

Both controller and Minimal API endpoints automatically benefit from source generation configuration without code changes.

**Web defaults:**

Use `JsonSerializerOptions.Web` to match ASP.NET Core conventions outside of web API context:

```csharp
// Apply web conventions (camelCase, case-insensitive)
string json = JsonSerializer.Serialize(data, JsonSerializerOptions.Web);
```

## HttpClient Extensions

HttpClient JSON extension methods combine HTTP requests with JSON serialization/deserialization, reducing boilerplate for API calls. They support source generation when configured with `JsonSerializerOptions`.

**Basic usage:**

```csharp
// GET with deserialization
var user = await httpClient.GetFromJsonAsync<User>("https://api.example.com/users/123");

// POST with serialization
var response = await httpClient.PostAsJsonAsync("https://api.example.com/users", newUser);

// PUT with serialization
await httpClient.PutAsJsonAsync("https://api.example.com/users/123", updatedUser);

// PATCH with serialization
await httpClient.PatchAsJsonAsync("https://api.example.com/users/123", partialUpdate);
```

**With source generation:**

```csharp
// Configure HttpClient with source generation context
services.AddHttpClient("ApiClient", client =>
{
    client.BaseAddress = new Uri("https://api.example.com");
})
.AddJsonHttpMessageConverter(options =>
{
    options.SerializerOptions.TypeInfoResolver = AppJsonContext.Default;
});

// Extension methods use source generation automatically
var users = await httpClient.GetFromJsonAsync<List<User>>("/users");
```

**Per-request options:**

```csharp
var options = new JsonSerializerOptions 
{ 
    PropertyNameCaseInsensitive = true,
    TypeInfoResolver = AppJsonContext.Default
};

var data = await httpClient.GetFromJsonAsync<Data>("/data", options);
```

**Direct JsonTypeInfo for compile-time safety:**

```csharp
// Type mismatch caught at compile time
var user = await httpClient.GetFromJsonAsync(
    "https://api.example.com/users/123",
    AppJsonContext.Default.User);
```

## Configuration Files

Configuration files require strict validation to catch malformed JSON early. Use `JsonSerializerOptions.Strict` when loading application configuration to reject common errors.

**Strict mode validation:**

```csharp
var options = JsonSerializerOptions.Strict;
AppConfig config;

try
{
    string configJson = await File.ReadAllTextAsync("appsettings.json");
    config = JsonSerializer.Deserialize<AppConfig>(configJson, options)
        ?? throw new InvalidOperationException("Configuration is null");
}
catch (JsonException ex)
{
    logger.LogError(ex, "Invalid configuration file");
    throw;
}
```

**What strict mode rejects:**

- Duplicate property names
- Trailing commas in arrays/objects
- Comments (`// ...` or `/* ... */`)
- Leading/trailing whitespace inconsistencies

**Configuration model:**

```csharp
public class AppConfig
{
    public DatabaseConfig Database { get; set; } = new();
    public LoggingConfig Logging { get; set; } = new();
    public required string Environment { get; set; }
}

public class DatabaseConfig
{
    public required string ConnectionString { get; set; }
    public int MaxConnections { get; set; } = 100;
}
```

Strict validation provides the first line of defense against configuration errors. Layer additional validation (required properties, value ranges) on top of JSON deserialization.

## Large File Streaming

Process large JSON arrays without loading entire files into memory using `DeserializeAsyncEnumerable<T>()`. This enables constant memory usage regardless of file size.

**Streaming arrays:**

```csharp
await using var stream = File.OpenRead("large-dataset.json");
var items = JsonSerializer.DeserializeAsyncEnumerable<DataItem>(stream);

int processedCount = 0;
await foreach (var item in items)
{
    await ProcessItemAsync(item);
    processedCount++;

    if (processedCount % 1000 == 0)
    {
        logger.LogInformation("Processed {Count} items", processedCount);
    }
}
```

**When to use streaming:**

- JSON files larger than 100MB
- Arrays with thousands of items
- ETL and data migration pipelines
- Batch processing scenarios
- Memory-constrained environments

**PipeReader integration:**

For maximum performance with custom data pipelines:

```csharp
var reader = PipeReader.Create(networkStream);
var obj = await JsonSerializer.DeserializeAsync<MyObject>(reader);
```

Streaming works with source generation for optimal performance on each deserialized item.

## Performance Optimization

System.Text.Json is designed for high performance, but specific patterns unlock maximum throughput and minimal allocation.

**Use source generation in production:**

Source generation provides 1.3-5x speedup over reflection and 50-90% reduction in memory allocation. Always use it for production web APIs and high-throughput services.

```csharp
// Define once
[JsonSerializable(typeof(ApiResponse))]
partial class AppContext : JsonSerializerContext { }

// Use everywhere
string json = JsonSerializer.Serialize(response, AppContext.Default.ApiResponse);
```

**Prefer UTF-8 operations:**

Avoid string encoding overhead by working directly with UTF-8 bytes:

```csharp
// Faster - no string encoding
byte[] utf8Json = JsonSerializer.SerializeToUtf8Bytes(data, AppContext.Default.Data);

// Slower - must encode string to UTF-8
string json = JsonSerializer.Serialize(data);
byte[] utf8 = Encoding.UTF8.GetBytes(json);
```

**Reuse JsonSerializerOptions:**

Creating `JsonSerializerOptions` on each call adds overhead. Reuse instances:

```csharp
// Good - reuse options
private static readonly JsonSerializerOptions _options = new()
{
    PropertyNamingPolicy = JsonNamingPolicy.CamelCase
};

string json = JsonSerializer.Serialize(data, _options);

// Bad - creates new options every time
string json = JsonSerializer.Serialize(data, new JsonSerializerOptions 
{ 
    PropertyNamingPolicy = JsonNamingPolicy.CamelCase 
});
```

**Choose the right API for the job:**

| Scenario | Best API | Why |
|----------|----------|-----|
| Known types | `JsonSerializer<T>` + source gen | Fastest, type-safe |
| Read-only dynamic | `JsonDocument` | Minimal allocation |
| Mutable dynamic | `JsonNode` | Only when modification needed |
| Large arrays | `DeserializeAsyncEnumerable<T>` | Constant memory |
| Custom logic | `Utf8JsonReader`/`Writer` | Zero allocation |

**Stream large files:**

Don't load entire files into memory:

```csharp
// Good - streams data
await using var stream = File.OpenRead("data.json");
var data = await JsonSerializer.DeserializeAsync<Data>(stream);

// Bad - loads entire file
string json = await File.ReadAllTextAsync("data.json");
var data = JsonSerializer.Deserialize<Data>(json);
```

**Benchmark your scenarios:**

Different JSON structures and access patterns affect performance differently. Use BenchmarkDotNet to measure your specific use cases.

## Security Considerations

System.Text.Json includes security hardening for processing untrusted JSON. Understanding these protections helps prevent security vulnerabilities.

**Depth limits prevent stack overflow:**

Default maximum depth is 64 levels to prevent deeply nested JSON from causing stack overflow attacks:

```csharp
// Default depth limit (64)
var data = JsonSerializer.Deserialize<Data>(json);

// Custom depth for trusted sources only
var options = new JsonSerializerOptions { MaxDepth = 128 };
var data = JsonSerializer.Deserialize<Data>(json, options);
```

Only increase depth limits when processing trusted JSON from known sources.

**Source generation prevents unexpected type loading:**

Reflection-based deserialization can potentially instantiate unexpected types. Source generation resolves all types at compile time:

```csharp
// Source generation - types known at compile time
var data = JsonSerializer.Deserialize(json, AppContext.Default.Data);

// Reflection - types discovered at runtime
var data = JsonSerializer.Deserialize<Data>(json);
```

For untrusted JSON, source generation provides stronger security guarantees.

**No built-in size limits:**

System.Text.Json doesn't limit JSON size. For untrusted input, enforce size limits before deserialization:

```csharp
// Enforce size limit at stream level
const int maxSize = 1024 * 1024; // 1MB
using var limitedStream = new LimitedStream(networkStream, maxSize);
var data = await JsonSerializer.DeserializeAsync<Data>(limitedStream);
```

**Type safety with known schemas:**

When possible, use strongly-typed deserialization instead of DOM APIs. This prevents processing of unexpected data structures:

```csharp
// Good - validates against schema
public record ExpectedData(string Id, int Value);
var data = JsonSerializer.Deserialize<ExpectedData>(json);

// Less safe - accepts any structure
JsonNode node = JsonNode.Parse(json);
```

**Validate after deserialization:**

Deserialization only validates JSON syntax. Add business logic validation:

```csharp
var user = JsonSerializer.Deserialize<User>(json)
    ?? throw new InvalidDataException("Null user");

if (string.IsNullOrWhiteSpace(user.Email))
    throw new ValidationException("Email required");

if (user.Age < 0 || user.Age > 150)
    throw new ValidationException("Invalid age");
```

## Customization

JsonSerializer behavior can be customized through `JsonSerializerOptions` and custom converters.

**Common customizations:**

```csharp
var options = new JsonSerializerOptions
{
    // Property naming
    PropertyNamingPolicy = JsonNamingPolicy.CamelCase,        // camelCase
    PropertyNamingPolicy = JsonNamingPolicy.SnakeCaseLower,   // snake_case
    PropertyNamingPolicy = JsonNamingPolicy.KebabCaseLower,   // kebab-case
    
    // Null handling
    DefaultIgnoreCondition = JsonIgnoreCondition.WhenWritingNull,
    
    // Formatting
    WriteIndented = true,
    
    // Case sensitivity
    PropertyNameCaseInsensitive = true,
    
    // Numbers as strings
    NumberHandling = JsonNumberHandling.AllowReadingFromString,
    
    // Enum handling
    Converters = { new JsonStringEnumConverter() },
    
    // Unknown properties
    UnmappedMemberHandling = JsonUnmappedMemberHandling.Disallow
};
```

**Custom converters:**

Implement custom serialization logic for specific types:

```csharp
public class DateOnlyConverter : JsonConverter<DateOnly>
{
    public override DateOnly Read(ref Utf8JsonReader reader, Type typeToConvert, JsonSerializerOptions options)
        => DateOnly.Parse(reader.GetString()!);

    public override void Write(Utf8JsonWriter writer, DateOnly value, JsonSerializerOptions options)
        => writer.WriteStringValue(value.ToString("yyyy-MM-dd"));
}

// Register converter
var options = new JsonSerializerOptions
{
    Converters = { new DateOnlyConverter() }
};
```

**Attributes:**

Control serialization with attributes on types and properties:

```csharp
public class User
{
    [JsonPropertyName("user_id")]
    public int Id { get; set; }
    
    [JsonIgnore]
    public string InternalField { get; set; }
    
    [JsonRequired]
    public required string Email { get; set; }
    
    [JsonPropertyOrder(1)]
    public string Name { get; set; }
}
```

See [JsonSerializer documentation](../system-text-json-jsonserializer/golden-reference.md) for comprehensive customization options.

## Installation and Setup

System.Text.Json is included with the .NET runtime. Most projects require no explicit package reference.

**Default (no package needed):**

```xml
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>net8.0</TargetFramework>
  </PropertyGroup>
  <!-- System.Text.Json included in-box -->
</Project>
```

The in-box version matches your target framework (.NET 8 → System.Text.Json 8.x, .NET 9 → System.Text.Json 9.x).

**When to add PackageReference:**

Add an explicit package only to use newer library features than your target framework provides:

```xml
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>net8.0</TargetFramework>
  </PropertyGroup>
  <ItemGroup>
    <!-- Use System.Text.Json 9.0 features on .NET 8 -->
    <PackageReference Include="System.Text.Json" Version="9.0.0" />
  </ItemGroup>
</Project>
```

**Package pruning (SDK 10+):**

.NET 10 SDK and later show warning NU1510 when adding a PackageReference for the same or lower major version already in-box:

```xml
<!-- This triggers NU1510 on .NET 10+ SDK -->
<PackageReference Include="System.Text.Json" Version="9.0.0" />
```

The warning indicates the reference is redundant and prevents applications from being incorrectly flagged for security vulnerabilities resolved by runtime updates.

**Version selection guidance:**
- **Most applications:** No PackageReference (use in-box version)
- **Early feature adoption:** Add PackageReference for preview features
- **LTS apps:** Add PackageReference for backported fixes while staying on LTS runtime
- **Cross-targeting libraries:** Consider PackageReference for consistent behavior

## Common Patterns

**AI structured responses (Microsoft.Extensions.AI):**

```csharp
[JsonSerializable(typeof(WeatherForecast))]
partial class AppContext : JsonSerializerContext { }

IChatClient client = GetChatClient();
var response = await client.GetResponseAsync<WeatherForecast>(
    "What's the weather in Seattle?",
    serializerOptions: AppContext.Default.Options);
```

**Generic methods with source generation:**

```csharp
// Direct JsonTypeInfo<T> (compile-time type safety)
var data = await httpClient.GetFromJsonAsync(
    "https://api.example.com/data",
    AppJsonContext.Default.DataType);

// Via options (more flexible)
var options = new JsonSerializerOptions 
{ 
    TypeInfoResolver = AppJsonContext.Default 
};
var data = await httpClient.GetFromJsonAsync<DataType>(url, options);
```

**Dynamic JSON routing:**

```csharp
// Read event type without full deserialization
using JsonDocument doc = JsonDocument.Parse(webhookPayload);
string eventType = doc.RootElement.GetProperty("event_type").GetString()!;

// Route and deserialize only relevant portion
if (eventType == "order.created")
{
    var orderData = doc.RootElement.GetProperty("data");
    Order order = JsonSerializer.Deserialize<Order>(orderData.GetRawText())!;
    await ProcessOrder(order);
}
```

**Config merging:**

```csharp
JsonNode baseConfig = JsonNode.Parse(baseConfigJson)!;
JsonNode overrides = JsonNode.Parse(overrideJson)!;

foreach (var prop in overrides.AsObject())
{
    baseConfig[prop.Key] = prop.Value?.DeepClone();
}

string merged = baseConfig.ToJsonString();
```

## Migration from Newtonsoft.Json

Key differences when migrating from Newtonsoft.Json:

**Namespace changes:**
```csharp
// Old
using Newtonsoft.Json;

// New
using System.Text.Json;
```

**API changes:**
```csharp
// Old
string json = JsonConvert.SerializeObject(obj);
var obj = JsonConvert.DeserializeObject<MyType>(json);

// New
string json = JsonSerializer.Serialize(obj);
var obj = JsonSerializer.Deserialize<MyType>(json);
```

**Attribute changes:**
```csharp
// Old
[JsonProperty("user_name")]
public string UserName { get; set; }

// New
[JsonPropertyName("user_name")]
public string UserName { get; set; }
```

**Key behavioral differences:**
- DateTime uses ISO 8601 by default
- No `ISerializable` support
- Requires `[JsonConstructor]` for parameterized constructors
- Polymorphism requires `[JsonDerivedType]` attributes
- Custom converters have different implementation

See [Migration from Newtonsoft.Json guide](../system-text-json-migrate-from-newtonsoft/golden-reference.md) for comprehensive details.

## Related Concepts

**System.Text.Json uses:**
- Source Generators - Enable compile-time `JsonSerializerContext` generation
- `Span<T>` and `Memory<T>` - High-performance UTF-8 processing primitives
- `PipeReader`/`PipeWriter` - Zero-copy I/O for streaming scenarios

**System.Text.Json is used by:**
- ASP.NET Core - Default serializer for web APIs, MVC, and Minimal APIs
- HttpClient - JSON extension methods (`GetFromJsonAsync`, `PostAsJsonAsync`)
- Configuration system - Parsing `appsettings.json` and config files
- Microsoft.Extensions.AI - Structured chat responses deserialization

**System.Text.Json enables:**
- Native AOT deployment - Via source generation with no reflection
- High-performance APIs - Minimal allocation and fast serialization
- Trim-friendly applications - Unused types removed from published output

**Alternatives:**
- Newtonsoft.Json - Feature-rich, established library with broader compatibility
- DataContractJsonSerializer - Legacy .NET Framework serializer
