# Migrating from Newtonsoft.Json to System.Text.Json

## Overview

This document maps Newtonsoft.Json APIs to their System.Text.Json equivalents. It covers namespaces, methods, attributes, settings, and DOM APIs. Code examples show the syntax differences between the two libraries.

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

### Case-Insensitive Deserialization

```csharp
// Newtonsoft.Json
MyType obj = JsonConvert.DeserializeObject<MyType>(json);

// System.Text.Json
var options = new JsonSerializerOptions
{
    PropertyNameCaseInsensitive = true
};
MyType? obj = JsonSerializer.Deserialize<MyType>(json, options);
```

### Naming Policies

```csharp
// Newtonsoft.Json
var settings = new JsonSerializerSettings
{
    ContractResolver = new CamelCasePropertyNamesContractResolver()
};

// System.Text.Json - camelCase
var options = new JsonSerializerOptions
{
    PropertyNamingPolicy = JsonNamingPolicy.CamelCase
};

// System.Text.Json - snake_case
var options = new JsonSerializerOptions
{
    PropertyNamingPolicy = JsonNamingPolicy.SnakeCaseLower
};
```

### Allowing Comments and Trailing Commas

```csharp
// Newtonsoft.Json
MyType obj = JsonConvert.DeserializeObject<MyType>(json);

// System.Text.Json
var options = new JsonSerializerOptions
{
    ReadCommentHandling = JsonCommentHandling.Skip,
    AllowTrailingCommas = true
};
MyType? obj = JsonSerializer.Deserialize<MyType>(json, options);
```

### Numbers in Quotes

```csharp
// Newtonsoft.Json
MyType obj = JsonConvert.DeserializeObject<MyType>(json);

// System.Text.Json
var options = new JsonSerializerOptions
{
    NumberHandling = JsonNumberHandling.AllowReadingFromString | JsonNumberHandling.WriteAsString
};
MyType? obj = JsonSerializer.Deserialize<MyType>(json, options);
```

## Constructor-Based Deserialization

```csharp
// Newtonsoft.Json
public class Person
{
    public Person(string name, int age)
    {
        Name = name;
        Age = age;
    }
    
    public string Name { get; }
    public int Age { get; }
}

// System.Text.Json
public class Person
{
    [JsonConstructor]
    public Person(string name, int age)
    {
        Name = name;
        Age = age;
    }
    
    public string Name { get; }
    public int Age { get; }
}
```

## Field Support

```csharp
// Newtonsoft.Json
public class Data
{
    public int PublicField;
}

// System.Text.Json
var options = new JsonSerializerOptions
{
    IncludeFields = true
};

// Or per-field
public class Data
{
    [JsonInclude]
    public int PublicField;
}
```

## Enum Serialization

```csharp
// Newtonsoft.Json
var settings = new JsonSerializerSettings
{
    Converters = { new StringEnumConverter() }
};

// System.Text.Json
var options = new JsonSerializerOptions
{
    Converters = { new JsonStringEnumConverter() }
};

// With naming policy
var options = new JsonSerializerOptions
{
    Converters = { new JsonStringEnumConverter(JsonNamingPolicy.CamelCase) }
};
```

## Reference Handling

```csharp
// Newtonsoft.Json
var settings = new JsonSerializerSettings
{
    ReferenceLoopHandling = ReferenceLoopHandling.Ignore,
    PreserveReferencesHandling = PreserveReferencesHandling.All
};

// System.Text.Json - ignore cycles
var options = new JsonSerializerOptions
{
    ReferenceHandler = ReferenceHandler.IgnoreCycles
};

// System.Text.Json - preserve references
var options = new JsonSerializerOptions
{
    ReferenceHandler = ReferenceHandler.Preserve
};
```

## Polymorphic Serialization

```csharp
// Newtonsoft.Json
[JsonConverter(typeof(JsonInheritanceConverter))]
public abstract class Shape { }

// System.Text.Json
[JsonPolymorphic(TypeDiscriminatorPropertyName = "$type")]
[JsonDerivedType(typeof(Circle), "circle")]
[JsonDerivedType(typeof(Rectangle), "rectangle")]
public abstract class Shape { }

public class Circle : Shape
{
    public double Radius { get; set; }
}

public class Rectangle : Shape
{
    public double Width { get; set; }
    public double Height { get; set; }
}

// System.Text.Json accepts type discriminator in any position
string json = """{"Radius":5.0,"$type":"circle"}""";
Shape? shape = JsonSerializer.Deserialize<Shape>(json);
```

## Dictionary with Non-String Keys

```csharp
// Newtonsoft.Json
var dict = new Dictionary<int, string> { [1] = "one", [2] = "two" };
string json = JsonConvert.SerializeObject(dict);

// System.Text.Json
var dict = new Dictionary<int, string> { [1] = "one", [2] = "two" };
string json = JsonSerializer.Serialize(dict);
// Both produce: {"1":"one","2":"two"}
```

