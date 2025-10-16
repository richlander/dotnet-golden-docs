# System.Text.Json
## Source Generation
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
