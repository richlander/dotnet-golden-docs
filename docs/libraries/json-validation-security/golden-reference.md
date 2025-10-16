# JSON Validation and Security

## Overview

JSON validation and security features in `System.Text.Json` help ensure that deserialized data is correct, complete, and safe. These features protect against common security vulnerabilities like duplicate property attacks, enforce data contracts through strict validation, and ensure type safety with nullable reference types and required properties. By combining these capabilities, you can deserialize JSON with confidence that the data meets your application's requirements.

Key validation and security capabilities include:

- **Strict serialization options**: Preset configuration that enforces best practices for secure deserialization
- **Duplicate property detection**: Prevent ambiguity and potential security issues from duplicate JSON properties
- **Unmapped member handling**: Control what happens when JSON contains properties not defined in your types
- **Nullable reference type support**: Enforce nullability contracts during deserialization
- **Required property validation**: Ensure mandatory properties are present in JSON payloads
- **Type safety**: Validate that JSON data matches expected C# type contracts

These features are particularly valuable when:

1. Deserializing untrusted JSON from external sources (APIs, user input, files)
2. Enforcing strict data contracts in microservices or API boundaries
3. Preventing security vulnerabilities from malformed or malicious JSON
4. Ensuring data integrity in critical business logic

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

## Strict Options vs Custom Configuration

`JsonSerializerOptions.Strict` provides a secure baseline:

```csharp
// Strict preset - secure defaults
var strictOptions = JsonSerializerOptions.Strict;

// Equivalent to manually configuring:
var manualOptions = new JsonSerializerOptions
{
    AllowDuplicateProperties = false,
    UnmappedMemberHandling = JsonUnmappedMemberHandling.Disallow,
    PropertyNameCaseInsensitive = false,
    RespectNullableAnnotations = true,
    RespectRequiredConstructorParameters = true
};

// Use strict as a starting point, then customize
var customStrictOptions = new JsonSerializerOptions(JsonSerializerOptions.Strict)
{
    PropertyNamingPolicy = JsonNamingPolicy.CamelCase  // Add custom configuration
};
```

## Relationships & Integration

JSON validation integrates with other `System.Text.Json` features:

- **Source generation**: Validation options work with source-generated serializers
- **`JsonDocument`**: Duplicate property detection works during document parsing
- **`JsonObject`**: Unmapped member handling applies to JSON nodes
- **ASP.NET Core**: Validation options can be configured globally for API endpoints
- **Attributes**: Per-type configuration via `[JsonUnmappedMemberHandling]`

Integration with ASP.NET Core:

```csharp
// Configure validation globally in Program.cs
builder.Services.ConfigureHttpJsonOptions(options =>
{
    options.SerializerOptions.AllowDuplicateProperties = false;
    options.SerializerOptions.UnmappedMemberHandling = 
        JsonUnmappedMemberHandling.Disallow;
});

// All API endpoints now use these validation rules
app.MapPost("/api/payment", (Payment payment) =>
{
    // Payment was validated during deserialization
    return ProcessPayment(payment);
});
```

## API Security Best Practices

Secure API deserialization patterns:

```csharp
using System.Text.Json;
using Microsoft.AspNetCore.Mvc;

public class SecureApiController : ControllerBase
{
    private static readonly JsonSerializerOptions s_secureOptions = new()
    {
        AllowDuplicateProperties = false,
        UnmappedMemberHandling = JsonUnmappedMemberHandling.Disallow,
        RespectNullableAnnotations = true
    };

    [HttpPost("process")]
    public IActionResult ProcessData([FromBody] JsonElement element)
    {
        try
        {
            // Deserialize with strict validation
            var data = element.Deserialize<RequestData>(s_secureOptions);
            
            if (data == null)
            {
                return BadRequest("Invalid request data");
            }

            // Additional business validation
            if (!IsValidBusinessData(data))
            {
                return BadRequest("Business validation failed");
            }

            return Ok(ProcessValidatedData(data));
        }
        catch (JsonException ex)
        {
            // Log security event
            _logger.LogWarning("JSON validation failed: {Message}", ex.Message);
            return BadRequest($"Invalid JSON: {ex.Message}");
        }
    }
}

record RequestData(string Id, decimal Amount, DateTime Timestamp);
```

