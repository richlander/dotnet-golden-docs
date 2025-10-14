# System.Text.Json.JsonDocument

## Overview

System.Text.Json.JsonDocument provides a read-only Document Object Model (DOM) for JSON with minimal memory allocation. It parses JSON into pooled memory buffers and returns `JsonElement` instances for navigation. This approach offers significantly better performance than mutable JSON nodes when modification is not required.

JsonDocument is optimized for temporary JSON access scenarios. The underlying data uses pooled memory that must be explicitly disposed, making JsonDocument ideal for request-scoped operations, routing logic, metadata extraction, and validation scenarios where JSON structure is inspected but not modified.

The API centers on `JsonElement`, a lightweight struct representing a JSON value. JsonElement provides type checking, property enumeration, array iteration, and value extraction. Because JsonElement is a struct backed by pooled memory, it has minimal allocation overhead compared to object-based DOM implementations.

Key capabilities:

- Read-only DOM access: Navigate JSON without defining types
- Pooled memory: Minimal allocation through memory pooling
- Performance: 2-3x faster than mutable JSON nodes for read operations
- Property enumeration: Iterate object properties dynamically
- Array iteration: Process JSON arrays without deserialization
- Type checking: Determine value types at runtime
- Selective deserialization: Convert specific portions to strongly-typed objects
- Metadata extraction: Read specific fields without full deserialization

JsonDocument fills the gap between `Utf8JsonReader` (forward-only, lowest allocation) and `JsonNode` (mutable, higher allocation). Use JsonDocument when you need random access to JSON without modification, streaming readers when you only need forward iteration, and JsonNode when runtime modification is required.

| Scenario | Solution | Key Benefit |
|----------|----------|-------------|
| Read-only JSON access | `JsonDocument.Parse()` | Minimal allocation |
| Routing by field value | Read property, make decision | Fast metadata extraction |
| Conditional deserialization | Check field, deserialize if needed | Avoid unnecessary parsing |
| Property validation | Enumerate properties, check types | Schema-less validation |
| Array filtering | Iterate elements, extract values | Process without full deserialization |
| Webhook routing | Parse event type, route to handler | Low-latency request processing |
| Extracting nested values | Navigate with GetProperty, read value | Efficient value access |
| Large document processing | Use with streaming for memory efficiency | Constant memory usage |
| Modifying JSON | Use `JsonNode` instead | Mutation support |
| Known structure | Use `JsonSerializer.Deserialize<T>()` instead | Type safety, source generation |

## Quick Start

```csharp
using System.Text.Json;

// Parse JSON into read-only DOM
string json = """{"name":"Alice","age":30,"active":true}""";
using JsonDocument doc = JsonDocument.Parse(json);
JsonElement root = doc.RootElement;

// Read values
string name = root.GetProperty("name").GetString()!;
int age = root.GetProperty("age").GetInt32();
bool active = root.GetProperty("active").GetBoolean();

// Check if property exists
if (root.TryGetProperty("email", out JsonElement emailElement))
{
    string email = emailElement.GetString()!;
}

// Dispose releases pooled memory
// (using statement handles this automatically)
```

## Parsing JSON

Parse JSON text or streams into a read-only document. JsonDocument must be disposed to return pooled memory.

```csharp
// Parse from string
string json = """{"id":1,"name":"Product","price":99.99}""";
using JsonDocument doc = JsonDocument.Parse(json);
JsonElement root = doc.RootElement;

// Parse from ReadOnlyMemory<byte> (UTF-8)
ReadOnlyMemory<byte> utf8Json = Encoding.UTF8.GetBytes(json);
using JsonDocument doc2 = JsonDocument.Parse(utf8Json);

// Parse from stream
await using Stream stream = File.OpenRead("data.json");
using JsonDocument doc3 = await JsonDocument.ParseAsync(stream);

// Parse with options
var options = new JsonDocumentOptions
{
    AllowTrailingCommas = true,
    CommentHandling = JsonCommentHandling.Skip,
    MaxDepth = 32
};
using JsonDocument doc4 = JsonDocument.Parse(json, options);
```

