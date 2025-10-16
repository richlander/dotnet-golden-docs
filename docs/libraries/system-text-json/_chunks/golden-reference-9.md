# System.Text.Json
## Customization

JsonSerializer behavior can be customized through `JsonSerializerOptions` and custom converters.

**Common customizations:**

```csharp
var options = new JsonSerializerOptions
{
    // Property naming
    PropertyNamingPolicy = JsonNamingPolicy.CamelCase,        // camelCase
    PropertyNamingPolicy = JsonNamingPolicy.SnakeCaseLower,   // snake_case
    PropertyNamingPolicy = JsonNamingPolicy.KebabCaseLower,   // kebab-case
    
    // Null handling
    DefaultIgnoreCondition = JsonIgnoreCondition.WhenWritingNull,
    
    // Formatting
    WriteIndented = true,
    
    // Case sensitivity
    PropertyNameCaseInsensitive = true,
    
    // Numbers as strings
    NumberHandling = JsonNumberHandling.AllowReadingFromString,
    
    // Enum handling
    Converters = { new JsonStringEnumConverter() },
    
    // Unknown properties
    UnmappedMemberHandling = JsonUnmappedMemberHandling.Disallow
};
```

**Custom converters:**

Implement custom serialization logic for specific types:

```csharp
public class DateOnlyConverter : JsonConverter<DateOnly>
{
    public override DateOnly Read(ref Utf8JsonReader reader, Type typeToConvert, JsonSerializerOptions options)
        => DateOnly.Parse(reader.GetString()!);

    public override void Write(Utf8JsonWriter writer, DateOnly value, JsonSerializerOptions options)
        => writer.WriteStringValue(value.ToString("yyyy-MM-dd"));
}

// Register converter
var options = new JsonSerializerOptions
{
    Converters = { new DateOnlyConverter() }
};
```

**Attributes:**

Control serialization with attributes on types and properties:

```csharp
public class User
{
    [JsonPropertyName("user_id")]
    public int Id { get; set; }
    
    [JsonIgnore]
    public string InternalField { get; set; }
    
    [JsonRequired]
    public required string Email { get; set; }
    
    [JsonPropertyOrder(1)]
    public string Name { get; set; }
}
```

See [JsonSerializer documentation](../system-text-json-jsonserializer/golden-reference.md) for comprehensive customization options.

## Installation and Setup

System.Text.Json is included with the .NET runtime. Most projects require no explicit package reference.

**Default (no package needed):**

```xml
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>net8.0</TargetFramework>
  </PropertyGroup>
  <!-- System.Text.Json included in-box -->
</Project>
```

The in-box version matches your target framework (.NET 8 → System.Text.Json 8.x, .NET 9 → System.Text.Json 9.x).

**When to add PackageReference:**

Add an explicit package only to use newer library features than your target framework provides:

```xml
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>net8.0</TargetFramework>
  </PropertyGroup>
  <ItemGroup>
    <!-- Use System.Text.Json 9.0 features on .NET 8 -->
    <PackageReference Include="System.Text.Json" Version="9.0.0" />
  </ItemGroup>
</Project>
```

**Package pruning (SDK 10+):**

.NET 10 SDK and later show warning NU1510 when adding a PackageReference for the same or lower major version already in-box:

```xml
<!-- This triggers NU1510 on .NET 10+ SDK -->
<PackageReference Include="System.Text.Json" Version="9.0.0" />
```

The warning indicates the reference is redundant and prevents applications from being incorrectly flagged for security vulnerabilities resolved by runtime updates.

**Version selection guidance:**
- **Most applications:** No PackageReference (use in-box version)
- **Early feature adoption:** Add PackageReference for preview features
- **LTS apps:** Add PackageReference for backported fixes while staying on LTS runtime
- **Cross-targeting libraries:** Consider PackageReference for consistent behavior
