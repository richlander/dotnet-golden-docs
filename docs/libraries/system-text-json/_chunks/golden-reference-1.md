# System.Text.Json
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
