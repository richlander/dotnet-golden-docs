# Migrating from Newtonsoft.Json to System.Text.Json
## Default Behavior Differences
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
