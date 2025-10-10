# System.Text.Json

## Overview

System.Text.Json is a high-performance JSON serialization library that converts between .NET objects and JSON text, prioritizing speed and memory efficiency for modern cloud and web applications. The library is built on high-performance .NET primitives like `Span<T>` and vectorization, enabling efficient processing of JSON data with minimal memory allocation.

The library operates through two fundamental patterns: serialize .NET objects to JSON strings or streams, and deserialize JSON data back into strongly-typed .NET objects. For basic usage, `JsonSerializer.Serialize()` and `JsonSerializer.Deserialize<T>()` handle most scenarios. For performance-critical applications, source generation replaces runtime reflection with compile-time code generation, delivering significantly faster serialization with lower memory allocation.

`System.Text.Json` serves as the default JSON serializer for ASP.NET Core web APIs, `HttpClient` JSON extension methods, and configuration systems. Its design emphasizes UTF-8 optimization, Native AOT compatibility, and security through controlled type resolution. The library supports streaming large JSON files, customizing serialization behavior through options, and strict validation for configuration scenarios.

Key capabilities:

- High-performance serialization: 1.3-5x faster than reflection-based alternatives in most scenarios
- Low memory allocation: UTF-8-optimized processing reduces garbage collection pressure
- Source generation support: Compile-time code generation for maximum performance
- Native AOT compatibility: Full support for trimmed and ahead-of-time compiled applications
- Streaming APIs: Process large JSON files without loading entire documents into memory
- Strict validation: Configurable options for configuration file parsing and data validation
- Security hardening: Built-in depth limits and controlled type resolution

The library provides three operational modes: reflection-based serialization for flexibility, source generation for performance, and DOM manipulation for dynamic JSON processing. Most applications use reflection-based serialization during development and source generation in production for optimal performance.

| Scenario | Solution | Key Benefit |
|----------|----------|-------------|
| Basic JSON serialization | `JsonSerializer.Serialize/Deserialize<T>()` | Simple, works everywhere |
| High-performance APIs | Source generation with `JsonSerializerContext` | 1.3-5x faster, AOT compatible |
| Web API responses | Source generation + `ConfigureHttpJsonOptions()` | Automatic performance optimization |
| Configuration files | `JsonSerializerOptions.Strict` | Catches malformed JSON early |
| Large files (>100MB) | `JsonSerializer.DeserializeAsyncEnumerable<T>()` | Constant memory usage |
| HTTP API calls | `GetFromJsonAsync<T>()` / `PostAsJsonAsync()` | Single-line HTTP + deserialization |
| Unknown JSON structure | `JsonDocument` (read-only) | Fast, minimal allocation |
| Modifying JSON structure | `JsonNode` (mutable) | Runtime flexibility for dynamic data |
| Generic methods with AOT | `JsonTypeInfo<T>` parameter | Compile-time type safety |
| AI/Chat structured responses | `GetResponseAsync<T>()` with source generation | Type-safe AI responses |

## Quick Start

```csharp
using System.Text.Json;

// Define a type
public record Product(int Id, string Name, decimal Price);

// Serialize: Object → JSON
var product = new Product(1, "Laptop", 999.99m);
string json = JsonSerializer.Serialize(product);

// Deserialize: JSON → Object
string jsonString = """{"Id":2,"Name":"Mouse","Price":24.99}""";
Product mouse = JsonSerializer.Deserialize<Product>(jsonString)!;
```

## Usage

### Basic Serialization and Deserialization

Convert .NET objects to JSON strings and deserialize JSON text back into strongly-typed objects. Supports both synchronous and asynchronous operations for file I/O.

```csharp
// Serialize object to JSON string
string json = JsonSerializer.Serialize(weatherForecast);

// Deserialize JSON string to object
WeatherForecast forecast = JsonSerializer.Deserialize<WeatherForecast>(json);

// Async file operations
await JsonSerializer.SerializeAsync(fileStream, weatherForecast);
WeatherForecast forecast = await JsonSerializer.DeserializeAsync<WeatherForecast>(fileStream);
```

