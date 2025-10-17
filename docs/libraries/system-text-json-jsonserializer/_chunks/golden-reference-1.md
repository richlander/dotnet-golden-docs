# System.Text.Json.JsonSerializer
## Quick Start

```csharp
using System.Text.Json;

// Define a type
public record Product(int Id, string Name, decimal Price);

// Serialize: Object → JSON string
var product = new Product(1, "Laptop", 999.99m);
string json = JsonSerializer.Serialize(product);
// {"Id":1,"Name":"Laptop","Price":999.99}

// Deserialize: JSON string → Object
string jsonString = """{"Id":2,"Name":"Mouse","Price":24.99}""";
Product mouse = JsonSerializer.Deserialize<Product>(jsonString)!;

Console.WriteLine($"{mouse.Name}: ${mouse.Price}");
// Mouse: $24.99
```

## Serializing Objects

Convert .NET objects to JSON strings.

```csharp
public class User
{
    public int Id { get; set; }
    public string Name { get; set; } = string.Empty;
    public string Email { get; set; } = string.Empty;
    public bool IsActive { get; set; }
}

var user = new User
{
    Id = 123,
    Name = "Alice",
    Email = "alice@example.com",
    IsActive = true
};

// Serialize to JSON string
string json = JsonSerializer.Serialize(user);
// {"Id":123,"Name":"Alice","Email":"alice@example.com","IsActive":true}

// Serialize with indentation for readability
var options = new JsonSerializerOptions { WriteIndented = true };
string formattedJson = JsonSerializer.Serialize(user, options);
```

## Deserializing Objects

Convert JSON strings to .NET objects.

```csharp
string json = """
{
    "Id": 123,
    "Name": "Alice",
    "Email": "alice@example.com",
    "IsActive": true
}
""";

// Deserialize to strongly-typed object
User? user = JsonSerializer.Deserialize<User>(json);

if (user != null)
{
    Console.WriteLine($"User: {user.Name}, Email: {user.Email}");
}

// Handle null result
User user2 = JsonSerializer.Deserialize<User>(json) 
    ?? throw new InvalidOperationException("Failed to deserialize user");
```
