# System.Text.Json.JsonSerializer
## Serialization Callbacks
### Thread Safety

`JsonSerializerOptions` instances are immutable after first use and safe to share across threads. Creating options is relatively expensive, so reuse instances when possible.

## Property Ordering

Control the order in which properties are serialized.

```csharp
using System.Text.Json.Serialization;

public class Product
{
    [JsonPropertyOrder(3)]
    public int Id { get; set; }
    
    [JsonPropertyOrder(1)]
    public string Name { get; set; } = string.Empty;
    
    [JsonPropertyOrder(2)]
    public decimal Price { get; set; }
    
    // Properties without order appear after ordered properties
    public string Description { get; set; } = string.Empty;
}

var product = new Product
{
    Id = 1,
    Name = "Widget",
    Price = 29.99m,
    Description = "A useful widget"
};

string json = JsonSerializer.Serialize(product);
// {"Name":"Widget","Price":29.99,"Id":1,"Description":"A useful widget"}
```

## Serialization Callbacks

Execute custom logic before or after serialization and deserialization.

```csharp
using System.Text.Json.Serialization;

public class AuditedEntity : 
    IJsonOnSerializing, 
    IJsonOnSerialized,
    IJsonOnDeserializing,
    IJsonOnDeserialized
{
    public int Id { get; set; }
    public string Name { get; set; } = string.Empty;
    
    [JsonIgnore]
    public DateTime LastSerialized { get; private set; }
    
    void IJsonOnSerializing.OnSerializing()
    {
        Console.WriteLine($"About to serialize entity {Id}");
    }
    
    void IJsonOnSerialized.OnSerialized()
    {
        LastSerialized = DateTime.UtcNow;
        Console.WriteLine($"Finished serializing entity {Id}");
    }
    
    void IJsonOnDeserializing.OnDeserializing()
    {
        Console.WriteLine("Starting deserialization");
    }
    
    void IJsonOnDeserialized.OnDeserialized()
    {
        Console.WriteLine($"Deserialized entity {Id}: {Name}");
        ValidateState();
    }
    
    private void ValidateState()
    {
        if (string.IsNullOrEmpty(Name))
            throw new InvalidOperationException("Name cannot be empty");
    }
}
```
