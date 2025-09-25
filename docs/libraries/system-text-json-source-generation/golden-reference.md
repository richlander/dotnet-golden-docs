# System.Text.Json Source Generation - Comprehensive Reference

## Overview

System.Text.Json source generation revolutionizes JSON serialization by generating serialization code at compile time through static analysis rather than relying on runtime reflection. This approach is essential for Native AOT applications, trimmed deployments, and provides significant performance improvements with UTF-8 optimization and memory efficiency. Source generation enables type-safe JSON operations with unconstrained generics, works synergistically with assembly trimming and dead code elimination, and handles property naming policies automatically, reducing the need for manual `JsonPropertyName` attributes.

Introduced in .NET 6, source generation represents a fundamental shift toward compile-time safety and AOT compatibility. It's particularly valuable in high-performance scenarios, container deployments, serverless functions, cloud applications, and any situation requiring predictable startup times and smaller deployment sizes. The technology enables seamless migration from Newtonsoft.Json patterns while providing superior performance characteristics.

```csharp
// Traditional reflection-based approach (not AOT-compatible)
var json = JsonSerializer.Serialize(person);

// Source generation approach (AOT-compatible)
var json = JsonSerializer.Serialize(person, PersonContext.Default.Person);
```

## Why Source Generation Matters

### Native AOT Compatibility

Source generation is mandatory for Native AOT applications since AOT compilation cannot support the runtime reflection that traditional JSON serialization requires:

```csharp
// This will fail in AOT scenarios
var json = JsonSerializer.Serialize<Person>(person); // Runtime reflection

// This works in AOT scenarios
var json = JsonSerializer.Serialize(person, PersonContext.Default.Person); // Compile-time generation
```

When you attempt to publish reflection-based JSON code as AOT, you'll encounter these specific error messages:

```
warning IL2026: Using member 'System.Text.Json.JsonSerializer.Serialize<TValue>(TValue, JsonSerializerOptions?)' which has 'RequiresUnreferencedCodeAttribute' can break functionality when trimming application code. JSON serialization and deserialization might require types that cannot be statically analyzed. Use the overload that takes a JsonTypeInfo or JsonSerializerContext, or make sure all of the required types are preserved.

warning IL3050: Using member 'System.Text.Json.JsonSerializer.Serialize<TValue>(TValue, JsonSerializerOptions?)' which has 'RequiresDynamicCodeAttribute' can break functionality when AOT compiling. JSON serialization and deserialization might require types that cannot be statically analyzed and might need runtime code generation. Use System.Text.Json source generation for native AOT applications.
```

These warnings indicate that your code will fail at runtime in AOT scenarios because:
- **IL2026**: The trimmer cannot determine which types need to be preserved
- **IL3050**: AOT compilation cannot generate the dynamic code needed for reflection-based serialization

### Performance Benefits

Source generation eliminates runtime overhead by pre-computing serialization logic:

- **Zero runtime reflection**: All type information resolved at compile time
- **UTF-8 optimization**: Direct UTF-8 processing without string conversion overhead, 1.3-5x faster than reflection-based approaches
- **Memory efficiency**: Lower allocation overhead and optimized serialization paths, 20-50% reduction in memory usage
- **High-throughput applications**: Ideal for scenarios processing large volumes of JSON in web APIs and microservices
- **Faster startup**: No runtime code generation or metadata discovery, critical for container and serverless cold starts
- **Predictable performance**: Consistent execution times without JIT compilation overhead

### Type Safety with Generics

Source generation enables type-safe operations with unconstrained generic parameters:

```csharp
// Generic method that works with any source-generated type
public static async Task<T> DeserializeAsync<T>(string json, JsonTypeInfo<T> typeInfo)
{
    return JsonSerializer.Deserialize<T>(json, typeInfo)!;
}

// Usage with compile-time safety
var person = await DeserializeAsync(json, PersonContext.Default.Person);
var product = await DeserializeAsync(json, ProductContext.Default.Product);
```

## Basic Source Generation Setup

### Creating a JsonSerializerContext

The foundation of source generation is the `JsonSerializerContext`:

