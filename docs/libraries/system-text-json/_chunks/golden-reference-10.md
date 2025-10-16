# System.Text.Json
## Common Patterns

**AI structured responses (Microsoft.Extensions.AI):**

```csharp
[JsonSerializable(typeof(WeatherForecast))]
partial class AppContext : JsonSerializerContext { }

IChatClient client = GetChatClient();
var response = await client.GetResponseAsync<WeatherForecast>(
    "What's the weather in Seattle?",
    serializerOptions: AppContext.Default.Options);
```

**Generic methods with source generation:**

```csharp
// Direct JsonTypeInfo<T> (compile-time type safety)
var data = await httpClient.GetFromJsonAsync(
    "https://api.example.com/data",
    AppJsonContext.Default.DataType);

// Via options (more flexible)
var options = new JsonSerializerOptions 
{ 
    TypeInfoResolver = AppJsonContext.Default 
};
var data = await httpClient.GetFromJsonAsync<DataType>(url, options);
```

**Dynamic JSON routing:**

```csharp
// Read event type without full deserialization
using JsonDocument doc = JsonDocument.Parse(webhookPayload);
string eventType = doc.RootElement.GetProperty("event_type").GetString()!;

// Route and deserialize only relevant portion
if (eventType == "order.created")
{
    var orderData = doc.RootElement.GetProperty("data");
    Order order = JsonSerializer.Deserialize<Order>(orderData.GetRawText())!;
    await ProcessOrder(order);
}
```

**Config merging:**

```csharp
JsonNode baseConfig = JsonNode.Parse(baseConfigJson)!;
JsonNode overrides = JsonNode.Parse(overrideJson)!;

foreach (var prop in overrides.AsObject())
{
    baseConfig[prop.Key] = prop.Value?.DeepClone();
}

string merged = baseConfig.ToJsonString();
```

## Migration from Newtonsoft.Json

Key differences when migrating from Newtonsoft.Json:

**Namespace changes:**
```csharp
// Old
using Newtonsoft.Json;

// New
using System.Text.Json;
```

**API changes:**
```csharp
// Old
string json = JsonConvert.SerializeObject(obj);
var obj = JsonConvert.DeserializeObject<MyType>(json);

// New
string json = JsonSerializer.Serialize(obj);
var obj = JsonSerializer.Deserialize<MyType>(json);
```

**Attribute changes:**
```csharp
// Old
[JsonProperty("user_name")]
public string UserName { get; set; }

// New
[JsonPropertyName("user_name")]
public string UserName { get; set; }
```

**Key behavioral differences:**
- DateTime uses ISO 8601 by default
- No `ISerializable` support
- Requires `[JsonConstructor]` for parameterized constructors
- Polymorphism requires `[JsonDerivedType]` attributes
- Custom converters have different implementation

See [Migration from Newtonsoft.Json guide](../system-text-json-migrate-from-newtonsoft/golden-reference.md) for comprehensive details.
