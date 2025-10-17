# System.Text.Json - What's New in .NET 10
## Strict JSON Serialization Options

`JsonSerializerOptions.Strict` provides a secure-by-default configuration preset:

```csharp
using System.Text.Json;

// Use strict options for secure deserialization
var options = JsonSerializerOptions.Strict;

string json = """{ "Name": "Alice", "Age": 30 }""";
var person = JsonSerializer.Deserialize<Person>(json, options);

record Person(string Name, int Age);
```

The strict preset includes:

- Disallows duplicate JSON properties
- Disallows unmapped members (properties not in your type)
- Case-sensitive property matching
- Respects nullable reference type annotations
- Respects required constructor parameters

This is equivalent to:

```csharp
var manualOptions = new JsonSerializerOptions
{
    AllowDuplicateProperties = false,
    UnmappedMemberHandling = JsonUnmappedMemberHandling.Disallow,
    PropertyNameCaseInsensitive = false,
    RespectNullableAnnotations = true,
    RespectRequiredConstructorParameters = true
};
```

Use strict options when deserializing untrusted JSON from external sources.

## Duplicate Property Detection

The `AllowDuplicateProperties` option prevents ambiguity and potential security issues:

```csharp
using System.Text.Json;

string maliciousJson = """
{
    "Amount": 10.00,
    "Amount": 999999.99
}
""";

// Reject duplicate properties
var options = new JsonSerializerOptions 
{ 
    AllowDuplicateProperties = false 
};

try
{
    var payment = JsonSerializer.Deserialize<Payment>(maliciousJson, options);
}
catch (JsonException ex)
{
    Console.WriteLine($"Duplicate property detected: {ex.Message}");
}

record Payment(decimal Amount);
```

Without this protection, the last value wins, which can lead to security vulnerabilities. The default behavior allows duplicates for backward compatibility, but new applications should set this to `false`.

This works across all JSON types:

- Object deserialization
- `JsonDocument` parsing
- `JsonObject` from System.Text.Json.Nodes
- Dictionary deserialization
