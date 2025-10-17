# Migrating from Newtonsoft.Json to System.Text.Json
## Field Support
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
