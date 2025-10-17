# JSON Validation and Security
## Strict JSON Serialization Options

The `JsonSerializerOptions.Strict` preset enables secure-by-default deserialization:

```csharp
using System.Text.Json;

// Use strict options for secure deserialization
var options = JsonSerializerOptions.Strict;

string json = """
{
    "Name": "Alice",
    "Age": 30
}
""";

try
{
    var person = JsonSerializer.Deserialize<Person>(json, options);
    Console.WriteLine($"{person.Name}, {person.Age}");
}
catch (JsonException ex)
{
    // Strict validation detected an issue
    Console.WriteLine($"Validation failed: {ex.Message}");
}

record Person(string Name, int Age);
```

Strict options include:
- Disallows unmapped JSON properties
- Prevents duplicate properties
- Preserves case-sensitive property matching
- Respects nullable reference type annotations
- Respects required constructor parameters

## Preventing Duplicate Properties

Duplicate properties in JSON can lead to ambiguity and security vulnerabilities:

```csharp
using System.Text.Json;

// Malicious JSON with duplicate "Amount" property
string maliciousJson = """
{
    "Amount": 10.00,
    "Amount": 999999.99
}
""";

// Default behavior - last value wins (dangerous!)
var defaultOptions = new JsonSerializerOptions();
var result1 = JsonSerializer.Deserialize<Payment>(maliciousJson, defaultOptions);
Console.WriteLine(result1.Amount);  // 999999.99 - unexpected!

// Secure behavior - reject duplicates
var secureOptions = new JsonSerializerOptions 
{ 
    AllowDuplicateProperties = false 
};

try
{
    var result2 = JsonSerializer.Deserialize<Payment>(maliciousJson, secureOptions);
}
catch (JsonException ex)
{
    Console.WriteLine($"Duplicate property detected: {ex.Message}");
}

record Payment(decimal Amount);
```

This protection works with:
- Object deserialization
- `JsonDocument` parsing
- `JsonObject` (System.Text.Json.Nodes)
- Dictionary deserialization

## Handling Unmapped Properties

Control how the deserializer handles properties that don't exist in your type:

```csharp
using System.Text.Json;
using System.Text.Json.Serialization;

string json = """
{
    "Name": "Product A",
    "Price": 29.99,
    "UnknownField": "suspicious data",
    "AnotherUnknown": 123
}
""";

// Disallow unmapped properties
var strictOptions = new JsonSerializerOptions
{
    UnmappedMemberHandling = JsonUnmappedMemberHandling.Disallow
};

try
{
    var product = JsonSerializer.Deserialize<Product>(json, strictOptions);
}
catch (JsonException ex)
{
    Console.WriteLine($"Unmapped properties found: {ex.Message}");
    // Exception details which properties were unexpected
}

record Product(string Name, decimal Price);
```

You can also apply this per-type using attributes:

```csharp
[JsonUnmappedMemberHandling(JsonUnmappedMemberHandling.Disallow)]
record StrictProduct(string Name, decimal Price);

// Unmapped members not allowed for StrictProduct
string json = """{ "Name": "Test", "Price": 10, "Extra": "field" }""";
JsonSerializer.Deserialize<StrictProduct>(json);  // Throws JsonException
```
