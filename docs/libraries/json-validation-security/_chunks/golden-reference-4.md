# JSON Validation and Security
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