### Source Generation

Generate serialization code at compile time for optimal performance and Native AOT compatibility. Eliminates reflection overhead and enables trimming support.

```csharp
[JsonSerializable(typeof(WeatherForecast))]
internal partial class SourceGenerationContext : JsonSerializerContext { }

// Use with source generation
string json = JsonSerializer.Serialize(weatherForecast, SourceGenerationContext.Default.WeatherForecast);
WeatherForecast forecast = JsonSerializer.Deserialize(json, SourceGenerationContext.Default.WeatherForecast);
```

### Serialization Options

Customize serialization behavior through `JsonSerializerOptions` including property naming policies, formatting, and handling of null values.

```csharp
var options = new JsonSerializerOptions
{
    PropertyNamingPolicy = JsonNamingPolicy.SnakeCaseLower,
    WriteIndented = true,
    DefaultIgnoreCondition = JsonIgnoreCondition.WhenWritingNull
};

string json = JsonSerializer.Serialize(obj, options);
```

### Web Defaults

Use preconfigured options matching ASP.NET Core conventions for web APIs. Applies camelCase naming and case-insensitive property matching.

```csharp
// Use ASP.NET Core default settings (camelCase, case-insensitive)
string json = JsonSerializer.Serialize(obj, JsonSerializerOptions.Web);
```

### Nullable Annotations

Enforce C# nullable reference type annotations during serialization and deserialization. Validates that non-nullable properties are present in JSON.

```csharp
// Enforce nullable reference type annotations during serialization
var options = new JsonSerializerOptions
{
    RespectNullableAnnotations = true
};

string json = JsonSerializer.Serialize(obj, options);
```

### Strict Validation

Enable strict parsing mode for configuration files and trusted JSON sources. Rejects common issues like duplicate properties and trailing commas.

```csharp
// Strict serialization options for configuration files
var strictOptions = JsonSerializerOptions.Strict;

// Disallow duplicate properties
var options = new JsonSerializerOptions
{
    AllowDuplicateProperties = false
};
```

### Stream Processing

Deserialize large JSON arrays incrementally without loading entire documents into memory. Supports `PipeReader` for high-performance pipeline scenarios.

```csharp
// Process large JSON files without loading entire content
await using var stream = File.OpenRead("products.json");
var products = JsonSerializer.DeserializeAsyncEnumerable<Product>(stream);

await foreach (var product in products)
{
    Console.WriteLine($"{product.Name}: ${product.Price}");
}

// PipeReader support for high-performance scenarios
Product product = await JsonSerializer.DeserializeAsync<Product>(pipeReader);
```

### DOM Manipulation with JsonNode

Parse and modify JSON dynamically when structure is unknown at compile time. Provides mutable document object model for building and transforming JSON.

```csharp
// Parse JSON into mutable DOM
JsonNode data = JsonNode.Parse(jsonString);

// Read values
string name = data["name"].GetValue<string>();
int count = data["items"]["count"].GetValue<int>();

// Modify values
data["status"] = "updated";
data["items"]["count"] = 42;

// Serialize back to JSON
string updatedJson = data.ToJsonString();
```

### Document Reading with JsonDocument

Parse JSON into read-only document object model for efficient navigation and value extraction. Offers better performance than `JsonNode` for read-only scenarios.

```csharp
// Parse JSON into read-only DOM
using JsonDocument doc = JsonDocument.Parse(jsonString);
JsonElement root = doc.RootElement;

// Navigate and read values
string id = root.GetProperty("id").GetString();
JsonElement items = root.GetProperty("items");

foreach (JsonElement item in items.EnumerateArray())
{
    string itemName = item.GetProperty("name").GetString();
}
```

## Common Scenarios

### High-Performance Web API Serialization

