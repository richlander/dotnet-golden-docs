# System.Text.Json.Nodes
## Using with JSON Proxy Middleware

Middleware that forwards JSON requests may need to inspect or modify specific fields.

```csharp
public class JsonProxyMiddleware
{
    private readonly RequestDelegate _next;

    public JsonProxyMiddleware(RequestDelegate next)
    {
        _next = next;
    }

    public async Task InvokeAsync(HttpContext context)
    {
        if (context.Request.ContentType?.Contains("application/json") == true)
        {
            // Read request body
            using var reader = new StreamReader(context.Request.Body);
            string body = await reader.ReadToEndAsync();
            
            // Parse and modify
            JsonNode requestData = JsonNode.Parse(body)!;
            
            // Add tracking fields
            requestData["requestId"] = Guid.NewGuid().ToString();
            requestData["timestamp"] = DateTime.UtcNow.ToString("O");
            requestData["source"] = context.Request.Host.Value;
            
            // Write modified body to new stream
            string modifiedBody = requestData.ToJsonString();
            var memoryStream = new MemoryStream(Encoding.UTF8.GetBytes(modifiedBody));
            context.Request.Body = memoryStream;
            context.Request.ContentLength = memoryStream.Length;
        }
        
        await _next(context);
    }
}
```

## Using with API Response Transformation

Transform JSON responses without defining types for every possible schema.

```csharp
public async Task<JsonNode> TransformApiResponse(HttpClient client, string url)
{
    // Get JSON from external API
    string responseJson = await client.GetStringAsync(url);
    JsonNode data = JsonNode.Parse(responseJson)!;
    
    // Transform to internal schema
    var transformed = new JsonObject
    {
        ["id"] = data["external_id"],
        ["name"] = data["full_name"],
        ["email"] = data["contact"]!["email"],
        ["registeredAt"] = data["registration_date"],
        ["metadata"] = new JsonObject
        {
            ["source"] = "external-api",
            ["transformedAt"] = DateTime.UtcNow.ToString("O"),
            ["originalId"] = data["external_id"]
        }
    };
    
    // Conditionally include fields
    if (data["premium_status"]?.GetValue<bool>() == true)
    {
        transformed["premiumFeatures"] = data["features"];
    }
    
    return transformed;
}
```

## Choosing Between JsonNode and JsonDocument

`JsonNode` provides mutable access but allocates more memory. `JsonDocument` offers read-only access with better performance.

```csharp
// Use JsonNode when:
// - Modifying JSON structure
// - Building JSON programmatically
// - Merging multiple documents
JsonNode mutableData = JsonNode.Parse(json)!;
mutableData["newField"] = "value";
string modified = mutableData.ToJsonString();

// Use JsonDocument when:
// - Read-only access
// - Performance-critical paths
// - Large documents
using JsonDocument readOnlyData = JsonDocument.Parse(json);
JsonElement root = readOnlyData.RootElement;
string value = root.GetProperty("field").GetString()!;

// Use JsonSerializer.Deserialize<T> when:
// - Structure known at compile time
// - Type safety required
// - Source generation available
public record Data(string Field, int Value);
Data stronglyTyped = JsonSerializer.Deserialize<Data>(json)!;
```