```csharp
// Define your data models
public class Person
{
    public string FirstName { get; set; } = string.Empty;
    public string LastName { get; set; } = string.Empty;
    public int Age { get; set; }
    public DateTime BirthDate { get; set; }
}

// Create source generation context
[JsonSerializable(typeof(Person))]
[JsonSerializable(typeof(List<Person>))]
[JsonSourceGenerationOptions(
    PropertyNamingPolicy = JsonKnownNamingPolicy.CamelCase,
    WriteIndented = true,
    DefaultIgnoreCondition = JsonIgnoreCondition.WhenWritingNull)]
public partial class PersonContext : JsonSerializerContext
{
}
```

### Using the Generated Context

```csharp
// Serialization with source generation
var person = new Person { FirstName = "John", LastName = "Doe", Age = 30 };

// Strongly-typed serialization
string json = JsonSerializer.Serialize(person, PersonContext.Default.Person);

// Strongly-typed deserialization
Person deserializedPerson = JsonSerializer.Deserialize(json, PersonContext.Default.Person)!;

// Collection support
var people = new List<Person> { person };
string peopleJson = JsonSerializer.Serialize(people, PersonContext.Default.ListPerson);
```

## Avoiding JsonPropertyName with Source Generation Options

### The Problem: Redundant JsonPropertyName

A common anti-pattern is using `JsonPropertyName` when `JsonSourceGenerationOptions` already handles naming:

```csharp
// ❌ REDUNDANT: JsonPropertyName when naming policy exists
public class DocumentEvaluation
{
    [JsonPropertyName("career_relevance")]  // Unnecessary!
    public string CareerRelevance { get; set; } = string.Empty;

    [JsonPropertyName("knowledge_level")]   // Unnecessary!
    public string KnowledgeLevel { get; set; } = string.Empty;
}

[JsonSourceGenerationOptions(PropertyNamingPolicy = JsonKnownNamingPolicy.SnakeCaseLower)]
public partial class DocumentContext : JsonSerializerContext { }
```

### The Solution: Let Source Generation Handle Naming

```csharp
// ✅ CLEAN: Let source generation handle naming policy
public class DocumentEvaluation
{
    public string CareerRelevance { get; set; } = string.Empty;     // Becomes "career_relevance"
    public string KnowledgeLevel { get; set; } = string.Empty;      // Becomes "knowledge_level"
    public int DocumentQuality { get; set; }                       // Becomes "document_quality"
    public string BriefExplanation { get; set; } = string.Empty;   // Becomes "brief_explanation"
}

[JsonSerializable(typeof(DocumentEvaluation))]
[JsonSourceGenerationOptions(
    PropertyNamingPolicy = JsonKnownNamingPolicy.SnakeCaseLower,
    WriteIndented = true)]
public partial class DocumentContext : JsonSerializerContext
{
}
```

### When to Use JsonPropertyName

Only use `JsonPropertyName` when you need to override the global naming policy:

```csharp
public class ApiResponse
{
    public string Status { get; set; } = string.Empty;           // Uses naming policy

    [JsonPropertyName("api_version")]                           // Override for specific naming
    public string Version { get; set; } = string.Empty;         // Different from policy

    public List<string> Data { get; set; } = new();            // Uses naming policy
}

[JsonSourceGenerationOptions(PropertyNamingPolicy = JsonKnownNamingPolicy.CamelCase)]
public partial class ApiContext : JsonSerializerContext { }
```

## Generic Type Support with JsonTypeInfo

### The Challenge: Unconstrained Generics in AOT

Traditional generic serialization fails in AOT scenarios:

```csharp
// ❌ This doesn't work in AOT - requires runtime reflection
public static T Deserialize<T>(string json) where T : class
{
    return JsonSerializer.Deserialize<T>(json)!; // IL2026/IL3050 warnings
}
```

### The Solution: JsonTypeInfo Parameters

Pass `JsonTypeInfo<T>` to enable AOT-compatible generic operations:

```csharp
// ✅ AOT-compatible generic serialization
public static class ResponsesApi
{
    public static async Task<T> ExecuteSingleTurnAsync<T>(
        ChatClient client,
        string prompt,
        JsonTypeInfo<T> jsonTypeInfo,  // Enable AOT compatibility
        CancellationToken cancellationToken = default) where T : class
    {
        var response = await client.CompleteChatAsync(prompt, cancellationToken);
        var content = response.Value.Content[0].Text ?? "";

        // Uses source-generated deserialization
        return JsonSerializer.Deserialize<T>(content, jsonTypeInfo)!;
    }
}
```

