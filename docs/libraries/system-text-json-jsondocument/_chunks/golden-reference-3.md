# System.Text.Json.JsonDocument
## Navigating Nested Structures

Access deeply nested properties using chained `GetProperty()` calls.

```csharp
string json = """
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
""";

using JsonDocument doc = JsonDocument.Parse(json);
JsonElement root = doc.RootElement;

// Navigate to nested value
string email = root
    .GetProperty("user")
    .GetProperty("profile")
    .GetProperty("contact")
    .GetProperty("email")
    .GetString()!;

// Safe navigation with TryGetProperty
JsonElement user = root.GetProperty("user");
if (user.TryGetProperty("profile", out JsonElement profile) &&
    profile.TryGetProperty("contact", out JsonElement contact) &&
    contact.TryGetProperty("phone", out JsonElement phone))
{
    string phoneNumber = phone.GetString()!;
}
```

## Checking Value Types

Determine the type of a JSON value at runtime.

```csharp
string json = """
{
    "string": "text",
    "number": 42,
    "decimal": 3.14,
    "boolean": true,
    "null": null,
    "object": {"key": "value"},
    "array": [1, 2, 3]
}
""";

using JsonDocument doc = JsonDocument.Parse(json);
JsonElement root = doc.RootElement;

foreach (JsonProperty property in root.EnumerateObject())
{
    JsonElement value = property.Value;
    
    switch (value.ValueKind)
    {
        case JsonValueKind.String:
            string str = value.GetString()!;
            break;
        case JsonValueKind.Number:
            if (value.TryGetInt32(out int intValue))
            {
                // Integer
            }
            else
            {
                double doubleValue = value.GetDouble();
                // Floating point
            }
            break;
        case JsonValueKind.True:
        case JsonValueKind.False:
            bool boolValue = value.GetBoolean();
            break;
        case JsonValueKind.Null:
            // Handle null
            break;
        case JsonValueKind.Object:
            // Enumerate nested object
            break;
        case JsonValueKind.Array:
            // Enumerate nested array
            break;
    }
}
```

## Processing Arrays of Objects

Work with JSON arrays containing complex objects.

```csharp
string json = """
{
    "products": [
        {"id": 1, "name": "Widget", "price": 29.99},
        {"id": 2, "name": "Gadget", "price": 49.99},
        {"id": 3, "name": "Tool", "price": 19.99}
    ]
}
""";

using JsonDocument doc = JsonDocument.Parse(json);
JsonElement root = doc.RootElement;
JsonElement products = root.GetProperty("products");

// Iterate objects in array
foreach (JsonElement product in products.EnumerateArray())
{
    int id = product.GetProperty("id").GetInt32();
    string name = product.GetProperty("name").GetString()!;
    decimal price = product.GetProperty("price").GetDecimal();
    
    Console.WriteLine($"Product {id}: {name} - ${price}");
}

// Find specific item
JsonElement? widget = products.EnumerateArray()
    .FirstOrDefault(p => p.GetProperty("name").GetString() == "Widget");

if (widget.HasValue)
{
    decimal price = widget.Value.GetProperty("price").GetDecimal();
}

// Filter by criteria
var expensive = products.EnumerateArray()
    .Where(p => p.GetProperty("price").GetDecimal() > 25)
    .Select(p => p.GetProperty("name").GetString())
    .ToList();
```
