# System.Text.Json.JsonSerializer
## Handling Collections

Serialize and deserialize arrays, lists, and dictionaries.

```csharp
// Arrays
int[] numbers = { 1, 2, 3, 4, 5 };
string arrayJson = JsonSerializer.Serialize(numbers);
int[]? deserialized = JsonSerializer.Deserialize<int[]>(arrayJson);

// Lists
var users = new List<User>
{
    new() { Id = 1, Name = "Alice" },
    new() { Id = 2, Name = "Bob" }
};
string listJson = JsonSerializer.Serialize(users);
List<User>? userList = JsonSerializer.Deserialize<List<User>>(listJson);

// Dictionaries
var config = new Dictionary<string, string>
{
    ["host"] = "localhost",
    ["port"] = "8080",
    ["debug"] = "true"
};
string dictJson = JsonSerializer.Serialize(config);
Dictionary<string, string>? configDict = JsonSerializer.Deserialize<Dictionary<string, string>>(dictJson);
// {"host":"localhost","port":"8080","debug":"true"}

// Dictionary with complex values
var users = new Dictionary<int, User>
{
    [1] = new() { Id = 1, Name = "Alice" },
    [2] = new() { Id = 2, Name = "Bob" }
};
string usersJson = JsonSerializer.Serialize(users);
// {"1":{"Id":1,"Name":"Alice"},"2":{"Id":2,"Name":"Bob"}}
```

## Working with Records

Serialize and deserialize C# records.

```csharp
// Positional record
public record Product(int Id, string Name, decimal Price);

var product = new Product(1, "Widget", 29.99m);
string json = JsonSerializer.Serialize(product);
// {"Id":1,"Name":"Widget","Price":29.99}

Product? deserialized = JsonSerializer.Deserialize<Product>(json);

// Record with optional properties
public record User
{
    public required int Id { get; init; }
    public required string Name { get; init; }
    public string? Email { get; init; }
}

var user = new User { Id = 1, Name = "Alice", Email = "alice@example.com" };
string userJson = JsonSerializer.Serialize(user);
```
