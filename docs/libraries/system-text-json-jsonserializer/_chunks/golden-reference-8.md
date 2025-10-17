# System.Text.Json.JsonSerializer
## Polymorphic Serialization

Handle inheritance hierarchies with type discriminators.

```csharp
using System.Text.Json.Serialization;

[JsonPolymorphic(TypeDiscriminatorPropertyName = "type")]
[JsonDerivedType(typeof(Circle), "circle")]
[JsonDerivedType(typeof(Rectangle), "rectangle")]
public abstract class Shape
{
    public string Name { get; set; } = string.Empty;
}

public class Circle : Shape
{
    public double Radius { get; set; }
}

public class Rectangle : Shape
{
    public double Width { get; set; }
    public double Height { get; set; }
}

Shape circle = new Circle { Name = "My Circle", Radius = 5.0 };
string json = JsonSerializer.Serialize(circle);
// {"type":"circle","Name":"My Circle","Radius":5.0}

Shape? deserialized = JsonSerializer.Deserialize<Shape>(json);
if (deserialized is Circle c)
{
    Console.WriteLine($"Circle with radius {c.Radius}");
}
```

## Allowing Trailing Commas and Comments

Parse JSON with relaxed syntax.

```csharp
string json = """
{
    // This is a comment
    "id": 1,
    "name": "Alice",
    "active": true,  // Trailing comma
}
""";

var options = new JsonSerializerOptions
{
    AllowTrailingCommas = true,
    ReadCommentHandling = JsonCommentHandling.Skip
};

User? user = JsonSerializer.Deserialize<User>(json, options);
```

## Handling Large Numbers

Configure number handling for special cases.

```csharp
using System.Text.Json.Serialization;

public class Data
{
    public long LargeNumber { get; set; }
}

// Allow reading numbers from strings
var options = new JsonSerializerOptions
{
    NumberHandling = JsonNumberHandling.AllowReadingFromString
};

// Valid: Number as string
string json = """{"LargeNumber":"9223372036854775807"}""";
Data? data = JsonSerializer.Deserialize<Data>(json, options);

// Also valid: Normal number
string json2 = """{"LargeNumber":9223372036854775807}""";
Data? data2 = JsonSerializer.Deserialize<Data>(json2, options);
```
