# System.Text.Json.JsonSerializer
## Custom Enum Member Names

Specify custom names for enum values in JSON.

```csharp
using System.Text.Json.Serialization;

public enum OrderStatus
{
    [JsonStringEnumMemberName("pending_payment")]
    PendingPayment,
    
    [JsonStringEnumMemberName("processing")]
    Processing,
    
    [JsonStringEnumMemberName("shipped")]
    Shipped,
    
    [JsonStringEnumMemberName("delivered")]
    Delivered
}

public class Order
{
    public int Id { get; set; }
    public OrderStatus Status { get; set; }
}

var options = new JsonSerializerOptions
{
    Converters = { new JsonStringEnumConverter() }
};

var order = new Order { Id = 123, Status = OrderStatus.PendingPayment };
string json = JsonSerializer.Serialize(order, options);
// {"Id":123,"Status":"pending_payment"}

// Deserialize using custom name
string input = """{"Id":456,"Status":"shipped"}""";
Order? deserialized = JsonSerializer.Deserialize<Order>(input, options);
// deserialized.Status == OrderStatus.Shipped
```

## Disabling Reflection-Based Serialization

Require explicit JsonSerializerOptions to prevent accidental reflection use.

```csharp
// In your .csproj file:
// <PropertyGroup>
//   <JsonSerializerIsReflectionEnabledByDefault>false</JsonSerializerIsReflectionEnabledByDefault>
// </PropertyGroup>

// Check if reflection is enabled
bool isReflectionEnabled = JsonSerializer.IsReflectionEnabledByDefault;

if (!isReflectionEnabled)
{
    // Must provide options with source generation
    var user = new User { Id = 1, Name = "Alice" };
    
    // This throws NotSupportedException
    // string json = JsonSerializer.Serialize(user);
    
    // Must use options with TypeInfoResolver
    var options = new JsonSerializerOptions
    {
        TypeInfoResolver = AppJsonContext.Default
    };
    
    string json = JsonSerializer.Serialize(user, options);
}
```

## Freezing JsonSerializerOptions

Prevent modifications to options after configuration.

```csharp
var options = new JsonSerializerOptions
{
    PropertyNamingPolicy = JsonNamingPolicy.CamelCase,
    WriteIndented = true
};

// Check if options can be modified
bool isReadOnly = options.IsReadOnly;
Console.WriteLine($"Options read-only: {isReadOnly}"); // false

// Freeze the options
options.MakeReadOnly();

// Now options cannot be modified
try
{
    options.WriteIndented = false; // Throws InvalidOperationException
}
catch (InvalidOperationException ex)
{
    Console.WriteLine("Options are frozen and cannot be modified");
}

// Force freeze and populate defaults
var options2 = new JsonSerializerOptions();
options2.MakeReadOnly(populateMissingResolver: true);
```