## Reading Property Values

Access object properties using `GetProperty()` and extract strongly-typed values.

```csharp
string json = """
{
    "userId": 123,
    "username": "alice",
    "score": 98.5,
    "verified": true,
    "metadata": null
}
""";

using JsonDocument doc = JsonDocument.Parse(json);
JsonElement root = doc.RootElement;

// Read primitive values
int userId = root.GetProperty("userId").GetInt32();
string username = root.GetProperty("username").GetString()!;
double score = root.GetProperty("score").GetDouble();
bool verified = root.GetProperty("verified").GetBoolean();

// Handle null values
JsonElement metadata = root.GetProperty("metadata");
if (metadata.ValueKind == JsonValueKind.Null)
{
    // Handle null case
}

// Try pattern for optional properties
if (root.TryGetProperty("optionalField", out JsonElement optional))
{
    string value = optional.GetString()!;
}
```

## Checking Property Existence

Validate that properties exist before attempting to read them.

```csharp
using JsonDocument doc = JsonDocument.Parse(json);
JsonElement root = doc.RootElement;

// Try pattern - safest approach
if (root.TryGetProperty("email", out JsonElement emailElement))
{
    string email = emailElement.GetString()!;
}
else
{
    // Property doesn't exist
}

// Check multiple properties
bool hasRequired = root.TryGetProperty("id", out _) 
    && root.TryGetProperty("name", out _);

if (!hasRequired)
{
    throw new InvalidOperationException("Missing required fields");
}
```

## Enumerating Object Properties

Iterate all properties in a JSON object dynamically.

```csharp
string json = """
{
    "id": 1,
    "name": "Product",
    "price": 99.99,
    "inStock": true
}
""";

using JsonDocument doc = JsonDocument.Parse(json);
JsonElement root = doc.RootElement;

// Enumerate all properties
foreach (JsonProperty property in root.EnumerateObject())
{
    string propertyName = property.Name;
    JsonElement value = property.Value;
    
    Console.WriteLine($"{propertyName}: {value.GetRawText()}");
}

// Filter properties by type
var numberProperties = root.EnumerateObject()
    .Where(p => p.Value.ValueKind == JsonValueKind.Number)
    .Select(p => p.Name)
    .ToList();

// Build dictionary from JSON object
Dictionary<string, string> dict = root.EnumerateObject()
    .ToDictionary(
        p => p.Name, 
        p => p.Value.GetRawText());
```

## Iterating JSON Arrays

Process JSON arrays element by element.

```csharp
string json = """
{
    "items": [10, 20, 30, 40, 50]
}
""";

using JsonDocument doc = JsonDocument.Parse(json);
JsonElement root = doc.RootElement;
JsonElement items = root.GetProperty("items");

// Enumerate array elements
foreach (JsonElement item in items.EnumerateArray())
{
    int value = item.GetInt32();
    Console.WriteLine(value);
}

// Get array length
int length = items.GetArrayLength();

// Index-based access (requires enumeration)
int firstItem = items.EnumerateArray().First().GetInt32();

// LINQ queries
var filtered = items.EnumerateArray()
    .Select(e => e.GetInt32())
    .Where(v => v > 25)
    .ToList();

// Sum array values
int sum = items.EnumerateArray()
    .Select(e => e.GetInt32())
    .Sum();
```

## Navigating Nested Structures

Access deeply nested properties using chained `GetProperty()` calls.

```csharp
string json = """
{
    "user": {
        "profile": {
            "name": "Alice",
            "contact": {
                "email": "alice@example.com",
                "phone": "555-1234"
            }
        }
    }
}
""";

using JsonDocument doc = JsonDocument.Parse(json);
JsonElement root = doc.RootElement;

// Navigate to nested value
string email = root
    .GetProperty("user")
    .GetProperty("profile")
    .GetProperty("contact")
    .GetProperty("email")
    .GetString()!;

// Safe navigation with TryGetProperty
JsonElement user = root.GetProperty("user");
if (user.TryGetProperty("profile", out JsonElement profile) &&
    profile.TryGetProperty("contact", out JsonElement contact) &&
    contact.TryGetProperty("phone", out JsonElement phone))
{
    string phoneNumber = phone.GetString()!;
}
```

