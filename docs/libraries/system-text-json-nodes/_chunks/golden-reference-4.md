# System.Text.Json.Nodes
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
