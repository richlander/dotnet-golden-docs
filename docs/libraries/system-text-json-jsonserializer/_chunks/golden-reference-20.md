# System.Text.Json.JsonSerializer
## Contract Customization

Customize serialization contracts for advanced scenarios.

```csharp
using System.Text.Json.Serialization.Metadata;

public class Person
{
    public string Name { get; set; } = string.Empty;
    public int Age { get; set; }
    public string Email { get; set; } = string.Empty;
}

var options = new JsonSerializerOptions();

// Customize the contract
options.TypeInfoResolver = new DefaultJsonTypeInfoResolver
{
    Modifiers =
    {
        static typeInfo =>
        {
            if (typeInfo.Type == typeof(Person))
            {
                // Find the Email property
                var emailProperty = typeInfo.Properties
                    .FirstOrDefault(p => p.Name == "Email");
                
                if (emailProperty != null)
                {
                    // Add custom get logic to mask email
                    var originalGetter = emailProperty.Get;
                    emailProperty.Get = obj =>
                    {
                        string? email = originalGetter?.Invoke(obj) as string;
                        if (!string.IsNullOrEmpty(email) && email.Contains('@'))
                        {
                            var parts = email.Split('@');
                            return $"{parts[0][0]}***@{parts[1]}";
                        }
                        return email;
                    };
                }
            }
        }
    }
};

var person = new Person 
{ 
    Name = "Alice", 
    Age = 30, 
    Email = "alice@example.com" 
};

string json = JsonSerializer.Serialize(person, options);
// {"Name":"Alice","Age":30,"Email":"a***@example.com"}
```

## Chaining Type Resolvers

Combine multiple source generation contexts.

```csharp
using System.Text.Json.Serialization.Metadata;

[JsonSerializable(typeof(User))]
public partial class UserContext : JsonSerializerContext { }

[JsonSerializable(typeof(Product))]
public partial class ProductContext : JsonSerializerContext { }

var options = new JsonSerializerOptions();

// Add resolvers to chain
options.TypeInfoResolverChain.Add(UserContext.Default);
options.TypeInfoResolverChain.Add(ProductContext.Default);

// Can serialize both User and Product
var user = new User { Id = 1, Name = "Alice" };
var product = new Product { Id = 100, Name = "Widget" };

string userJson = JsonSerializer.Serialize(user, options);
string productJson = JsonSerializer.Serialize(product, options);

// Can introspect and modify chain
Console.WriteLine($"Resolver count: {options.TypeInfoResolverChain.Count}");

// Remove a resolver if needed
options.TypeInfoResolverChain.RemoveAt(1);
```
