# System.Text.Json.JsonDocument
## Checking Property Existence

Validate that properties exist before attempting to read them.

```csharp
using JsonDocument doc = JsonDocument.Parse(json);
JsonElement root = doc.RootElement;

// Try pattern - safest approach
if (root.TryGetProperty("email", out JsonElement emailElement))
{
    string email = emailElement.GetString()!;
}
else
{
    // Property doesn't exist
}

// Check multiple properties
bool hasRequired = root.TryGetProperty("id", out _) 
    && root.TryGetProperty("name", out _);

if (!hasRequired)
{
    throw new InvalidOperationException("Missing required fields");
}
```

## Enumerating Object Properties

Iterate all properties in a JSON object dynamically.

```csharp
string json = """
{
    "id": 1,
    "name": "Product",
    "price": 99.99,
    "inStock": true
}
""";

using JsonDocument doc = JsonDocument.Parse(json);
JsonElement root = doc.RootElement;

// Enumerate all properties
foreach (JsonProperty property in root.EnumerateObject())
{
    string propertyName = property.Name;
    JsonElement value = property.Value;
    
    Console.WriteLine($"{propertyName}: {value.GetRawText()}");
}

// Filter properties by type
var numberProperties = root.EnumerateObject()
    .Where(p => p.Value.ValueKind == JsonValueKind.Number)
    .Select(p => p.Name)
    .ToList();

// Build dictionary from JSON object
Dictionary<string, string> dict = root.EnumerateObject()
    .ToDictionary(
        p => p.Name, 
        p => p.Value.GetRawText());
```

## Iterating JSON Arrays

Process JSON arrays element by element.

```csharp
string json = """
{
    "items": [10, 20, 30, 40, 50]
}
""";

using JsonDocument doc = JsonDocument.Parse(json);
JsonElement root = doc.RootElement;
JsonElement items = root.GetProperty("items");

// Enumerate array elements
foreach (JsonElement item in items.EnumerateArray())
{
    int value = item.GetInt32();
    Console.WriteLine(value);
}

// Get array length
int length = items.GetArrayLength();

// Index-based access (requires enumeration)
int firstItem = items.EnumerateArray().First().GetInt32();

// LINQ queries
var filtered = items.EnumerateArray()
    .Select(e => e.GetInt32())
    .Where(v => v > 25)
    .ToList();

// Sum array values
int sum = items.EnumerateArray()
    .Select(e => e.GetInt32())
    .Sum();
```
