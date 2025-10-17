# Migrating from Newtonsoft.Json to System.Text.Json
## LINQ to JSON to JsonNode

```csharp
// Newtonsoft.Json
var results = jArray
    .Children<JObject>()
    .Where(o => o["age"].Value<int>() > 18)
    .Select(o => o["name"].Value<string>());

// System.Text.Json
var results = array
    .Select(n => n!.AsObject())
    .Where(o => o["age"]!.GetValue<int>() > 18)
    .Select(o => o["name"]!.GetValue<string>());
```

## SelectToken to JsonNode Indexing

```csharp
// Newtonsoft.Json
string value = (string)jObject.SelectToken("user.profile.name");

// System.Text.Json
string value = node["user"]!["profile"]!["name"]!.GetValue<string>();
```

## Streaming APIs

Newtonsoft.Json JsonReader and JsonWriter differ from System.Text.Json Utf8JsonReader and Utf8JsonWriter in API design and semantics.

## Features Without Direct Equivalent

Some Newtonsoft.Json features have no direct System.Text.Json equivalent. Alternative approaches exist for some scenarios.

### TypeNameHandling

Newtonsoft.Json `TypeNameHandling` stores .NET type information in JSON. System.Text.Json has `[JsonPolymorphic]` and `[JsonDerivedType]` attributes for type hierarchies.

### TraceWriter

Newtonsoft.Json `TraceWriter` logs serialization events. System.Text.Json has no equivalent.

### IContractResolver

Newtonsoft.Json `IContractResolver` customizes serialization contracts. System.Text.Json has `IJsonTypeInfoResolver` with contract customization.

### JsonObjectAttribute

Newtonsoft.Json `[JsonObject]` configures class serialization behavior. System.Text.Json uses `JsonSerializerOptions` and property attributes.

### System.Runtime.Serialization Attributes

Newtonsoft.Json recognizes `[DataContract]`, `[DataMember]`, and `[IgnoreDataMember]` attributes. System.Text.Json does not.

```csharp
// Newtonsoft.Json
[DataContract]
public class Data
{
    [DataMember(Name = "userName")]
    public string Name { get; set; }
    
    [IgnoreDataMember]
    public string Internal { get; set; }
}

// System.Text.Json
public class Data
{
    [JsonPropertyName("userName")]
    public string Name { get; set; }
    
    [JsonIgnore]
    public string Internal { get; set; }
}
```
