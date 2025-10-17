# Migrating from Newtonsoft.Json to System.Text.Json
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