Web APIs benefit significantly from source generation because response types are known at compile time. Source generation eliminates reflection overhead, reduces memory allocation, and enables Native AOT compilation for faster startup and lower memory footprint.

Use source generation when building ASP.NET Core APIs with predictable response models. Define a `JsonSerializerContext` with all types the API will serialize, then configure the application to use that context. This approach provides the best performance while maintaining clean, readable code.

```csharp
[JsonSerializable(typeof(ApiResponse))]
[JsonSerializable(typeof(List<User>))]
[JsonSerializable(typeof(ErrorDetails))]
internal partial class ApiContext : JsonSerializerContext { }

// In Program.cs or Startup
services.ConfigureHttpJsonOptions(options =>
{
    options.SerializerOptions.TypeInfoResolver = ApiContext.Default;
});

// Controller methods automatically use source generation
[HttpGet("/users")]
public ActionResult<List<User>> GetUsers()
{
    return userService.GetAllUsers();
}
```

This pattern works seamlessly with ASP.NET Core's built-in JSON handling. The framework automatically uses the configured context for all API responses, applying source generation benefits across the entire application without changing controller code.

### Configuration File Processing with Validation

Configuration files require strict parsing to catch errors early and prevent runtime failures from malformed data. The strict serialization mode rejects common issues like duplicate properties, comments, and trailing commas that might indicate configuration problems.

Use `JsonSerializerOptions.Strict` when deserializing application configuration, feature flags, or deployment manifests. This catches configuration errors at load time rather than allowing invalid data to propagate through the application.

```csharp
// Load configuration with strict validation
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
    // Handle malformed configuration
    logger.LogError(ex, "Invalid configuration file");
    throw;
}

// Configuration is guaranteed to be well-formed
database.ConnectionString = config.Database.ConnectionString;
```

Additional validation can be layered on top of deserialization through validators or required properties, but strict mode provides the first line of defense against common JSON issues.

### Large File Streaming

Processing large JSON arrays without loading the entire file into memory prevents out-of-memory exceptions and reduces garbage collection pressure. The async enumerable API deserializes one item at a time, enabling processing of multi-gigabyte JSON files with minimal memory overhead.

Use `DeserializeAsyncEnumerable<T>()` when processing large JSON arrays from files, network streams, or HTTP responses. This pattern works well for batch processing, ETL pipelines, and data migration scenarios.

```csharp
// Process large JSON array incrementally
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

For extremely high-performance scenarios with custom data pipelines, `PipeReader` support provides zero-copy deserialization directly from network sockets or other streaming sources:

```csharp
// High-performance pipeline deserialization
var reader = PipeReader.Create(networkStream);
MyObject obj = await JsonSerializer.DeserializeAsync<MyObject>(reader);
```

### HttpClient JSON Operations

`HttpClient` extension methods simplify JSON API consumption by combining HTTP requests with JSON deserialization in a single operation. This reduces boilerplate and applies consistent serialization settings across all HTTP operations.

```csharp
// GET request with JSON deserialization
var user = await httpClient.GetFromJsonAsync<User>("https://api.example.com/users/123");

// POST request with JSON serialization
var response = await httpClient.PostAsJsonAsync("https://api.example.com/users", newUser);

// Custom options for specific requests
var options = new JsonSerializerOptions { PropertyNameCaseInsensitive = true };
var data = await httpClient.GetFromJsonAsync<WeatherForecast>(url, options);
```

These extension methods integrate with source generation when configured at the `HttpClient` level through dependency injection, applying performance benefits automatically.

### Dynamic JSON Processing

When JSON structure is unknown at compile time or varies between requests, DOM-based approaches provide flexibility that strongly-typed deserialization cannot. `JsonNode` enables reading and modifying JSON dynamically, while `JsonDocument` offers read-only access with minimal allocation.

Use `JsonNode` when you need to modify JSON structure, merge documents, or build JSON programmatically without defining types. This is common in middleware, proxy services, or applications that aggregate JSON from multiple sources.

```csharp
// Modify JSON structure dynamically
JsonNode config = JsonNode.Parse(configJson);

