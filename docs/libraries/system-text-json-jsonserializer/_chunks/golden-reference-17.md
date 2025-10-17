# System.Text.Json.JsonSerializer
## Handling Unmapped Members

Control deserialization behavior when JSON contains properties not present in the target type.

```csharp
public class User
{
    public int Id { get; set; }
    public string Name { get; set; } = string.Empty;
}

string json = """{"Id":1,"Name":"Alice","ExtraProperty":"value","Another":"data"}""";

// Default: Ignores unmapped properties
User? user1 = JsonSerializer.Deserialize<User>(json);
// Succeeds - ExtraProperty and Another are ignored

// Disallow unmapped properties globally
var strictOptions = new JsonSerializerOptions
{
    UnmappedMemberHandling = JsonUnmappedMemberHandling.Disallow
};

try
{
    User? user2 = JsonSerializer.Deserialize<User>(json, strictOptions);
}
catch (JsonException ex)
{
    // Exception: JSON object contains property 'ExtraProperty' that could not be mapped
}

// Per-type control with attribute
[JsonUnmappedMemberHandling(JsonUnmappedMemberHandling.Disallow)]
public class StrictUser
{
    public int Id { get; set; }
    public string Name { get; set; } = string.Empty;
}

// Throws exception if unmapped properties present
StrictUser? strict = JsonSerializer.Deserialize<StrictUser>(json);
```

## Out-of-Order Metadata Deserialization

Polymorphic deserialization accepts metadata properties in any order.

```csharp
[JsonPolymorphic(TypeDiscriminatorPropertyName = "$type")]
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

// $type can appear anywhere in the JSON object
string json1 = """{"$type":"circle","Name":"Circle1","Radius":5.0}""";
string json2 = """{"Name":"Circle2","Radius":10.0,"$type":"circle"}""";
string json3 = """{"Name":"Circle3","$type":"circle","Radius":15.0}""";

// All three deserialize correctly
Shape? shape1 = JsonSerializer.Deserialize<Shape>(json1);
Shape? shape2 = JsonSerializer.Deserialize<Shape>(json2);
Shape? shape3 = JsonSerializer.Deserialize<Shape>(json3);
```
