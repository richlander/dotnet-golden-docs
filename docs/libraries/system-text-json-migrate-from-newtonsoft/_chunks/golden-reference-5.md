# Migrating from Newtonsoft.Json to System.Text.Json
## Custom Converters

Newtonsoft.Json and System.Text.Json use different base classes and method signatures for custom converters. Converters inherit from different base classes and implement different methods.

```csharp
// Newtonsoft.Json
public class CustomConverter : JsonConverter<MyType>
{
    public override void WriteJson(JsonWriter writer, MyType value, JsonSerializer serializer)
    {
        // Write logic
    }
    
    public override MyType ReadJson(JsonReader reader, Type objectType, 
        MyType existingValue, bool hasExistingValue, JsonSerializer serializer)
    {
        // Read logic
        return value;
    }
}

// System.Text.Json
public class CustomConverter : JsonConverter<MyType>
{
    public override void Write(Utf8JsonWriter writer, MyType value, JsonSerializerOptions options)
    {
        // Write logic
    }
    
    public override MyType Read(ref Utf8JsonReader reader, Type typeToConvert, JsonSerializerOptions options)
    {
        // Read logic
        return value;
    }
}
```

## DOM API Mappings

### JObject to JsonNode

```csharp
// Newtonsoft.Json
JObject jObject = JObject.Parse(json);
string name = (string)jObject["name"];
jObject["age"] = 30;
string modified = jObject.ToString();

// System.Text.Json
JsonNode node = JsonNode.Parse(json)!;
string name = node["name"]!.GetValue<string>();
node["age"] = 30;
string modified = node.ToJsonString();
```

### JArray to JsonArray

```csharp
// Newtonsoft.Json
JArray jArray = JArray.Parse(json);
foreach (JToken item in jArray)
{
    string value = (string)item;
}

// System.Text.Json
JsonArray array = JsonNode.Parse(json)!.AsArray();
foreach (JsonNode? item in array)
{
    string value = item!.GetValue<string>();
}
```

### JToken to JsonElement (Read-Only)

```csharp
// Newtonsoft.Json
JObject jObject = JObject.Parse(json);
JToken nameToken = jObject["name"];
string name = nameToken.Value<string>();

// System.Text.Json
using JsonDocument doc = JsonDocument.Parse(json);
JsonElement root = doc.RootElement;
JsonElement nameElement = root.GetProperty("name");
string name = nameElement.GetString()!;
```
