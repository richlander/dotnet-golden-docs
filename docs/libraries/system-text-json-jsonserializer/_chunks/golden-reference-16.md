# System.Text.Json.JsonSerializer
## Documenting Constructor Parameters in Schema

Include descriptions for constructor parameters in the generated schema.

```csharp
using System.ComponentModel;
using System.Text.Json.Serialization;

[Description("A product with immutable properties.")]
public class Product
{
    public int Id { get; }
    public string Name { get; }
    public decimal Price { get; }
    
    [JsonConstructor]
    public Product(
        [Description("The unique product identifier.")] int id,
        [Description("The product name.")] string name,
        [Description("The product price in USD.")] decimal price)
    {
        Id = id;
        Name = name;
        Price = price;
    }
}

// Generate schema with parameter descriptions
var exporterOptions = new JsonSchemaExporterOptions
{
    TransformSchemaNode = (context, schema) =>
    {
        if (schema is not JsonObject schemaObj || schemaObj.ContainsKey("$ref"))
        {
            return schema;
        }
        
        // Check property, parameter, and type for descriptions
        DescriptionAttribute? descriptionAttribute =
            GetCustomAttribute<DescriptionAttribute>(context.PropertyInfo?.AttributeProvider) ??
            GetCustomAttribute<DescriptionAttribute>(context.PropertyInfo?.AssociatedParameter?.AttributeProvider) ??
            GetCustomAttribute<DescriptionAttribute>(context.TypeInfo.Type);
        
        if (descriptionAttribute != null)
        {
            schemaObj.Insert(0, "description", (JsonNode)descriptionAttribute.Description);
        }
        
        return schemaObj;
    }
};

var options = new JsonSerializerOptions { PropertyNamingPolicy = JsonNamingPolicy.CamelCase };
JsonNode schema = JsonSchemaExporter.GetJsonSchemaAsNode(options, typeof(Product), exporterOptions);

// Schema includes descriptions from constructor parameters
string schemaJson = schema.ToJsonString(new JsonSerializerOptions { WriteIndented = true });
// {
//   "description": "A product with immutable properties.",
//   "type": "object",
//   "properties": {
//     "id": {
//       "description": "The unique product identifier.",
//       "type": "integer"
//     },
//     "name": {
//       "description": "The product name.",
//       "type": "string"
//     },
//     "price": {
//       "description": "The product price in USD.",
//       "type": "number"
//     }
//   },
//   "required": ["id", "name", "price"]
// }

static TAttribute? GetCustomAttribute<TAttribute>(
    ICustomAttributeProvider? provider, 
    bool inherit = false) where TAttribute : Attribute
    => provider?.GetCustomAttributes(typeof(TAttribute), inherit)
        .FirstOrDefault() as TAttribute;
```
