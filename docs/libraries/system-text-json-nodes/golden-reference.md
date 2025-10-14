# System.Text.Json.Nodes

## Overview

System.Text.Json.Nodes provides a Document Object Model (DOM) for JSON. The DOM allows navigation, querying, and modification of JSON structures without defining concrete types. This is essential when JSON structure is unknown at compile time, varies between requests, or requires runtime manipulation.

The namespace includes four primary types: `JsonNode` (base class), `JsonObject` (key-value pairs), `JsonArray` (ordered sequences), and `JsonValue` (primitives). These types form a mutable tree structure representing JSON documents in memory. Programs can parse JSON into this structure, navigate using indexers and properties, modify values, and serialize back to JSON text.

System.Text.Json.Nodes fills the gap between strongly-typed deserialization and low-level `Utf8JsonReader`. When types are known at compile time, use `JsonSerializer.Deserialize<T>()`. When JSON structure is completely unknown or highly dynamic, use the nodes API. For read-only access to dynamic JSON, `JsonDocument` offers better performance than `JsonNode`.

Key capabilities:

- Dynamic JSON parsing: Parse JSON without predefined types
- Mutable document model: Modify JSON structure programmatically
- Type-safe value access: Read values with strongly-typed `GetValue<T>()` methods
- JSON construction: Build JSON documents from code without string concatenation
- JSON merging: Combine multiple JSON documents at runtime
- Schema-less querying: Navigate JSON with indexer syntax and property access

The nodes API is common in middleware, configuration mergers, JSON proxies, and applications that aggregate or transform JSON from multiple sources. It provides runtime flexibility that strongly-typed deserialization cannot offer.

| Scenario | Solution | Key Benefit |
|----------|----------|-------------|
| Unknown JSON structure | `JsonNode.Parse()` | No type definitions needed |
| Modifying JSON | `JsonObject`/`JsonArray` mutation | Direct value updates |
| Building JSON from code | `new JsonObject()` + property assignment | Type-safe construction |
| Merging configurations | Parse multiple sources, copy properties | Runtime combination |
| JSON proxies | Parse, modify specific paths, serialize | Middleware flexibility |
| Extracting values | Indexer + `GetValue<T>()` | Type-safe reading |
| Read-only access | Use `JsonDocument` instead | Better performance |
| Known structure | Use `JsonSerializer.Deserialize<T>()` instead | Type safety, performance |

## Quick Start

```csharp
using System.Text.Json.Nodes;

// Parse JSON into mutable DOM
string json = """{"name":"Alice","age":30,"active":true}""";
JsonNode node = JsonNode.Parse(json)!;

// Read values with indexer syntax
string name = node["name"]!.GetValue<string>();
int age = node["age"]!.GetValue<int>();
bool active = node["active"]!.GetValue<bool>();

// Modify values
node["age"] = 31;
node["active"] = false;

// Add new properties
node["lastLogin"] = DateTime.UtcNow.ToString("O");

// Serialize back to JSON
string updatedJson = node.ToJsonString();
```

## Parsing JSON

Parse JSON text into a mutable document object model. The result is a tree structure of nodes representing the JSON document.

```csharp
// Parse JSON into JsonNode
string json = """{"id":1,"name":"Product","price":99.99}""";
JsonNode root = JsonNode.Parse(json)!;

// Parse from stream
await using Stream stream = File.OpenRead("data.json");
JsonNode data = await JsonNode.ParseAsync(stream);

// Parse with options
var parseOptions = new JsonNodeOptions 
{ 
    PropertyNameCaseInsensitive = true 
};
JsonNode node = JsonNode.Parse(json, parseOptions);
```

## Reading Values from JsonObject

Access properties using indexer syntax and extract strongly-typed values with `GetValue<T>()`.

```csharp
JsonNode data = JsonNode.Parse("""
{
    "userId": 123,
    "username": "alice",
    "score": 98.5,
    "verified": true
}
""")!;

// Read primitive values
int userId = data["userId"]!.GetValue<int>();
string username = data["username"]!.GetValue<string>();
double score = data["score"]!.GetValue<double>();
bool verified = data["verified"]!.GetValue<bool>();

// Check if property exists
if (data["optionalField"] is JsonNode optionalNode)
{
    string value = optionalNode.GetValue<string>();
}
```

## Reading Values from JsonArray

Iterate arrays using enumeration or index-based access.