## Detecting and Logging Security Issues

Monitor for potential security issues:

```csharp
using System.Text.Json;
using Microsoft.Extensions.Logging;

public class SecureJsonDeserializer
{
    private readonly ILogger _logger;
    private static readonly JsonSerializerOptions s_options = new()
    {
        AllowDuplicateProperties = false,
        UnmappedMemberHandling = JsonUnmappedMemberHandling.Disallow
    };

    public T? DeserializeSecure<T>(string json)
    {
        try
        {
            return JsonSerializer.Deserialize<T>(json, s_options);
        }
        catch (JsonException ex) when (ex.Message.Contains("duplicate", 
            StringComparison.OrdinalIgnoreCase))
        {
            _logger.LogWarning(
                "Duplicate property attack detected: {Message}", 
                ex.Message);
            throw;
        }
        catch (JsonException ex) when (ex.Message.Contains("unmapped", 
            StringComparison.OrdinalIgnoreCase))
        {
            _logger.LogWarning(
                "Unmapped property detected (possible probe): {Message}", 
                ex.Message);
            throw;
        }
    }
}
```

## Performance Characteristics

Validation features have minimal performance impact:

- **Duplicate detection**: Small overhead during parsing (property name comparison)
- **Unmapped member handling**: Negligible overhead (occurs during normal deserialization)
- **Nullable validation**: No additional runtime overhead
- **Required property validation**: Minimal overhead (parameter checking)

The security benefits far outweigh the minor performance cost in most scenarios.

## Best Practices

1. **Use `JsonSerializerOptions.Strict` for untrusted input**: Default to strict validation for external data
2. **Configure validation globally in ASP.NET Core**: Apply consistent rules across all endpoints
3. **Log validation failures**: Monitor for potential attacks or data quality issues
4. **Combine with business validation**: JSON validation is structural; add domain-specific validation
5. **Use required and nullable annotations**: Express contracts clearly in your types
6. **Test with malicious input**: Verify your validation catches common attack patterns
7. **Document validation requirements**: Make it clear what JSON format is expected

## Migration & Compatibility

### Adopting Strict Validation

Migrating to strict validation may reveal existing issues:

```csharp
// Before: Permissive deserialization
var oldOptions = new JsonSerializerOptions();
var data = JsonSerializer.Deserialize<MyType>(json, oldOptions);

// After: Strict validation
var newOptions = JsonSerializerOptions.Strict;

try
{
    var data = JsonSerializer.Deserialize<MyType>(json, newOptions);
}
catch (JsonException ex)
{
    // May throw if JSON previously contained:
    // - Duplicate properties
    // - Unmapped fields
    // - Null values for non-nullable properties
    // - Missing required properties
}
```

### Gradual Adoption

Enable features incrementally:

```csharp
// Step 1: Start with duplicate detection
var options = new JsonSerializerOptions
{
    AllowDuplicateProperties = false
};

// Step 2: Add unmapped member detection
options.UnmappedMemberHandling = JsonUnmappedMemberHandling.Disallow;

// Step 3: Enable nullable validation
options.RespectNullableAnnotations = true;

// Step 4: Full strict mode
var strictOptions = JsonSerializerOptions.Strict;
```

**Version requirements**:
- `AllowDuplicateProperties`: .NET 10+
- `JsonSerializerOptions.Strict`: .NET 10+
- `UnmappedMemberHandling`: .NET 8+
- `RespectNullableAnnotations`: .NET 9+
- `RespectRequiredConstructorParameters`: .NET 8+
- `required` members: C# 11 (.NET 7+)

## Related Topics

- **System.Text.Json serialization**: Core serialization concepts
- **JSON source generation**: Type-safe, high-performance serialization
- **ASP.NET Core model validation**: Complementary validation at the framework level
- **Data annotations**: Additional validation attributes for business rules
