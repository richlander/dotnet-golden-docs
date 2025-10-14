# System.Text.Json Source Generation

## Overview

System.Text.Json source generation generates JSON serialization code at compile time rather than using runtime reflection. This approach is required for Native AOT applications and delivers significant performance improvements by eliminating runtime metadata collection, reducing startup time, and lowering memory usage.

Source generation resolves all type information at compile time, enabling assembly trimming, faster startup times, and predictable performance characteristics. The generated code eliminates JIT compilation overhead and works directly with UTF-8 data, making it essential for container deployments, serverless functions, and high-throughput APIs.

Key capabilities:

- Native AOT compatibility: Required for ahead-of-time compiled applications
- Performance: Zero runtime reflection, optimized UTF-8 processing
- Type safety: Compile-time generic type resolution with `System.Text.Json.Serialization.Metadata.JsonTypeInfo<T>`
- Automatic naming policies: Reduces need for `[JsonPropertyName]` attributes
- Assembly trimming: Works with dead code elimination and tree shaking

| Scenario | Solution | Key Benefit |
|----------|----------|-------------|
| Native AOT apps | `JsonSerializer.Serialize(obj, Context.Default.Type)` | Mandatory for AOT |
| ASP.NET Core APIs | Configure `TypeInfoResolver` in options | Automatic performance |
| HttpClient operations | Pass `JsonTypeInfo<T>` to extension methods | AOT-compatible HTTP |
| Generic methods | Accept `JsonTypeInfo<T>` parameter | Type-safe generics |
| Naming policies | `JsonSourceGenerationOptions` with naming policy | Avoid manual attributes |

## Quick Start

```csharp
using System.Text.Json;
using System.Text.Json.Serialization;

// Define a model
public record Product(int Id, string Name, decimal Price);

// Create source generation context
[JsonSerializable(typeof(Product))]
[JsonSerializable(typeof(List<Product>))]
[JsonSourceGenerationOptions(PropertyNamingPolicy = JsonKnownNamingPolicy.CamelCase)]
public partial class AppJsonContext : System.Text.Json.Serialization.JsonSerializerContext { }

// Serialize: Object → JSON (compile-time)
var product = new Product { Id = 1, Name = "Laptop", Price = 999.99m };
string json = JsonSerializer.Serialize(product, AppJsonContext.Default.Product);

// Deserialize: JSON → Object (compile-time)
Product result = JsonSerializer.Deserialize(json, AppJsonContext.Default.Product)!;
```

## Creating a JsonSerializerContext

Define a context with all types your application serializes. Source generation runs at compile time and produces type-specific serialization code.

```csharp
[JsonSerializable(typeof(User))]
[JsonSerializable(typeof(List<User>))]
[JsonSerializable(typeof(ApiResponse<User>))]
[JsonSourceGenerationOptions(
    PropertyNamingPolicy = JsonKnownNamingPolicy.SnakeCaseLower,
    WriteIndented = false,
    DefaultIgnoreCondition = JsonIgnoreCondition.WhenWritingNull)]
public partial class ApiJsonContext : JsonSerializerContext { }
```

## Naming Policies

Source generation applies naming policies automatically, eliminating most `[JsonPropertyName]` attributes:

```csharp
// Model without manual attributes
public class DocumentEvaluation
{
    public string CareerRelevance { get; set; } = string.Empty;  // → "career_relevance"
    public string KnowledgeLevel { get; set; } = string.Empty;   // → "knowledge_level"
    public int DocumentQuality { get; set; }                    // → "document_quality"
}

[JsonSerializable(typeof(DocumentEvaluation))]
[JsonSourceGenerationOptions(PropertyNamingPolicy = JsonKnownNamingPolicy.SnakeCaseLower)]
public partial class DocumentContext : JsonSerializerContext { }
```

Only use `[JsonPropertyName]` to override the global policy for specific properties.

## Generic Methods with JsonTypeInfo

Pass `JsonTypeInfo<T>` to enable compile-time type resolution in generic methods:

```csharp
// AOT-compatible generic serialization
public static async Task<T> GetFromApiAsync<T>(
    HttpClient client,
    string endpoint,
    JsonTypeInfo<T> typeInfo) where T : class
{
    var stream = await client.GetStreamAsync(endpoint);
    return await JsonSerializer.DeserializeAsync(stream, typeInfo)
        ?? throw new InvalidOperationException("Null response");
}

// Usage with any source-generated type
var user = await GetFromApiAsync(httpClient, "/api/user/1", ApiJsonContext.Default.User);
var product = await GetFromApiAsync(httpClient, "/api/product/1", ApiJsonContext.Default.Product);
```

The compiler enforces type matching between the generic parameter `T` and the `JsonTypeInfo<T>`, providing compile-time safety.

## Multiple Contexts

Combine multiple contexts when working with types from different domains:

```csharp
[JsonSerializable(typeof(User))]
public partial class UserContext : JsonSerializerContext { }

[JsonSerializable(typeof(Product))]
public partial class ProductContext : JsonSerializerContext { }

// Combine contexts
var options = new JsonSerializerOptions
{
    TypeInfoResolver = JsonTypeInfoResolver.Combine(
        UserContext.Default,
        ProductContext.Default)
};

// Use with any registered type
var userJson = JsonSerializer.Serialize(user, options);
var productJson = JsonSerializer.Serialize(product, options);
```