// Add new properties
config["environment"] = "production";
config["timestamp"] = DateTime.UtcNow.ToString("O");

// Merge configuration from another source
JsonNode overrides = JsonNode.Parse(overrideJson);
foreach (var prop in overrides.AsObject())
{
    config[prop.Key] = prop.Value?.DeepClone();
}

// Serialize modified JSON
string mergedConfig = config.ToJsonString(new JsonSerializerOptions { WriteIndented = true });
```

Use `JsonDocument` for read-only access to dynamic JSON when you need to extract specific values without deserializing the entire structure. `JsonDocument` is allocation-efficient and well-suited for filtering, routing, or extracting metadata from JSON payloads.

```csharp
// Extract metadata without full deserialization
using JsonDocument doc = JsonDocument.Parse(webhookPayload);
JsonElement root = doc.RootElement;

string eventType = root.GetProperty("event_type").GetString();
string timestamp = root.GetProperty("timestamp").GetString();

// Route based on event type
if (eventType == "order.created")
{
    // Deserialize only relevant portion
    JsonElement orderData = root.GetProperty("data");
    Order order = JsonSerializer.Deserialize<Order>(orderData.GetRawText());
    await ProcessOrder(order);
}
```

For scenarios requiring both reading and writing, `JsonNode` provides more flexibility. For read-only scenarios, `JsonDocument` offers better performance. Neither approach benefits from source generation since types are resolved at runtime.

### Generic Methods with Source Generation

Generic methods that serialize or deserialize JSON require explicit type information when using source generation. The simplest pattern passes `JsonTypeInfo<T>` directly as a parameter, providing compile-time type safety and AOT compatibility without reflection.

`HttpClient` JSON extensions demonstrate this pattern. The `GetFromJsonAsync` method takes a `JsonTypeInfo<T>` that is required to match the generic type parameter by the compiler.

```csharp
// Define response model and source generation context
public class WeatherForecast
{
    public string Location { get; set; } = string.Empty;
    public int Temperature { get; set; }
    public string Conditions { get; set; } = string.Empty;
}

[JsonSerializable(typeof(WeatherForecast))]
[JsonSerializable(typeof(User))]
internal partial class AppJsonContext : JsonSerializerContext { }

// Direct JsonTypeInfo<T> parameter provides compile-time type checking
WeatherForecast forecast = await httpClient.GetFromJsonAsync(
    "https://api.example.com/weather/seattle",
    AppJsonContext.Default.WeatherForecast);

// Compiler enforces type matching
User user = await httpClient.GetFromJsonAsync(
    "https://api.example.com/user/123",
    AppJsonContext.Default.User);

// Compiler error - type mismatch caught at compile time
// WeatherForecast forecast = await httpClient.GetFromJsonAsync(
//     "https://api.example.com/weather/seattle",
//     AppJsonContext.Default.User); // error CS0029: Cannot implicitly convert type 'User' to 'WeatherForecast'
```

For scenarios requiring more flexibility, `HttpClient` methods also accept `JsonSerializerOptions` configured with a source generation context. The method retrieves `JsonTypeInfo<T>` internally by calling `GetTypeInfo(typeof(T))` on the options:

```csharp
// Configure options with source generation context
var options = new JsonSerializerOptions
{
    TypeInfoResolver = AppJsonContext.Default
};

// HttpClient uses options to retrieve type information internally
WeatherForecast forecast = await httpClient.GetFromJsonAsync<WeatherForecast>(
    "https://api.example.com/weather/seattle",
    options);

User user = await httpClient.GetFromJsonAsync<User>(
    "https://api.example.com/user/123",
    options);