## Checking Value Types

Determine the type of a JSON value at runtime.

```csharp
string json = """
{
    "string": "text",
    "number": 42,
    "decimal": 3.14,
    "boolean": true,
    "null": null,
    "object": {"key": "value"},
    "array": [1, 2, 3]
}
""";

using JsonDocument doc = JsonDocument.Parse(json);
JsonElement root = doc.RootElement;

foreach (JsonProperty property in root.EnumerateObject())
{
    JsonElement value = property.Value;
    
    switch (value.ValueKind)
    {
        case JsonValueKind.String:
            string str = value.GetString()!;
            break;
        case JsonValueKind.Number:
            if (value.TryGetInt32(out int intValue))
            {
                // Integer
            }
            else
            {
                double doubleValue = value.GetDouble();
                // Floating point
            }
            break;
        case JsonValueKind.True:
        case JsonValueKind.False:
            bool boolValue = value.GetBoolean();
            break;
        case JsonValueKind.Null:
            // Handle null
            break;
        case JsonValueKind.Object:
            // Enumerate nested object
            break;
        case JsonValueKind.Array:
            // Enumerate nested array
            break;
    }
}
```

## Processing Arrays of Objects

Work with JSON arrays containing complex objects.

```csharp
string json = """
{
    "products": [
        {"id": 1, "name": "Widget", "price": 29.99},
        {"id": 2, "name": "Gadget", "price": 49.99},
        {"id": 3, "name": "Tool", "price": 19.99}
    ]
}
""";

using JsonDocument doc = JsonDocument.Parse(json);
JsonElement root = doc.RootElement;
JsonElement products = root.GetProperty("products");

// Iterate objects in array
foreach (JsonElement product in products.EnumerateArray())
{
    int id = product.GetProperty("id").GetInt32();
    string name = product.GetProperty("name").GetString()!;
    decimal price = product.GetProperty("price").GetDecimal();
    
    Console.WriteLine($"Product {id}: {name} - ${price}");
}

// Find specific item
JsonElement? widget = products.EnumerateArray()
    .FirstOrDefault(p => p.GetProperty("name").GetString() == "Widget");

if (widget.HasValue)
{
    decimal price = widget.Value.GetProperty("price").GetDecimal();
}

// Filter by criteria
var expensive = products.EnumerateArray()
    .Where(p => p.GetProperty("price").GetDecimal() > 25)
    .Select(p => p.GetProperty("name").GetString())
    .ToList();
```

## Converting to Strongly-Typed Objects

Deserialize specific portions of JSON into strongly-typed objects.

```csharp
public record UserProfile(string Name, string Email, int Age);

string json = """
{
    "user": {
        "name": "Alice",
        "email": "alice@example.com",
        "age": 30
    },
    "timestamp": "2024-01-15T10:30:00Z",
    "metadata": {"source": "api"}
}
""";

using JsonDocument doc = JsonDocument.Parse(json);
JsonElement root = doc.RootElement;

// Get raw JSON text of specific element
JsonElement userElement = root.GetProperty("user");
string userJson = userElement.GetRawText();

// Deserialize just that portion
UserProfile profile = JsonSerializer.Deserialize<UserProfile>(userJson)!;

Console.WriteLine($"{profile.Name} is {profile.Age} years old");
```

## Cloning JsonElement

JsonElement references memory owned by JsonDocument. To retain values beyond document lifetime, extract them or clone the raw JSON.

