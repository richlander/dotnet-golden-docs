# System.Text.Json.JsonSerializer
## Adding Documentation to JSON Schema

Include descriptions from attributes in the generated schema.

```csharp
using System.ComponentModel;
using System.Reflection;
using System.Text.Json.Schema;
using System.Text.Json.Nodes;

[Description("Represents a user in the system.")]
public class User
{
    [Description("The unique identifier for the user.")]
    public required int Id { get; set; }
    
    [Description("The user's full name.")]
    public required string Name { get; set; }
    
    [Description("The user's email address (optional).")]
    public string? Email { get; set; }
}

// Configure exporter to include descriptions
var exporterOptions = new JsonSchemaExporterOptions
{
    TransformSchemaNode = (context, schema) =>
    {
        // Skip if not a schema object or if it's a reference
        if (schema is not JsonObject schemaObj || schemaObj.ContainsKey("$ref"))
        {
            return schema;
        }
        
        // Look for Description attribute on property, parameter, or type
        DescriptionAttribute? descriptionAttribute =
            GetCustomAttribute<DescriptionAttribute>(context.PropertyInfo?.AttributeProvider) ??
            GetCustomAttribute<DescriptionAttribute>(context.PropertyInfo?.AssociatedParameter?.AttributeProvider) ??
            GetCustomAttribute<DescriptionAttribute>(context.TypeInfo.Type);
        
        if (descriptionAttribute != null)
        {
            // Insert description as first property
            schemaObj.Insert(0, "description", (JsonNode)descriptionAttribute.Description);
        }
        
        return schemaObj;
    }
};

var serializerOptions = new JsonSerializerOptions
{
    PropertyNamingPolicy = JsonNamingPolicy.CamelCase
};

JsonNode schema = JsonSchemaExporter.GetJsonSchemaAsNode(
    serializerOptions, 
    typeof(User), 
    exporterOptions);

string schemaJson = schema.ToJsonString(new JsonSerializerOptions { WriteIndented = true });
// {
//   "description": "Represents a user in the system.",
//   "type": "object",
//   "properties": {
//     "id": {
//       "description": "The unique identifier for the user.",
//       "type": "integer"
//     },
//     "name": {
//       "description": "The user's full name.",
//       "type": "string"
//     },
//     "email": {
//       "description": "The user's email address (optional).",
//       "type": ["string", "null"]
//     }
//   },
//   "required": ["id", "name"]
// }

static TAttribute? GetCustomAttribute<TAttribute>(
    ICustomAttributeProvider? provider, 
    bool inherit = false) where TAttribute : Attribute
    => provider?.GetCustomAttributes(typeof(TAttribute), inherit)
        .FirstOrDefault() as TAttribute;
```