```

Both patterns enable AOT compatibility and eliminate reflection overhead. Direct `JsonTypeInfo<T>` provides stronger compile-time guarantees with type matching verified by the compiler. `JsonSerializerOptions` offers flexibility when the same configuration applies across multiple types, allowing one shared options instance for all serialization operations.

### Structured Chat Responses with Source Generation

Chat models can return structured JSON responses that deserialize into strongly-typed .NET objects. `Microsoft.Extensions.AI` provides source generation support for this pattern, enabling type-safe chat responses with full AOT compatibility.

The `GetResponseAsync<T>()` method accepts `JsonSerializerOptions` configured with source generation, allowing chat responses to deserialize into domain models without reflection. This approach combines chat capabilities with type safety and performance.

```csharp
// Define response model and source generation context
public class WeatherForecast
{
    public string Location { get; set; } = string.Empty;
    public int Temperature { get; set; }
    public string Conditions { get; set; } = string.Empty;
}

[JsonSerializable(typeof(WeatherForecast))]
internal partial class AppJsonContext : JsonSerializerContext { }

// Request structured output from AI
IChatClient client = GetChatClient();

var response = await client.GetResponseAsync<WeatherForecast>(
    "What's the weather in Seattle?",
    serializerOptions: AppJsonContext.Default.Options);

// Response is strongly typed
Console.WriteLine($"Location: {response.Result.Location}");
Console.WriteLine($"Temperature: {response.Result.Temperature}°F");
Console.WriteLine($"Conditions: {response.Result.Conditions}");
```

When working with multiple AI response types, register them all in the source generation context:

```csharp
[JsonSerializable(typeof(WeatherForecast))]
[JsonSerializable(typeof(ProductRecommendation))]
[JsonSerializable(typeof(List<SearchResult>))]
internal partial class AppJsonContext : JsonSerializerContext { }

// All types work with the same context
var weather = await client.GetResponseAsync<WeatherForecast>(
    "Weather in Toronto?",
    serializerOptions: AppJsonContext.Default.Options);

var products = await client.GetResponseAsync<List<SearchResult>>(
    "Find relevant products for camping",
    serializerOptions: AppJsonContext.Default.Options);
```

This pattern provides compile-time type generation for chat responses, eliminating reflection overhead and enabling Native AOT deployment. The chat model generates JSON matching your schema, and source generation handles deserialization efficiently. Applications using chat features benefit from the same performance optimizations as traditional JSON APIs.

## Installation and Versioning

`System.Text.Json` is included with the .NET runtime and requires no explicit package reference in most scenarios. The library version matches your target framework, providing the appropriate feature set automatically.

**Default behavior - no PackageReference needed:**

```xml
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>net8.0</TargetFramework>
  </PropertyGroup>
  <!-- No PackageReference needed - System.Text.Json included in-box -->
</Project>
```

When targeting .NET 8, the in-box version provides all System.Text.Json 8.x features. When targeting .NET 9, you automatically get System.Text.Json 9.x features. This ensures version alignment between runtime and library capabilities.

**When to add a PackageReference:**

Add an explicit package reference only when you need newer library features than your target framework provides. This scenario occurs when using newer major version features on older frameworks:

```xml
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>net8.0</TargetFramework>
  </PropertyGroup>
  <ItemGroup>
    <!-- Use System.Text.Json 9.0 features in a .NET 8 application -->
    <PackageReference Include="System.Text.Json" Version="9.0.0" />
  </ItemGroup>
</Project>
```

This allows accessing new APIs and features from System.Text.Json 9.0 while running on the .NET 8 runtime. The NuGet package overrides the in-box version, providing the newer implementation.

**Version selection guidance:**

- **Most applications**: No PackageReference - use in-box version
- **Early adopters**: Add PackageReference to use preview features before runtime upgrade
- **Long-term support apps**: Add PackageReference to get bug fixes and performance improvements while staying on LTS runtime
- **Cross-targeting libraries**: Consider adding PackageReference with appropriate version for consistent behavior across target frameworks

### Package Pruning Behavior

When using .NET 10 SDK (or later), adding a PackageReference to System.Text.Json with the same or lower major version [triggers a NU1510 warning](https://learn.microsoft.com/dotnet/core/compatibility/sdk/10.0/nu1510-pruned-references) because the package is already included in-box:

```xml
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>net10.0</TargetFramework>
  </PropertyGroup>
  <ItemGroup>
    <!-- This triggers NU1510 warning on .NET 10+ -->
    <PackageReference Include="System.Text.Json" Version="9.0.0" />
  </ItemGroup>
