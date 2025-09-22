# System.Text.Json - Golden Reference

## Overview

System.Text.Json is a high-performance JSON serialization library that's built into .NET Core 3.0+ and available as a NuGet package for earlier frameworks. It prioritizes performance and low memory allocation over extensive features, making it ideal for high-throughput applications and scenarios where memory efficiency matters.

Key advantages include:

- Performance: 1.3-5x faster than Newtonsoft.Json in most scenarios
- Memory efficiency: Lower allocation overhead with UTF-8 optimization
- Native AOT compatibility: Works with trimmed and AOT-compiled applications
- Security: Built-in protection against common JSON vulnerabilities
- Source generation: Compile-time metadata generation for even better performance

The library provides three main approaches:

1. Reflection-based: Default runtime serialization using reflection
2. Source generation: Compile-time code generation for optimal performance
3. DOM manipulation: In-memory document object model for flexible JSON processing

## Essential Syntax & Examples

### Basic Serialization/Deserialization

```csharp
// Serialize object to JSON string
string json = JsonSerializer.Serialize(weatherForecast);

// Deserialize JSON string to object
WeatherForecast forecast = JsonSerializer.Deserialize<WeatherForecast>(json);

// Async file operations
await JsonSerializer.SerializeAsync(fileStream, weatherForecast);
WeatherForecast forecast = await JsonSerializer.DeserializeAsync<WeatherForecast>(fileStream);
```

### Source Generation (Recommended for Performance)

```csharp
[JsonSerializable(typeof(WeatherForecast))]
internal partial class SourceGenerationContext : JsonSerializerContext { }

// Use with source generation
string json = JsonSerializer.Serialize(weatherForecast, SourceGenerationContext.Default.WeatherForecast);
WeatherForecast forecast = JsonSerializer.Deserialize(json, SourceGenerationContext.Default.WeatherForecast);
```

### Configuration Options

```csharp
var options = new JsonSerializerOptions
{
    PropertyNamingPolicy = JsonNamingPolicy.CamelCase,
    WriteIndented = true,
    DefaultIgnoreCondition = JsonIgnoreCondition.WhenWritingNull
};

string json = JsonSerializer.Serialize(obj, options);
```

### .NET 10 New Features

```csharp
// Strict serialization options (new in .NET 10)
var strictOptions = JsonSerializerOptions.Strict;

// Disallow duplicate properties (new in .NET 10)
var options = new JsonSerializerOptions
{
    AllowDuplicateProperties = false
};

// PipeReader support (new in .NET 10)
MyObject obj = await JsonSerializer.DeserializeAsync<MyObject>(pipeReader);
```

## Relationships & Integration

System.Text.Json integrates seamlessly with:

- ASP.NET Core: Default JSON serializer for web APIs
- HttpClient: Extension methods for HTTP JSON operations
- Source generators: Compile-time performance optimization
- Native AOT: Full compatibility with ahead-of-time compilation

Migration from Newtonsoft.Json typically requires:

- Switching to System.Text.Json namespace
- Updating attribute names (JsonPropertyName vs JsonProperty)
- Adjusting serialization behavior for edge cases

## Common Scenarios

### High-Performance API Serialization

Use source generation for APIs with predictable object structures:

```csharp
[JsonSerializable(typeof(ApiResponse))]
[JsonSerializable(typeof(List<User>))]
internal partial class ApiContext : JsonSerializerContext { }

// In startup/DI configuration
services.ConfigureHttpJsonOptions(options =>
{
    options.SerializerOptions.TypeInfoResolver = ApiContext.Default;
});
```

### Configuration File Processing

For configuration files requiring strict validation:

```csharp
var options = JsonSerializerOptions.Strict; // .NET 10+
var config = JsonSerializer.Deserialize<AppConfig>(configJson, options);
```

### Stream Processing for Large Files

```csharp
await using var stream = File.OpenRead("large-data.json");
var data = JsonSerializer.DeserializeAsyncEnumerable<DataItem>(stream);

await foreach (var item in data)
{
    ProcessItem(item);
}
```

## Gotchas & Limitations

### Critical Differences from Newtonsoft.Json

- No support for ISerializable: Must use JsonConverter instead
- Constructor behavior: Requires parameterless constructor or JsonConstructor attribute
- Date handling: Different default DateTime serialization format
- Polymorphism: Requires explicit type discriminators

### Performance Considerations

- Source generation: Always prefer for known types in performance-critical code
- UTF-8 operations: Use SerializeToUtf8Bytes/DeserializeFromUtf8Bytes for best performance
- Options reuse: Reuse JsonSerializerOptions instances to avoid overhead
- Large objects: Consider streaming APIs for multi-megabyte JSON

### Security Limitations

- Depth limits: Default maximum depth of 64 levels
- Memory limits: No built-in memory consumption limits
- Type resolution: Source generation prevents unexpected type loading

## See Also

- Performance optimization: Source generation modes, UTF-8 operations
- ASP.NET Core integration: Web API configuration, HttpClient extensions
- Migration guides: Newtonsoft.Json to System.Text.Json conversion
- Advanced scenarios: Custom converters, polymorphic serialization
