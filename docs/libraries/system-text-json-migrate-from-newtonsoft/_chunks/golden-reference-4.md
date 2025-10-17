# Migrating from Newtonsoft.Json to System.Text.Json
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