```csharp
JsonNode data = JsonNode.Parse("""
{
    "items": [10, 20, 30, 40, 50]
}
""")!;

JsonArray items = data["items"]!.AsArray();

// Index-based access
int firstItem = items[0]!.GetValue<int>();

// Enumerate array
foreach (JsonNode? item in items)
{
    int value = item!.GetValue<int>();
    Console.WriteLine(value);
}

// LINQ queries
var filtered = items
    .Select(n => n!.GetValue<int>())
    .Where(v => v > 25)
    .ToList();
```

## Modifying Existing JSON

Change property values, add new properties, or remove existing ones.

```csharp
JsonNode config = JsonNode.Parse("""
{
    "environment": "development",
    "port": 8080,
    "debug": true
}
""")!;

// Modify existing values
config["environment"] = "production";
config["port"] = 443;
config["debug"] = false;

// Add new properties
config["timestamp"] = DateTime.UtcNow.ToString("O");
config["version"] = "1.2.3";

// Remove properties
JsonObject obj = config.AsObject();
obj.Remove("debug");

// Serialize back
string updatedJson = config.ToJsonString(new JsonSerializerOptions 
{ 
    WriteIndented = true 
});
```

## Building JSON from Code

Construct JSON documents programmatically without string concatenation or type definitions.

```csharp
// Create JSON object
var user = new JsonObject
{
    ["id"] = 42,
    ["username"] = "bob",
    ["email"] = "bob@example.com",
    ["active"] = true
};

// Create nested objects
var product = new JsonObject
{
    ["productId"] = 100,
    ["name"] = "Widget",
    ["price"] = 29.99,
    ["metadata"] = new JsonObject
    {
        ["category"] = "electronics",
        ["inStock"] = true,
        ["tags"] = new JsonArray("new", "featured", "sale")
    }
};

// Create arrays
var numbers = new JsonArray(1, 2, 3, 4, 5);
var mixed = new JsonArray(
    "text",
    42,
    true,
    new JsonObject { ["nested"] = "value" }
);

// Serialize to JSON
string json = product.ToJsonString();
```

## Navigating Nested Structures

Access deeply nested properties using chained indexers.

```csharp
JsonNode data = JsonNode.Parse("""
{
    "user": {
        "profile": {
            "name": "Alice",
            "contact": {
                "email": "alice@example.com",
                "phone": "555-1234"
            }
        }
    }
}
""")!;

// Navigate to nested value
string email = data["user"]!["profile"]!["contact"]!["email"]!.GetValue<string>();

// Safe navigation with null checks
if (data["user"]?["profile"]?["contact"]?["phone"] is JsonNode phoneNode)
{
    string phone = phoneNode.GetValue<string>();
}

// Access array elements in nested structure
JsonNode orders = JsonNode.Parse("""
{
    "customer": {
        "orders": [
            {"id": 1, "total": 99.99},
            {"id": 2, "total": 149.99}
        ]
    }
}
""")!;

JsonArray orderArray = orders["customer"]!["orders"]!.AsArray();
decimal firstOrderTotal = orderArray[0]!["total"]!.GetValue<decimal>();
```

## Merging JSON Documents

Combine multiple JSON documents at runtime by copying properties between objects.

```csharp
// Base configuration
JsonNode baseConfig = JsonNode.Parse("""
{
    "host": "localhost",
    "port": 8080,
    "debug": false
}
""")!;

// Override configuration
JsonNode overrideConfig = JsonNode.Parse("""
{
    "port": 9000,
    "debug": true,
    "newSetting": "value"
}
""")!;

// Merge overrides into base
JsonObject baseObject = baseConfig.AsObject();
JsonObject overrideObject = overrideConfig.AsObject();

foreach (var property in overrideObject)
{
    baseObject[property.Key] = property.Value?.DeepClone();
}

// Result contains merged configuration
string merged = baseConfig.ToJsonString();
// {"host":"localhost","port":9000,"debug":true,"newSetting":"value"}
```

## Cloning JSON Nodes

Create deep copies of JSON structures for independent modification.

```csharp
JsonNode original = JsonNode.Parse("""
{
    "data": {
        "values": [1, 2, 3],
        "name": "original"
    }
}
""")!;

// Deep clone
JsonNode clone = original.DeepClone();

// Modify clone without affecting original
clone["data"]!["name"] = "modified";

// Original unchanged
string originalName = original["data"]!["name"]!.GetValue<string>();
// "original"

string clonedName = clone["data"]!["name"]!.GetValue<string>();
// "modified"
```

## Type Checking and Conversion

Determine node types and convert between representations.