### Usage with Any Source-Generated Type

```csharp
// Define multiple contexts for different types
[JsonSerializable(typeof(DocumentEvaluation))]
[JsonSourceGenerationOptions(PropertyNamingPolicy = JsonKnownNamingPolicy.SnakeCaseLower)]
public partial class DocumentContext : JsonSerializerContext { }

[JsonSerializable(typeof(UserProfile))]
[JsonSourceGenerationOptions(PropertyNamingPolicy = JsonKnownNamingPolicy.CamelCase)]
public partial class UserContext : JsonSerializerContext { }

// Generic method works with any source-generated type
var documentEval = await ResponsesApi.ExecuteSingleTurnAsync(
    client,
    prompt,
    DocumentContext.Default.DocumentEvaluation);

var userProfile = await ResponsesApi.ExecuteSingleTurnAsync(
    client,
    prompt,
    UserContext.Default.UserProfile);
```

## Advanced Source Generation Patterns

### Multiple Types in One Context

```csharp
[JsonSerializable(typeof(Person))]
[JsonSerializable(typeof(List<Person>))]
[JsonSerializable(typeof(Dictionary<string, Person>))]
[JsonSerializable(typeof(PersonResponse))]
[JsonSerializable(typeof(ApiResult<Person>))]
[JsonSourceGenerationOptions(
    PropertyNamingPolicy = JsonKnownNamingPolicy.CamelCase,
    WriteIndented = true,
    GenerationMode = JsonSourceGenerationMode.Serialization | JsonSourceGenerationMode.Metadata)]
public partial class PersonContext : JsonSerializerContext
{
}
```

### Context Composition

```csharp
// Base context for common types
[JsonSerializable(typeof(string))]
[JsonSerializable(typeof(int))]
[JsonSerializable(typeof(DateTime))]
[JsonSourceGenerationOptions(PropertyNamingPolicy = JsonKnownNamingPolicy.CamelCase)]
public partial class BaseContext : JsonSerializerContext { }

// Domain-specific contexts
[JsonSerializable(typeof(User))]
[JsonSerializable(typeof(List<User>))]
public partial class UserContext : JsonSerializerContext { }

// Combined resolver for multiple contexts
var options = new JsonSerializerOptions
{
    TypeInfoResolver = JsonTypeInfoResolver.Combine(
        BaseContext.Default,
        UserContext.Default)
};
```

### Generation Modes

```csharp
// Metadata-only mode (for deserialization only)
[JsonSourceGenerationOptions(GenerationMode = JsonSourceGenerationMode.Metadata)]
public partial class MetadataOnlyContext : JsonSerializerContext { }

// Serialization-only mode (for serialization only)
[JsonSourceGenerationOptions(GenerationMode = JsonSourceGenerationMode.Serialization)]
public partial class SerializationOnlyContext : JsonSerializerContext { }

// Both modes (default)
[JsonSourceGenerationOptions(GenerationMode = JsonSourceGenerationMode.Serialization | JsonSourceGenerationMode.Metadata)]
public partial class FullContext : JsonSerializerContext { }
```

## Property Naming Policies and Conventions

### Available Naming Policies

```csharp
// CamelCase: PropertyName -> propertyName
[JsonSourceGenerationOptions(PropertyNamingPolicy = JsonKnownNamingPolicy.CamelCase)]

// Snake case lower: PropertyName -> property_name
[JsonSourceGenerationOptions(PropertyNamingPolicy = JsonKnownNamingPolicy.SnakeCaseLower)]

// Snake case upper: PropertyName -> PROPERTY_NAME
[JsonSourceGenerationOptions(PropertyNamingPolicy = JsonKnownNamingPolicy.SnakeCaseUpper)]

// Kebab case lower: PropertyName -> property-name
[JsonSourceGenerationOptions(PropertyNamingPolicy = JsonKnownNamingPolicy.KebabCaseLower)]

// Kebab case upper: PropertyName -> PROPERTY-NAME
[JsonSourceGenerationOptions(PropertyNamingPolicy = JsonKnownNamingPolicy.KebabCaseUpper)]
```