## Using with ASP.NET Core Web APIs

Configure source generation for all API responses:

```csharp
// Program.cs
var builder = WebApplication.CreateBuilder(args);

builder.Services.ConfigureHttpJsonOptions(options =>
{
    options.SerializerOptions.TypeInfoResolver = JsonTypeInfoResolver.Combine(
        UserContext.Default,
        ProductContext.Default);
});

var app = builder.Build();

// Endpoints automatically use source generation
app.MapGet("/users/{id}", (int id) =>
{
    var user = GetUser(id);
    return Results.Ok(user); // Uses UserContext.Default.User
});

app.MapPost("/users", (User user) =>
{
    SaveUser(user); // Deserializes using UserContext.Default.User
    return Results.Created($"/users/{user.Id}", user);
});
```

## Using with HttpClient JSON Operations

Use source generation with HttpClient extension methods:

```csharp
// Direct usage with JsonTypeInfo<T>
var user = await httpClient.GetFromJsonAsync(
    "https://api.example.com/users/123",
    ApiJsonContext.Default.User);

await httpClient.PostAsJsonAsync(
    "https://api.example.com/users",
    newUser,
    ApiJsonContext.Default.User);

// Or configure options
var options = new JsonSerializerOptions
{
    TypeInfoResolver = ApiJsonContext.Default
};

var users = await httpClient.GetFromJsonAsync<List<User>>(
    "https://api.example.com/users",
    options);
```

### AI Structured Responses

Microsoft.Extensions.AI supports source generation for chat responses:

```csharp
public class WeatherForecast
{
    public string Location { get; set; } = string.Empty;
    public int Temperature { get; set; }
    public string Conditions { get; set; } = string.Empty;
}

[JsonSerializable(typeof(WeatherForecast))]
[JsonSourceGenerationOptions(PropertyNamingPolicy = JsonKnownNamingPolicy.SnakeCaseLower)]
public partial class AiJsonContext : JsonSerializerContext { }

// Get structured chat response
IChatClient client = GetChatClient();
var response = await client.GetResponseAsync<WeatherForecast>(
    "What's the weather in Seattle?",
    serializerOptions: AiJsonContext.Default.Options);

Console.WriteLine($"Temperature: {response.Result.Temperature}°F");
```

### Native AOT Applications

Source generation is mandatory for Native AOT. Reflection-based serialization fails at runtime:

```csharp
// Fails in AOT with IL2026/IL3050 warnings
var json = JsonSerializer.Serialize<User>(user);

// Works in AOT
var json = JsonSerializer.Serialize(user, ApiJsonContext.Default.User);
```

When publishing with AOT enabled (`<PublishAot>true</PublishAot>`) or building libraries with `<IsAotCompatible>true</IsAotCompatible>`, the compiler generates errors for reflection-based serialization. Always use `JsonTypeInfo<T>` overloads.

For class libraries, use `IsAotCompatible` to validate AOT compatibility without publishing as AOT:

```xml
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>net9.0</TargetFramework>
    <IsAotCompatible>true</IsAotCompatible>
  </PropertyGroup>
</Project>
```

## Considerations

### AOT Compatibility

Reflection-based `JsonSerializer` methods generate IL2026 and IL3050 warnings in AOT projects. These warnings indicate runtime failures:

- **IL2026**: Trimmer cannot determine required types
- **IL3050**: AOT cannot generate reflection code

Always use overloads accepting `JsonTypeInfo<T>` or `JsonSerializerOptions` configured with a `TypeInfoResolver`.

### Type Registration

All serialized types must be registered with `[JsonSerializable]` attributes. Forgetting nested types or collections causes runtime errors:

```csharp
// Missing nested type registration
[JsonSerializable(typeof(User))]
public partial class UserContext : JsonSerializerContext { }

// Complete registration
[JsonSerializable(typeof(User))]
[JsonSerializable(typeof(Address))]        // Nested type
[JsonSerializable(typeof(List<User>))]     // Collection
public partial class UserContext : JsonSerializerContext { }
```

### Performance Optimization

Reuse `JsonSerializerOptions` instances across operations. Creating new options on each call adds overhead:

```csharp
// Pre-computed options
public static class JsonDefaults
{
    public static readonly JsonSerializerOptions Options = new()
    {
        TypeInfoResolver = ApiJsonContext.Default,
        WriteIndented = false
    };
}

// Efficient reuse
var json = JsonSerializer.Serialize(obj, JsonDefaults.Options);
```

UTF-8 methods (`JsonSerializer.SerializeToUtf8Bytes`) avoid string encoding overhead when working with byte streams.

## Related Concepts

**Used by System.Text.Json Source Generation:**

- Source Generators (Roslyn compile-time code generation)
- `Span<T>` and `Memory<T>` (UTF-8 processing primitives)
- Reflection metadata (compile-time type analysis)

**Uses System.Text.Json Source Generation:**

- ASP.NET Core web APIs (performance optimization)
- HttpClient JSON extensions (AOT-compatible HTTP operations)
- Microsoft.Extensions.AI (structured chat responses)
- Native AOT applications (mandatory for reflection-free serialization)
- Trimmed deployments (required for JSON serialization)

**Enabled by System.Text.Json Source Generation:**

- High-performance JSON APIs (zero runtime reflection)
- AOT-compatible applications (compile-time type resolution)
- Reduced application startup time (no runtime metadata discovery)