```csharp
string json = """{"name":"Alice","settings":{"theme":"dark"}}""";

// JsonElement becomes invalid after Dispose
JsonElement capturedElement;
using (JsonDocument doc = JsonDocument.Parse(json))
{
    JsonElement root = doc.RootElement;
    
    // Wrong: Element references disposed memory
    // capturedElement = root.GetProperty("settings");
    
    // Right: Extract the value
    string settingsJson = root.GetProperty("settings").GetRawText();
    
    // Or parse into new document
    using JsonDocument settingsDoc = JsonDocument.Parse(settingsJson);
    capturedElement = settingsDoc.RootElement.Clone();
}

// Clone creates a copy that outlives the original document
// Clone allocates new memory, losing the pooling benefit
```

## Using with Webhook Routing

Route webhook events based on event type without deserializing entire payload.

```csharp
public async Task ProcessWebhook(HttpRequest request)
{
    using Stream body = request.Body;
    using JsonDocument doc = await JsonDocument.ParseAsync(body);
    JsonElement root = doc.RootElement;
    
    // Extract event type for routing
    string eventType = root.GetProperty("event_type").GetString()!;
    
    // Route based on event type
    switch (eventType)
    {
        case "order.created":
            JsonElement orderData = root.GetProperty("data");
            string orderJson = orderData.GetRawText();
            Order order = JsonSerializer.Deserialize<Order>(orderJson)!;
            await ProcessOrder(order);
            break;
            
        case "user.updated":
            JsonElement userData = root.GetProperty("data");
            string userJson = userData.GetRawText();
            User user = JsonSerializer.Deserialize<User>(userJson)!;
            await UpdateUser(user);
            break;
            
        case "payment.completed":
            JsonElement paymentData = root.GetProperty("data");
            string paymentJson = paymentData.GetRawText();
            Payment payment = JsonSerializer.Deserialize<Payment>(paymentJson)!;
            await ProcessPayment(payment);
            break;
            
        default:
            throw new NotSupportedException($"Unknown event type: {eventType}");
    }
}
```

## Using with Conditional Deserialization

Check JSON structure before committing to full deserialization.

```csharp
public async Task<IActionResult> ProcessRequest(string jsonPayload)
{
    using JsonDocument doc = JsonDocument.Parse(jsonPayload);
    JsonElement root = doc.RootElement;
    
    // Check version field
    if (!root.TryGetProperty("version", out JsonElement versionElement))
    {
        return BadRequest("Missing version field");
    }
    
    int version = versionElement.GetInt32();
    
    // Deserialize using version-specific type
    return version switch
    {
        1 => ProcessV1(JsonSerializer.Deserialize<RequestV1>(jsonPayload)!),
        2 => ProcessV2(JsonSerializer.Deserialize<RequestV2>(jsonPayload)!),
        3 => ProcessV3(JsonSerializer.Deserialize<RequestV3>(jsonPayload)!),
        _ => BadRequest($"Unsupported version: {version}")
    };
}
```

## Using with Configuration Validation

Validate configuration files without loading into strongly-typed objects.

```csharp
public bool ValidateConfiguration(string configJson)
{
    using JsonDocument doc = JsonDocument.Parse(configJson);
    JsonElement root = doc.RootElement;
    
    // Check required sections exist
    if (!root.TryGetProperty("Database", out JsonElement db))
    {
        Console.WriteLine("Missing Database section");
        return false;
    }
    
    if (!db.TryGetProperty("ConnectionString", out JsonElement connStr))
    {
        Console.WriteLine("Missing ConnectionString");
        return false;
    }
    
    if (connStr.GetString()?.Length == 0)
    {
        Console.WriteLine("ConnectionString is empty");
        return false;
    }
    
    // Validate optional sections
    if (root.TryGetProperty("Logging", out JsonElement logging))
    {
        if (!logging.TryGetProperty("LogLevel", out JsonElement logLevel))
        {
            Console.WriteLine("Warning: Logging section missing LogLevel");
        }
    }
    
    // Check for duplicate properties (requires enumeration)
    var propertyNames = new HashSet<string>();
    foreach (JsonProperty property in root.EnumerateObject())
    {
        if (!propertyNames.Add(property.Name))
        {
            Console.WriteLine($"Duplicate property: {property.Name}");
            return false;
        }
    }
    
    return true;
}
```

