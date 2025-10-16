# System.Text.Json
## Security Considerations

System.Text.Json includes security hardening for processing untrusted JSON. Understanding these protections helps prevent security vulnerabilities.

**Depth limits prevent stack overflow:**

Default maximum depth is 64 levels to prevent deeply nested JSON from causing stack overflow attacks:

```csharp
// Default depth limit (64)
var data = JsonSerializer.Deserialize<Data>(json);

// Custom depth for trusted sources only
var options = new JsonSerializerOptions { MaxDepth = 128 };
var data = JsonSerializer.Deserialize<Data>(json, options);
```

Only increase depth limits when processing trusted JSON from known sources.

**Source generation prevents unexpected type loading:**

Reflection-based deserialization can potentially instantiate unexpected types. Source generation resolves all types at compile time:

```csharp
// Source generation - types known at compile time
var data = JsonSerializer.Deserialize(json, AppContext.Default.Data);

// Reflection - types discovered at runtime
var data = JsonSerializer.Deserialize<Data>(json);
```

For untrusted JSON, source generation provides stronger security guarantees.

**No built-in size limits:**

System.Text.Json doesn't limit JSON size. For untrusted input, enforce size limits before deserialization:

```csharp
// Enforce size limit at stream level
const int maxSize = 1024 * 1024; // 1MB
using var limitedStream = new LimitedStream(networkStream, maxSize);
var data = await JsonSerializer.DeserializeAsync<Data>(limitedStream);
```

**Type safety with known schemas:**

When possible, use strongly-typed deserialization instead of DOM APIs. This prevents processing of unexpected data structures:

```csharp
// Good - validates against schema
public record ExpectedData(string Id, int Value);
var data = JsonSerializer.Deserialize<ExpectedData>(json);

// Less safe - accepts any structure
JsonNode node = JsonNode.Parse(json);
```

**Validate after deserialization:**

Deserialization only validates JSON syntax. Add business logic validation:

```csharp
var user = JsonSerializer.Deserialize<User>(json)
    ?? throw new InvalidDataException("Null user");

if (string.IsNullOrWhiteSpace(user.Email))
    throw new ValidationException("Email required");

if (user.Age < 0 || user.Age > 150)
    throw new ValidationException("Invalid age");
```
