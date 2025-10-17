# Migrating from Newtonsoft.Json to System.Text.Json
## Namespace Changes

Newtonsoft.Json namespaces map to System.Text.Json namespaces.

```csharp
// Newtonsoft.Json
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using Newtonsoft.Json.Serialization;

// System.Text.Json
using System.Text.Json;
using System.Text.Json.Nodes;
using System.Text.Json.Serialization;
```

## API Mappings

### Serialization

```csharp
// Newtonsoft.Json
string json = JsonConvert.SerializeObject(obj);
string json = JsonConvert.SerializeObject(obj, Formatting.Indented);

// System.Text.Json
string json = JsonSerializer.Serialize(obj);
string json = JsonSerializer.Serialize(obj, new JsonSerializerOptions { WriteIndented = true });
```

### Deserialization

```csharp
// Newtonsoft.Json
MyType obj = JsonConvert.DeserializeObject<MyType>(json);

// System.Text.Json
MyType? obj = JsonSerializer.Deserialize<MyType>(json);
```

### File Operations

```csharp
// Newtonsoft.Json
string json = File.ReadAllText("file.json");
MyType obj = JsonConvert.DeserializeObject<MyType>(json);

// System.Text.Json
await using FileStream stream = File.OpenRead("file.json");
MyType? obj = await JsonSerializer.DeserializeAsync<MyType>(stream);
```

## Attribute Mappings

| Newtonsoft.Json | System.Text.Json |
|-----------------|------------------|
| `[JsonProperty("name")]` | `[JsonPropertyName("name")]` |
| `[JsonIgnore]` | `[JsonIgnore]` |
| `[JsonConverter(typeof(T))]` | `[JsonConverter(typeof(T))]` |
| `[JsonConstructor]` | `[JsonConstructor]` |
| `[JsonRequired]` | `[JsonRequired]` |
| `[JsonExtensionData]` | `[JsonExtensionData]` |
| `[JsonProperty(Required = Required.Always)]` | `[JsonRequired]` |
| `[JsonProperty(NullValueHandling = NullValueHandling.Ignore)]` | `[JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingNull)]` |
| `[JsonProperty(DefaultValueHandling = DefaultValueHandling.Ignore)]` | `[JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingDefault)]` |
| `[JsonProperty(Order = 1)]` | `[JsonPropertyOrder(1)]` |

## Settings Mappings

### JsonSerializerSettings to JsonSerializerOptions

```csharp
// Newtonsoft.Json
var settings = new JsonSerializerSettings
{
    NullValueHandling = NullValueHandling.Ignore,
    Formatting = Formatting.Indented,
    ContractResolver = new CamelCasePropertyNamesContractResolver(),
    DateFormatString = "yyyy-MM-dd"
};

// System.Text.Json
var options = new JsonSerializerOptions
{
    DefaultIgnoreCondition = JsonIgnoreCondition.WhenWritingNull,
    WriteIndented = true,
    PropertyNamingPolicy = JsonNamingPolicy.CamelCase,
    // Date format requires custom converter
};
```
