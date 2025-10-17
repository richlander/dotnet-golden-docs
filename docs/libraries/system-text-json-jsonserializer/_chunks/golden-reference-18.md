# System.Text.Json.JsonSerializer
## Respecting Nullable Annotations

Enforce nullable reference type annotations during serialization and deserialization.

```csharp
#nullable enable

public class UserProfile
{
    public required int Id { get; set; }
    public required string Name { get; set; }
    public string? OptionalBio { get; set; }
}

var options = new JsonSerializerOptions
{
    RespectNullableAnnotations = true
};

// Valid: null for nullable property
string validJson = """{"Id":1,"Name":"Alice","OptionalBio":null}""";
UserProfile? valid = JsonSerializer.Deserialize<UserProfile>(validJson, options);

// Invalid: null for non-nullable property
string invalidJson = """{"Id":1,"Name":null,"OptionalBio":"Bio"}""";
try
{
    UserProfile? invalid = JsonSerializer.Deserialize<UserProfile>(invalidJson, options);
}
catch (JsonException ex)
{
    Console.WriteLine($"Deserialization failed: {ex.Message}");
    // JSON value cannot be null for non-nullable property 'Name'
}

// Serialization also enforces nullability
var profile = new UserProfile { Id = 1, Name = "Bob", OptionalBio = null };
string serialized = JsonSerializer.Serialize(profile, options);
// {"Id":1,"Name":"Bob","OptionalBio":null}
```

## Required Constructor Parameters

Make constructor parameters non-optional during deserialization.

```csharp
public class Product
{
    public int Id { get; }
    public string Name { get; }
    public decimal Price { get; }
    public string? Description { get; }
    
    [JsonConstructor]
    public Product(int id, string name, decimal price, string? description = null)
    {
        Id = id;
        Name = name;
        Price = price;
        Description = description;
    }
}

// Default: Constructor parameters are optional even without defaults
string json1 = """{"Id":1,"Name":"Widget"}""";
Product? product1 = JsonSerializer.Deserialize<Product>(json1);
// Succeeds: price = 0, description = null

// With flag: Constructor parameters without defaults are required
var options = new JsonSerializerOptions
{
    RespectRequiredConstructorParameters = true
};

try
{
    Product? product2 = JsonSerializer.Deserialize<Product>(json1, options);
}
catch (JsonException ex)
{
    Console.WriteLine("Missing required constructor parameter: price");
}

// Valid when all required parameters present
string json2 = """{"Id":1,"Name":"Widget","Price":29.99}""";
Product? product3 = JsonSerializer.Deserialize<Product>(json2, options);
// Succeeds
```
