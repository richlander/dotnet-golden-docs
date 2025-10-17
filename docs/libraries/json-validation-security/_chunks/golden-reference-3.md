# JSON Validation and Security
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
