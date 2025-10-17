# System.Text.Json.JsonSerializer
## Deserializing to Object

Deserialize JSON when type is unknown at compile time.

```csharp
string json = """
{
    "string": "text",
    "number": 42,
    "boolean": true,
    "null": null,
    "array": [1, 2, 3],
    "object": {"nested": "value"}
}
""";

// Deserialize to object? (uses JsonElement internally)
object? result = JsonSerializer.Deserialize<object>(json);

// Result is JsonElement
if (result is JsonElement element)
{
    string stringValue = element.GetProperty("string").GetString()!;
    int numberValue = element.GetProperty("number").GetInt32();
}
```

## Handling Duplicate Property Names

Control behavior when JSON contains duplicate properties.

```csharp
string json = """
{
    "id": 1,
    "name": "First",
    "name": "Second"
}
""";

// Default: Last value wins
User? user1 = JsonSerializer.Deserialize<User>(json);
// user1.Name == "Second"

// Strict: Reject duplicates
var strictOptions = new JsonSerializerOptions
{
    AllowDuplicateProperties = false
};

// JsonException: Duplicate property 'name'
// User? user2 = JsonSerializer.Deserialize<User>(json, strictOptions);
```

## Setting Maximum Depth

Prevent stack overflow from deeply nested JSON.

```csharp
var options = new JsonSerializerOptions
{
    MaxDepth = 32  // Default is 64
};

// Valid: Depth within limit
string validJson = """{"a":{"b":{"c":"value"}}}""";
object? valid = JsonSerializer.Deserialize<object>(validJson, options);

// Invalid: Exceeds maximum depth
string tooDeep = new string('{', 50) + "\"value\"" + new string('}', 50);
// JsonException: Maximum depth exceeded
```

## Reusing JsonSerializerOptions

Create and reuse options for better performance.

```csharp
public static class JsonDefaults
{
    public static readonly JsonSerializerOptions Web = new()
    {
        PropertyNamingPolicy = JsonNamingPolicy.CamelCase,
        WriteIndented = false,
        DefaultIgnoreCondition = JsonIgnoreCondition.WhenWritingNull
    };
    
    public static readonly JsonSerializerOptions Indented = new()
    {
        WriteIndented = true
    };
}

// Reuse across operations
string json1 = JsonSerializer.Serialize(user, JsonDefaults.Web);
string json2 = JsonSerializer.Serialize(product, JsonDefaults.Web);

// Don't create new options per operation
// This is inefficient:
// string bad = JsonSerializer.Serialize(user, new JsonSerializerOptions { WriteIndented = true });
```