```csharp
JsonNode data = JsonNode.Parse("""
{
    "object": {"key": "value"},
    "array": [1, 2, 3],
    "string": "text",
    "number": 42,
    "boolean": true,
    "null": null
}
""")!;

// Check node types
JsonNode objectNode = data["object"]!;
if (objectNode is JsonObject jsonObject)
{
    // Work with JsonObject
    string value = jsonObject["key"]!.GetValue<string>();
}

JsonNode arrayNode = data["array"]!;
if (arrayNode is JsonArray jsonArray)
{
    // Work with JsonArray
    int count = jsonArray.Count;
}

// AsObject() and AsArray() throw if wrong type
JsonObject obj = data["object"]!.AsObject();
JsonArray arr = data["array"]!.AsArray();

// JsonValue for primitives
JsonNode numberNode = data["number"]!;
if (numberNode is JsonValue jsonValue)
{
    int number = jsonValue.GetValue<int>();
}
```

## Converting to Strongly-Typed Objects

Deserialize portions of dynamic JSON into strongly-typed objects.

```csharp
public record UserProfile(string Name, string Email, int Age);

JsonNode data = JsonNode.Parse("""
{
    "user": {
        "name": "Alice",
        "email": "alice@example.com",
        "age": 30
    },
    "timestamp": "2024-01-15T10:30:00Z",
    "metadata": {"source": "api"}
}
""")!;

// Extract and deserialize specific portion
JsonNode userNode = data["user"]!;
UserProfile profile = userNode.Deserialize<UserProfile>()!;

// Use strongly-typed object
Console.WriteLine($"{profile.Name} is {profile.Age} years old");
```

## Handling Arrays of Objects

Work with arrays containing complex objects.

```csharp
JsonNode data = JsonNode.Parse("""
{
    "products": [
        {"id": 1, "name": "Widget", "price": 29.99},
        {"id": 2, "name": "Gadget", "price": 49.99},
        {"id": 3, "name": "Tool", "price": 19.99}
    ]
}
""")!;

JsonArray products = data["products"]!.AsArray();

// Iterate objects in array
foreach (JsonNode? item in products)
{
    int id = item!["id"]!.GetValue<int>();
    string name = item["name"]!.GetValue<string>();
    decimal price = item["price"]!.GetValue<decimal>();
    
    Console.WriteLine($"Product {id}: {name} - ${price}");
}

// Filter and transform
var expensiveProducts = products
    .Select(p => new
    {
        Id = p!["id"]!.GetValue<int>(),
        Name = p["name"]!.GetValue<string>(),
        Price = p["price"]!.GetValue<decimal>()
    })
    .Where(p => p.Price > 25)
    .ToList();

// Modify objects in array
foreach (JsonNode? product in products)
{
    decimal currentPrice = product!["price"]!.GetValue<decimal>();
    product["price"] = currentPrice * 1.1m; // 10% increase
}
```

## Using with Configuration Merging

Middleware and configuration systems often merge JSON from multiple sources.

```csharp
// Load base configuration
JsonNode config = JsonNode.Parse(await File.ReadAllTextAsync("appsettings.json"))!;

// Load environment-specific overrides
string environment = Environment.GetEnvironmentVariable("ASPNETCORE_ENVIRONMENT") 
    ?? "Production";
string environmentFile = $"appsettings.{environment}.json";

if (File.Exists(environmentFile))
{
    JsonNode envConfig = JsonNode.Parse(await File.ReadAllTextAsync(environmentFile))!;
    
    // Merge environment overrides
    JsonObject baseObj = config.AsObject();
    JsonObject envObj = envConfig.AsObject();
    
    foreach (var property in envObj)
    {
        baseObj[property.Key] = property.Value?.DeepClone();
    }
}

// Load user secrets or environment variables
JsonNode secretsConfig = LoadUserSecrets();
JsonObject configObj = config.AsObject();
JsonObject secretsObj = secretsConfig.AsObject();

foreach (var property in secretsObj)
{
    configObj[property.Key] = property.Value?.DeepClone();
}

// Final configuration ready to use
string connectionString = config["Database"]!["ConnectionString"]!.GetValue<string>();
```

## Using with JSON Proxy Middleware

Middleware that forwards JSON requests may need to inspect or modify specific fields.