</Project>
```

A major motivation for pruning is to avoid an application being incorrectly flagged for a security vulnerability in a package that is resolved by updating the runtime.

**Warning output:**

```text
warning NU1510: PackageReference System.Text.Json will not be pruned.
Consider removing this package from your dependencies, as it is likely unnecessary.
```

This warning indicates the PackageReference is redundant and can be removed.

## Limitations and Considerations

### Serialization Differences and Migration

`System.Text.Json` differs from `Newtonsoft.Json` in several fundamental ways. It does not support `ISerializable` and requires `JsonConverter<T>` implementations for custom serialization logic. Types must have a parameterless constructor or use `[JsonConstructor]` to specify which constructor to use during deserialization.

`DateTime` serialization uses ISO 8601 format by default, which differs from `Newtonsoft.Json`'s default format. Applications expecting specific date formats need custom converters or options configuration.

Polymorphic serialization requires explicit type discriminators through `[JsonDerivedType]` attributes or custom converters. `System.Text.Json` does not infer type hierarchies automatically.

When migrating from `Newtonsoft.Json`, expect to change namespaces from `using Newtonsoft.Json` to `using System.Text.Json`, replace `[JsonProperty]` attributes with `[JsonPropertyName]`, and update method calls from `JsonConvert.SerializeObject()` to `JsonSerializer.Serialize()`. Applications with complex polymorphic serialization or extensive custom converters require the most migration effort, as converter implementations differ significantly between the two libraries.

### Performance Optimization

Source generation provides the best performance for known types. Always use source generation in performance-critical code paths, especially for web APIs, real-time systems, and high-throughput services.

UTF-8 operations through `JsonSerializer.SerializeToUtf8Bytes()` and `JsonSerializer.DeserializeFromUtf8Bytes()` avoid string encoding overhead when working with UTF-8 data sources. This matters most for web APIs where UTF-8 is the standard encoding.

Reuse `JsonSerializerOptions` instances across serialization operations. Creating new options instances on each call adds unnecessary overhead from defaults resolution and configuration copying.

For large JSON documents, streaming APIs prevent loading entire documents into memory. Use `JsonSerializer.DeserializeAsyncEnumerable<T>()` for arrays and consider implementing custom streaming logic for complex document structures.

### Security Constraints

Default maximum nesting depth is 64 levels to prevent stack overflow attacks from deeply nested JSON. Adjust through `JsonSerializerOptions.MaxDepth` only when processing trusted JSON sources.

`System.Text.Json` provides no built-in memory consumption limits. For untrusted JSON, implement size limits at the stream level before deserialization.

Source generation prevents unexpected type loading by resolving all types at compile time. This provides stronger security guarantees than reflection-based deserialization for applications processing untrusted JSON.

## Related Concepts

**Used by System.Text.Json:**

- Source Generators (enables `JsonSerializerContext`)
- `Span<T>` and `Memory<T>` (high-performance UTF-8 processing)

**Uses System.Text.Json:**

- ASP.NET Core web APIs and MVC (default serializer)
- HttpClient JSON extension methods (`GetFromJsonAsync`, `PostAsJsonAsync`)
- Configuration system (parsing appsettings.json)
- Minimal APIs (automatic response serialization)
- Microsoft.Extensions.AI (structured chat responses)

**Enabled by System.Text.Json:**

- Native AOT deployment (via source generation)
