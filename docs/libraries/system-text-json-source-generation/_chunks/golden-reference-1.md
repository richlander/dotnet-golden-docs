# System.Text.Json Source Generation
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