## Populating Existing Objects

```csharp
// Newtonsoft.Json
var obj = new MyClass { Items = new List<string> { "existing" } };
JsonConvert.PopulateObject(json, obj);
// obj.Items now contains both "existing" and items from JSON

// System.Text.Json
var options = new JsonSerializerOptions
{
    PreferredObjectCreationHandling = JsonObjectCreationHandling.Populate
};
var obj = new MyClass { Items = new List<string> { "existing" } };
obj = JsonSerializer.Deserialize<MyClass>(json, options);
// obj.Items now contains both "existing" and items from JSON
```

## Non-Public Members

```csharp
// Newtonsoft.Json
public class Data
{
    public int Value { get; private set; }
}

// System.Text.Json
public class Data
{
    [JsonInclude]
    public int Value { get; private set; }
}
```

## Required Properties

```csharp
// Newtonsoft.Json
public class Data
{
    [JsonProperty(Required = Required.Always)]
    public string Name { get; set; }
}

// System.Text.Json
public class Data
{
    [JsonRequired]
    public string Name { get; set; }
}

// Or with C# required keyword
public class Data
{
    public required string Name { get; set; }
}
```

## Callbacks

```csharp
// Newtonsoft.Json
public class Data
{
    [OnSerializing]
    internal void OnSerializing(StreamingContext context)
    {
        // Before serialization
    }
    
    [OnDeserialized]
    internal void OnDeserialized(StreamingContext context)
    {
        // After deserialization
    }
}

// System.Text.Json
public class Data : IJsonOnSerializing, IJsonOnDeserialized
{
    void IJsonOnSerializing.OnSerializing()
    {
        // Before serialization
    }
    
    void IJsonOnDeserialized.OnDeserialized()
    {
        // After deserialization
    }
}
```

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

### DateFormatString

Newtonsoft.Json `DateFormatString` customizes date serialization. System.Text.Json serializes dates in ISO 8601 format. Custom date formats use custom converters.

```csharp
// Newtonsoft.Json format not directly supported in System.Text.Json
var settings = new JsonSerializerSettings
{
    DateFormatString = "yyyy-MM-dd"
};

// System.Text.Json requires custom converter for custom formats
public class CustomDateConverter : JsonConverter<DateTime>
{
    public override DateTime Read(ref Utf8JsonReader reader, Type typeToConvert, JsonSerializerOptions options)
    {
        return DateTime.ParseExact(reader.GetString()!, "yyyy-MM-dd", CultureInfo.InvariantCulture);
    }
    
    public override void Write(Utf8JsonWriter writer, DateTime value, JsonSerializerOptions options)
    {
        writer.WriteStringValue(value.ToString("yyyy-MM-dd"));
    }
}
```

## Default Behavior Differences

Newtonsoft.Json and System.Text.Json have different default behaviors. These differences affect how JSON is parsed and generated without explicit configuration.

| Behavior | Newtonsoft.Json | System.Text.Json |
|----------|-----------------|------------------|
| Property name casing | Case-insensitive | Case-sensitive |
| Comments in JSON | Allowed | Rejected (configurable) |
| Trailing commas | Allowed | Rejected (configurable) |
| String quotes | Single or double | Double only |
| Property name quotes | Optional | Required |
| Numbers in strings | Accepted | Rejected (configurable) |
| Non-string in string property | Coerced | Rejected |
| Fields | Serialized | Ignored (configurable) |
| Private setters | Serialized | Ignored (configurable) |
| Reference loops | Serialized with $ref | Exception (configurable) |
| Maximum depth | 64 | 64 |

## Code Transformation Reference

| Step | Newtonsoft.Json | System.Text.Json |
|------|-----------------|------------------|
| 1 | `using Newtonsoft.Json;` | `using System.Text.Json;` |
| 2 | `JsonConvert.SerializeObject()` | `JsonSerializer.Serialize()` |
| 3 | `JsonConvert.DeserializeObject<T>()` | `JsonSerializer.Deserialize<T>()` |
| 4 | `[JsonProperty]` | `[JsonPropertyName]` |
| 5 | `JsonSerializerSettings` | `JsonSerializerOptions` |
| 6 | Custom converters | Rewrite with new base class |
| 7 | `JObject`/`JArray` | `JsonNode`/`JsonArray` or `JsonDocument` |
| 8 | Test with existing JSON data | Test with existing JSON data |

## Related Concepts

**System.Text.Json topics:**
- JsonSerializer (high-level API)
- JsonNode (mutable DOM)
- JsonDocument (read-only DOM)
- Source Generation (performance optimization)
- Custom Converters (extensibility)
