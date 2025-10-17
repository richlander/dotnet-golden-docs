# System.Text.Json.JsonSerializer
## Using Web Defaults

Apply ASP.NET Core conventions for web APIs.

```csharp
// Web defaults: camelCase, case-insensitive reading
var options = JsonSerializerOptions.Web;

var data = new { UserId = 123, UserName = "alice" };
string json = JsonSerializer.Serialize(data, options);
// {"userId":123,"userName":"alice"}

// Case-insensitive deserialization
string inputJson = """{"userid":123,"username":"alice"}""";
var result = JsonSerializer.Deserialize<ApiResponse>(inputJson, options);
// Matches despite different casing
```

## Ignoring Properties

Control which properties are included in JSON output.

```csharp
using System.Text.Json.Serialization;

public class User
{
    public int Id { get; set; }
    public string Name { get; set; } = string.Empty;
    
    [JsonIgnore]
    public string Password { get; set; } = string.Empty;
    
    public string? Email { get; set; }
    public int? Age { get; set; }
}

var user = new User
{
    Id = 1,
    Name = "Alice",
    Password = "secret123",
    Email = null,
    Age = null
};

// Password is never serialized due to [JsonIgnore]
string json = JsonSerializer.Serialize(user);
// {"Id":1,"Name":"Alice","Email":null,"Age":null}

// Ignore null values
var options = new JsonSerializerOptions
{
    DefaultIgnoreCondition = JsonIgnoreCondition.WhenWritingNull
};
string jsonWithoutNulls = JsonSerializer.Serialize(user, options);
// {"Id":1,"Name":"Alice"}
```

## Custom Property Names

Override property names in JSON output.

```csharp
using System.Text.Json.Serialization;

public class Product
{
    [JsonPropertyName("product_id")]
    public int Id { get; set; }
    
    [JsonPropertyName("product_name")]
    public string Name { get; set; } = string.Empty;
    
    [JsonPropertyName("unit_price")]
    public decimal Price { get; set; }
}

var product = new Product { Id = 1, Name = "Widget", Price = 29.99m };
string json = JsonSerializer.Serialize(product);
// {"product_id":1,"product_name":"Widget","unit_price":29.99}
```