```csharp
public class JsonProxyMiddleware
{
    private readonly RequestDelegate _next;

    public JsonProxyMiddleware(RequestDelegate next)
    {
        _next = next;
    }

    public async Task InvokeAsync(HttpContext context)
    {
        if (context.Request.ContentType?.Contains("application/json") == true)
        {
            // Read request body
            using var reader = new StreamReader(context.Request.Body);
            string body = await reader.ReadToEndAsync();
            
            // Parse and modify
            JsonNode requestData = JsonNode.Parse(body)!;
            
            // Add tracking fields
            requestData["requestId"] = Guid.NewGuid().ToString();
            requestData["timestamp"] = DateTime.UtcNow.ToString("O");
            requestData["source"] = context.Request.Host.Value;
            
            // Write modified body to new stream
            string modifiedBody = requestData.ToJsonString();
            var memoryStream = new MemoryStream(Encoding.UTF8.GetBytes(modifiedBody));
            context.Request.Body = memoryStream;
            context.Request.ContentLength = memoryStream.Length;
        }
        
        await _next(context);
    }
}
```

## Using with API Response Transformation

Transform JSON responses without defining types for every possible schema.

```csharp
public async Task<JsonNode> TransformApiResponse(HttpClient client, string url)
{
    // Get JSON from external API
    string responseJson = await client.GetStringAsync(url);
    JsonNode data = JsonNode.Parse(responseJson)!;
    
    // Transform to internal schema
    var transformed = new JsonObject
    {
        ["id"] = data["external_id"],
        ["name"] = data["full_name"],
        ["email"] = data["contact"]!["email"],
        ["registeredAt"] = data["registration_date"],
        ["metadata"] = new JsonObject
        {
            ["source"] = "external-api",
            ["transformedAt"] = DateTime.UtcNow.ToString("O"),
            ["originalId"] = data["external_id"]
        }
    };
    
    // Conditionally include fields
    if (data["premium_status"]?.GetValue<bool>() == true)
    {
        transformed["premiumFeatures"] = data["features"];
    }
    
    return transformed;
}
```

## Choosing Between JsonNode and JsonDocument

`JsonNode` provides mutable access but allocates more memory. `JsonDocument` offers read-only access with better performance.

```csharp
// Use JsonNode when:
// - Modifying JSON structure
// - Building JSON programmatically
// - Merging multiple documents
JsonNode mutableData = JsonNode.Parse(json)!;
mutableData["newField"] = "value";
string modified = mutableData.ToJsonString();

// Use JsonDocument when:
// - Read-only access
// - Performance-critical paths
// - Large documents
using JsonDocument readOnlyData = JsonDocument.Parse(json);
JsonElement root = readOnlyData.RootElement;
string value = root.GetProperty("field").GetString()!;

// Use JsonSerializer.Deserialize<T> when:
// - Structure known at compile time
// - Type safety required
// - Source generation available
public record Data(string Field, int Value);
Data stronglyTyped = JsonSerializer.Deserialize<Data>(json)!;
```

## Considerations

### Performance vs. Flexibility

`JsonNode` provides runtime flexibility at the cost of performance. Strongly-typed deserialization with `JsonSerializer.Deserialize<T>()` is significantly faster. Use `JsonNode` only when JSON structure is truly unknown at compile time or requires runtime modification.

For read-only scenarios, `JsonDocument` offers better performance than `JsonNode` because it provides a read-only view with minimal allocation. Choose `JsonNode` when mutation is required.

### Memory Allocation

Each node in the tree allocates memory. Large JSON documents parsed into `JsonNode` consume more memory than streaming parsers like `Utf8JsonReader` or deserialization into strongly-typed objects. Consider memory constraints when working with large documents.

### Null Handling

Indexer access returns `JsonNode?` which may be null. Use null-forgiving operator `!` when certain property exists, or use null-conditional operators for safe navigation:

```csharp
// Assumes property exists
string name = node["name"]!.GetValue<string>();

// Safe navigation
string? name = node["name"]?.GetValue<string>();

// With fallback
string name = node["name"]?.GetValue<string>() ?? "default";
```

### Type Safety

`JsonNode` sacrifices compile-time type safety for runtime flexibility. Property names are strings and types are resolved at runtime. Typos in property names or incorrect type assumptions cause runtime exceptions rather than compile errors. Prefer strongly-typed models when structure is known.

## Related Concepts

**Used by System.Text.Json.Nodes:**

- `JsonSerializer` (serialization and deserialization)
- `JsonElement` (underlying value representation)

**Uses System.Text.Json.Nodes:**

- Configuration mergers (combining appsettings files)
- JSON proxy middleware (forwarding with modifications)
- API response transformers (schema conversion)
- Dynamic JSON builders (programmatic construction)

**Alternative to System.Text.Json.Nodes:**

- `JsonDocument` (read-only DOM with better performance)
- `JsonSerializer.Deserialize<T>()` (strongly-typed with type safety)
- `Utf8JsonReader` (forward-only streaming for lowest allocation)