### Custom Naming Policy

```csharp
public class CustomNamingPolicy : JsonNamingPolicy
{
    public override string ConvertName(string name)
    {
        // Custom transformation logic
        return $"custom_{name.ToLowerInvariant()}";
    }
}

// Note: Custom policies require runtime support and may not work in all AOT scenarios
```

## Performance Optimization Patterns

### Pre-computing Serialization Options

```csharp
public static class JsonDefaults
{
    // Pre-computed options for reuse
    public static readonly JsonSerializerOptions DocumentOptions = new()
    {
        TypeInfoResolver = DocumentContext.Default,
        WriteIndented = false  // Override context settings if needed
    };

    public static readonly JsonSerializerOptions UserOptions = new()
    {
        TypeInfoResolver = UserContext.Default,
        WriteIndented = true
    };
}

// Efficient reuse
var json = JsonSerializer.Serialize(document, JsonDefaults.DocumentOptions);
```

### Streaming with Source Generation

```csharp
// Efficient streaming serialization
public static async Task SerializeToStreamAsync<T>(
    T value,
    Stream stream,
    JsonTypeInfo<T> typeInfo,
    CancellationToken cancellationToken = default)
{
    await JsonSerializer.SerializeAsync(stream, value, typeInfo, cancellationToken);
}

// Usage
await using var stream = new FileStream("data.json", FileMode.Create);
await SerializeToStreamAsync(people, stream, PersonContext.Default.ListPerson);
```

## Integration Patterns

### ASP.NET Core Integration

Source generation integrates seamlessly with ASP.NET Core for high-performance web APIs:

```csharp
// Program.cs configuration - similar to System.Text.Json setup
var builder = WebApplication.CreateBuilder(args);

// Configure JSON options with source generation (replaces reflection-based serialization)
builder.Services.Configure<JsonOptions>(options =>
{
    options.SerializerOptions.TypeInfoResolver = JsonTypeInfoResolver.Combine(
        PersonContext.Default,
        ProductContext.Default);
    options.SerializerOptions.PropertyNamingPolicy = JsonNamingPolicy.CamelCase;
    options.SerializerOptions.WriteIndented = false; // Optimize for production
});

var app = builder.Build();

// Controllers automatically use source generation - no Newtonsoft.Json migration needed
app.MapGet("/person/{id}", (int id) =>
{
    var person = GetPerson(id);
    return Results.Ok(person); // Uses PersonContext automatically, UTF-8 optimized
});

// Minimal API with explicit source generation
app.MapPost("/person", (Person person) =>
{
    // Automatically deserializes using PersonContext.Default.Person
    SavePerson(person);
    return Results.Created($"/person/{person.Id}", person);
});
```

### HttpClient Integration

HttpClient extensions work seamlessly with source generation, providing the same API as System.Text.Json with better performance:

```csharp
public class ApiClient
{
    private readonly HttpClient _httpClient;

    public ApiClient(HttpClient httpClient)
    {
        _httpClient = httpClient;
    }

    // UTF-8 optimized HTTP operations with source generation
    public async Task<T> GetAsync<T>(string endpoint, JsonTypeInfo<T> typeInfo)
    {
        var response = await _httpClient.GetAsync(endpoint);
        var stream = await response.Content.ReadAsStreamAsync();
        // Direct UTF-8 deserialization - no string conversion overhead
        return await JsonSerializer.DeserializeAsync(stream, typeInfo);
    }

    public async Task PostAsync<T>(string endpoint, T data, JsonTypeInfo<T> typeInfo)
    {
        // SerializeToUtf8Bytes for optimal performance
        var jsonBytes = JsonSerializer.SerializeToUtf8Bytes(data, typeInfo);
        var content = new ByteArrayContent(jsonBytes);
        content.Headers.ContentType = new MediaTypeHeaderValue("application/json");
        await _httpClient.PostAsync(endpoint, content);
    }

    // Extension method style (similar to System.Text.Json HttpClient extensions)
    public async Task<T> GetFromJsonAsync<T>(string endpoint, JsonTypeInfo<T> typeInfo)
    {
        return await _httpClient.GetFromJsonAsync(endpoint, typeInfo);
    }
}

// Usage - drop-in replacement for reflection-based HttpClient JSON extensions
var person = await apiClient.GetFromJsonAsync("/api/person/1", PersonContext.Default.Person);
await apiClient.PostAsJsonAsync("/api/person", person, PersonContext.Default.Person);

// Direct HttpClient usage with source generation (same API as System.Text.Json)
var httpClient = new HttpClient();
var person = await httpClient.GetFromJsonAsync("/api/person/1", PersonContext.Default.Person);
```

