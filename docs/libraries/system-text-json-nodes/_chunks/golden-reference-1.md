# System.Text.Json.Nodes
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
