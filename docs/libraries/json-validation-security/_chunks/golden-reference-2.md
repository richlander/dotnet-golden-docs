# JSON Validation and Security
## Nullable Reference Type Support

Enforce nullability contracts during deserialization:

```csharp
#nullable enable
using System.Text.Json;

var options = new JsonSerializerOptions
{
    RespectNullableAnnotations = true
};

// Violates nullability - Name should not be null
string invalidJson = """
{
    "Name": null,
    "Age": 25
}
""";

try
{
    var person = JsonSerializer.Deserialize<Person>(invalidJson, options);
}
catch (JsonException ex)
{
    Console.WriteLine($"Nullability violation: {ex.Message}");
}

record Person(string Name, int Age);  // Name is non-nullable
```

This works with:
- Non-nullable reference types
- Nullable reference types (`string?`)
- Nullable value types (`int?`)

## Required Properties

Ensure mandatory properties are present in JSON:

```csharp
using System.Text.Json;
using System.Text.Json.Serialization;

var options = new JsonSerializerOptions
{
    RespectRequiredConstructorParameters = true
};

// Missing required "Email" property
string incompleteJson = """
{
    "Name": "Alice"
}
""";

try
{
    var user = JsonSerializer.Deserialize<User>(incompleteJson, options);
}
catch (JsonException ex)
{
    Console.WriteLine($"Missing required property: {ex.Message}");
}

record User(string Name, string Email);  // Both parameters required

// Using required keyword for properties
class UserAccount
{
    public required string Username { get; init; }
    public required string Email { get; init; }
    public string? PhoneNumber { get; init; }  // Optional
}
```

## Combining Validation Features

Use multiple validation features together for comprehensive security:

```csharp
using System.Text.Json;
using System.Text.Json.Serialization;

// Configure comprehensive validation
var secureOptions = new JsonSerializerOptions
{
    AllowDuplicateProperties = false,
    UnmappedMemberHandling = JsonUnmappedMemberHandling.Disallow,
    RespectNullableAnnotations = true,
    RespectRequiredConstructorParameters = true,
    PropertyNameCaseInsensitive = false  // Enforce exact casing
};

[JsonUnmappedMemberHandling(JsonUnmappedMemberHandling.Disallow)]
record SecureApiRequest(
    string RequestId,
    string? OptionalField,
    DateTime Timestamp
);

string json = GetUntrustedJson();

try
{
    var request = JsonSerializer.Deserialize<SecureApiRequest>(json, secureOptions);
    
    // All validation passed - safe to process
    ProcessValidatedRequest(request);
}
catch (JsonException ex)
{
    // Log security event
    LogSecurityViolation(ex);
    throw;
}
```