## Using with Metadata Extraction

Extract specific metadata fields from large JSON documents without parsing everything.

```csharp
public async Task<DocumentMetadata> ExtractMetadata(Stream documentStream)
{
    using JsonDocument doc = await JsonDocument.ParseAsync(documentStream);
    JsonElement root = doc.RootElement;
    
    // Extract only needed fields
    string id = root.GetProperty("id").GetString()!;
    string title = root.GetProperty("title").GetString()!;
    DateTime created = root.GetProperty("createdAt").GetDateTime();
    
    // Count items without deserializing them
    int itemCount = 0;
    if (root.TryGetProperty("items", out JsonElement items))
    {
        itemCount = items.GetArrayLength();
    }
    
    // Check for specific flags
    bool isArchived = root.TryGetProperty("archived", out JsonElement archived) 
        && archived.GetBoolean();
    
    return new DocumentMetadata
    {
        Id = id,
        Title = title,
        CreatedAt = created,
        ItemCount = itemCount,
        IsArchived = isArchived
    };
}

public record DocumentMetadata
{
    public string Id { get; init; } = string.Empty;
    public string Title { get; init; } = string.Empty;
    public DateTime CreatedAt { get; init; }
    public int ItemCount { get; init; }
    public bool IsArchived { get; init; }
}
```

## Using with Response Filtering

Filter API responses before deserialization based on metadata.

```csharp
public async Task<List<Article>> GetRecentArticles(HttpClient client, int maxDays)
{
    var response = await client.GetAsync("/api/articles");
    await using Stream stream = await response.Content.ReadAsStreamAsync();
    
    using JsonDocument doc = await JsonDocument.ParseAsync(stream);
    JsonElement root = doc.RootElement;
    JsonElement articles = root.GetProperty("articles");
    
    DateTime cutoff = DateTime.UtcNow.AddDays(-maxDays);
    var recentArticles = new List<Article>();
    
    // Filter before deserializing individual articles
    foreach (JsonElement articleElement in articles.EnumerateArray())
    {
        DateTime published = articleElement
            .GetProperty("publishedAt")
            .GetDateTime();
        
        if (published >= cutoff)
        {
            // Only deserialize recent articles
            string articleJson = articleElement.GetRawText();
            Article article = JsonSerializer.Deserialize<Article>(articleJson)!;
            recentArticles.Add(article);
        }
    }
    
    return recentArticles;
}
```

## Using with Streaming Large Files

Combine JsonDocument with streaming to process large files incrementally.

```csharp
public async Task ProcessLargeJsonFile(string filePath)
{
    await using FileStream stream = File.OpenRead(filePath);
    using JsonDocument doc = await JsonDocument.ParseAsync(stream);
    JsonElement root = doc.RootElement;
    
    // Document is parsed, but can process incrementally
    JsonElement records = root.GetProperty("records");
    
    int count = 0;
    foreach (JsonElement record in records.EnumerateArray())
    {
        // Process one record at a time
        await ProcessRecord(record);
        count++;
        
        if (count % 1000 == 0)
        {
            Console.WriteLine($"Processed {count} records");
        }
    }
}

// For truly massive files, use Utf8JsonReader instead
// JsonDocument loads entire document into memory
```

## Writing JSON from JsonElement

Write JsonElement values to a stream or string.

```csharp
using JsonDocument doc = JsonDocument.Parse(originalJson);
JsonElement root = doc.RootElement;

// Write element to string (formatted)
var options = new JsonSerializerOptions { WriteIndented = true };
string formatted = JsonSerializer.Serialize(root, options);

// Write element to stream
await using var stream = File.Create("output.json");
await JsonSerializer.SerializeAsync(stream, root, options);

// Write specific element
JsonElement settings = root.GetProperty("settings");
string settingsJson = JsonSerializer.Serialize(settings, options);
```

## Choosing Between JsonDocument, JsonNode, and Deserialization