## Common Patterns and Best Practices

### 1. Centralized Context Management

```csharp
// Central registry for all contexts
public static class JsonContexts
{
    public static readonly JsonTypeInfoResolver Resolver = JsonTypeInfoResolver.Combine(
        DocumentContext.Default,
        UserContext.Default,
        ProductContext.Default);

    public static readonly JsonSerializerOptions DefaultOptions = new()
    {
        TypeInfoResolver = Resolver,
        WriteIndented = false,
        PropertyNamingPolicy = JsonNamingPolicy.CamelCase
    };
}
```

### 2. Extension Methods for Clean Usage

```csharp
public static class JsonExtensions
{
    public static string ToJson<T>(this T obj, JsonTypeInfo<T> typeInfo)
    {
        return JsonSerializer.Serialize(obj, typeInfo);
    }

    public static T? FromJson<T>(this string json, JsonTypeInfo<T> typeInfo)
    {
        return JsonSerializer.Deserialize<T>(json, typeInfo);
    }
}

// Clean usage
var json = person.ToJson(PersonContext.Default.Person);
var person = json.FromJson(PersonContext.Default.Person);
```

### 3. Conditional Context Loading

```csharp
public static class ContextProvider
{
    public static JsonTypeInfoResolver GetResolver(string environment)
    {
        var contexts = new List<JsonSerializerContext> { BaseContext.Default };

        if (environment == "Production")
        {
            contexts.Add(ProductionContext.Default);
        }
        else
        {
            contexts.Add(DevelopmentContext.Default);
        }

        return JsonTypeInfoResolver.Combine(contexts.ToArray());
    }
}
```

## Troubleshooting Common Issues

### AOT Compilation Errors and Warnings

When using reflection-based JSON serialization in AOT scenarios, you'll encounter these specific errors:

#### IL2026 - RequiresUnreferencedCodeAttribute Warning
```
warning IL2026: Using member 'System.Text.Json.JsonSerializer.Deserialize<TValue>(String, JsonSerializerOptions?)'
which has 'RequiresUnreferencedCodeAttribute' can break functionality when trimming application code.
JSON serialization and deserialization might require types that cannot be statically analyzed.
Use the overload that takes a JsonTypeInfo or JsonSerializerContext, or make sure all of the
required types are preserved.
```

#### IL3050 - RequiresDynamicCodeAttribute Warning
```
warning IL3050: Using member 'System.Text.Json.JsonSerializer.Serialize<TValue>(TValue, JsonSerializerOptions?)'
which has 'RequiresDynamicCodeAttribute' can break functionality when AOT compiling.
JSON serialization and deserialization might require types that cannot be statically analyzed
and might need runtime code generation. Use System.Text.Json source generation for native AOT applications.
```

#### MSBuild/Publish Errors
During `dotnet publish` with AOT enabled, you may see build errors like:
```
error NETSDK1185: Microsoft.DotNet.ILCompiler.targets(243,5): error : ILC: Trim analysis warning IL2026:
Program.Main(String[]): Using member 'System.Text.Json.JsonSerializer.Serialize<TValue>(TValue, JsonSerializerOptions)'
which has 'RequiresUnreferencedCodeAttribute' can break functionality when trimming application code.

error : AOT analysis detected problematic patterns in your application. Use source generation to resolve these issues.
```

#### Runtime Errors in AOT Applications
If you ignore these warnings, your application will fail at runtime with errors like:
```
System.InvalidOperationException: JsonSerializer is not compatible with trimming.
System.NotSupportedException: Serialization and deserialization of 'YourType' instances are not supported.
System.NotSupportedException: This method is not supported when trimming is enabled.
Unhandled exception. System.MissingMethodException: Method not found: constructor on type 'YourType'
```

