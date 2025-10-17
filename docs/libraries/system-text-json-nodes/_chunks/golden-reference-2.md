# System.Text.Json.Nodes
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