Different approaches suit different scenarios based on performance, flexibility, and type safety requirements.

```csharp
// JsonDocument: Best for read-only access, minimal allocation
using JsonDocument doc = JsonDocument.Parse(json);
string value = doc.RootElement.GetProperty("field").GetString()!;
// Pros: Fastest, lowest allocation, pooled memory
// Cons: Read-only, requires disposal, no modification

// JsonNode: Best for modification and dynamic building
JsonNode node = JsonNode.Parse(json)!;
node["field"] = "new value";
string modified = node.ToJsonString();
// Pros: Mutable, flexible, no disposal needed
// Cons: Higher allocation, slower than JsonDocument

// Strongly-typed: Best for known structure
public record Data(string Field, int Value);
Data obj = JsonSerializer.Deserialize<Data>(json)!;
// Pros: Type safety, source generation support, fastest with source gen
// Cons: Requires type definitions, inflexible

// Performance hierarchy (fastest to slowest):
// 1. JsonSerializer.Deserialize<T> with source generation
// 2. JsonDocument (read-only DOM)
// 3. JsonSerializer.Deserialize<T> with reflection
// 4. JsonNode (mutable DOM)
```

## Considerations

### Memory Management

JsonDocument uses pooled memory that must be disposed. Failure to dispose causes memory leaks. Always use `using` statements or explicit `Dispose()` calls.

```csharp
// Correct: using statement ensures disposal
using JsonDocument doc = JsonDocument.Parse(json);
ProcessDocument(doc);

// Correct: explicit disposal
JsonDocument doc = JsonDocument.Parse(json);
try
{
    ProcessDocument(doc);
}
finally
{
    doc.Dispose();
}

// Wrong: Memory leak
JsonDocument doc = JsonDocument.Parse(json);
ProcessDocument(doc);
// Pooled memory never returned
```

### JsonElement Lifetime

JsonElement is a struct that references memory owned by JsonDocument. Elements become invalid after document disposal. Extract values or raw JSON text if you need data beyond document lifetime.

```csharp
string ExtractValue(string json)
{
    using JsonDocument doc = JsonDocument.Parse(json);
    JsonElement root = doc.RootElement;
    
    // Wrong: Element references disposed memory
    // return root.GetProperty("field"); // Will fail
    
    // Right: Extract the value
    return root.GetProperty("field").GetString()!;
}
```

### Performance Characteristics

JsonDocument parses the entire document into memory, which is faster for random access but slower for forward-only processing. For sequential reading of large documents, `Utf8JsonReader` offers better performance.

JsonDocument provides O(1) property access after parsing, while `Utf8JsonReader` requires sequential scanning. Choose based on access patterns.

### Read-Only Limitation

JsonDocument provides no mutation APIs. For scenarios requiring modification, use `JsonNode` instead. Converting from JsonDocument to JsonNode requires reparsing:

```csharp
// Convert JsonDocument to JsonNode for modification
using JsonDocument doc = JsonDocument.Parse(json);
string rawJson = doc.RootElement.GetRawText();
JsonNode node = JsonNode.Parse(rawJson)!;
node["newField"] = "value";
```

### Comparison with JsonNode

JsonDocument offers better performance (2-3x faster) but is read-only and requires disposal. JsonNode provides mutation but allocates more memory and has no disposal requirement. Choose based on whether modification is needed.

## Related Concepts

**Used by System.Text.Json.JsonDocument:**

- `Utf8JsonReader` (underlying parsing primitive)
- Pooled memory buffers (allocation optimization)

**Uses System.Text.Json.JsonDocument:**

- Webhook routing systems (event type extraction)
- Configuration validators (schema-less validation)
- API response filters (conditional deserialization)
- Metadata extractors (selective field reading)
- Request routers (routing by payload content)

**Alternative to System.Text.Json.JsonDocument:**

- `JsonNode` (mutable DOM with higher allocation)
- `JsonSerializer.Deserialize<T>()` (strongly-typed with type safety)
- `Utf8JsonReader` (forward-only with lowest allocation)