#### Solutions for AOT Compatibility

```csharp
// ❌ Causes IL2026/IL3050 warnings and runtime failures
JsonSerializer.Serialize<T>(value);
JsonSerializer.Deserialize<T>(json);

// ✅ AOT-compatible with source generation
JsonSerializer.Serialize(value, typeInfo);
JsonSerializer.Deserialize(json, typeInfo);

// ✅ Generic method that works in AOT
public static T DeserializeAot<T>(string json, JsonTypeInfo<T> typeInfo) where T : class
{
    return JsonSerializer.Deserialize(json, typeInfo)!;
}
```

### Missing Type Registration

```csharp
// ❌ Runtime error: Type not registered
var result = JsonSerializer.Serialize(person, PersonContext.Default.Person);

// ✅ Ensure all types are registered
[JsonSerializable(typeof(Person))]
[JsonSerializable(typeof(Address))]  // Don't forget nested types!
public partial class PersonContext : JsonSerializerContext { }
```

### Property Naming Conflicts

```csharp
// ❌ Mixing policies creates confusion
public class MixedNaming
{
    public string FirstName { get; set; }           // Uses context policy
    [JsonPropertyName("last_name")]                 // Manual override
    public string LastName { get; set; }            // Inconsistent naming
}

// ✅ Consistent approach
public class ConsistentNaming
{
    public string FirstName { get; set; }           // "firstName" with CamelCase
    public string LastName { get; set; }            // "lastName" with CamelCase
}
```

## Migration from Newtonsoft.Json and System.Text.Json

### Newtonsoft.Json Migration

Source generation provides superior performance while maintaining familiar patterns:

```csharp
// Old Newtonsoft.Json code
[JsonProperty("first_name")]
public string FirstName { get; set; }

string json = JsonConvert.SerializeObject(person);
Person person = JsonConvert.DeserializeObject<Person>(json);

// New source generation approach - better performance, same result
public string FirstName { get; set; }  // No attributes needed

[JsonSourceGenerationOptions(PropertyNamingPolicy = JsonKnownNamingPolicy.SnakeCaseLower)]
public partial class PersonContext : JsonSerializerContext { }

string json = JsonSerializer.Serialize(person, PersonContext.Default.Person);
Person person = JsonSerializer.Deserialize(json, PersonContext.Default.Person);
```

### System.Text.Json Reflection Migration

Direct replacement with performance improvements:

```csharp
// Old reflection-based System.Text.Json (causes IL2026/IL3050 warnings)
var options = new JsonSerializerOptions
{
    PropertyNamingPolicy = JsonNamingPolicy.CamelCase,
    WriteIndented = true
};
string json = JsonSerializer.Serialize(person, options);  // Runtime reflection
Person person = JsonSerializer.Deserialize<Person>(json, options);  // Runtime reflection

// New source generation - same API, better performance, AOT compatible
[JsonSourceGenerationOptions(
    PropertyNamingPolicy = JsonKnownNamingPolicy.CamelCase,
    WriteIndented = true)]
public partial class PersonContext : JsonSerializerContext { }

string json = JsonSerializer.Serialize(person, PersonContext.Default.Person);  // Compile-time
Person person = JsonSerializer.Deserialize(json, PersonContext.Default.Person);  // Compile-time
```

## Best Practices Summary

1. **Use source generation for AOT compatibility**: Essential for Native AOT applications and trimmed deployments
2. **Leverage naming policies**: Avoid manual `JsonPropertyName` when possible - let source generation handle naming conversion
3. **Design for generics**: Use `JsonTypeInfo<T>` parameters for flexible, reusable code that works in AOT scenarios
4. **Migrate from reflection-based approaches**: Replace System.Text.Json reflection calls and Newtonsoft.Json patterns
5. **Centralize context management**: Create unified resolvers for application-wide consistency
6. **Register all necessary types**: Include collections, nested types, and generic variants for static analysis
7. **Optimize for performance**: Pre-compute options, use UTF-8 operations, and streaming for large data
8. **Test in AOT scenarios**: Validate source generation works in your target deployment with trimming enabled
9. **Keep contexts focused**: Create domain-specific contexts rather than monolithic ones for better dead code elimination