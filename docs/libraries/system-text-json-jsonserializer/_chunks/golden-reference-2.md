# System.Text.Json.JsonSerializer
## Async File Operations

Read and write JSON files asynchronously.

```csharp
public class DataService
{
    public async Task SaveToFileAsync<T>(string filePath, T data)
    {
        await using FileStream stream = File.Create(filePath);
        await JsonSerializer.SerializeAsync(stream, data);
    }
    
    public async Task<T?> LoadFromFileAsync<T>(string filePath)
    {
        await using FileStream stream = File.OpenRead(filePath);
        return await JsonSerializer.DeserializeAsync<T>(stream);
    }
}

// Usage
var service = new DataService();
var user = new User { Id = 1, Name = "Alice", Email = "alice@example.com" };

// Write to file
await service.SaveToFileAsync("user.json", user);

// Read from file
User? loadedUser = await service.LoadFromFileAsync<User>("user.json");
```

## Configuring Naming Policies

Control how property names are formatted in JSON.

```csharp
public class ApiResponse
{
    public int UserId { get; set; }
    public string FirstName { get; set; } = string.Empty;
    public string LastName { get; set; } = string.Empty;
}

var response = new ApiResponse
{
    UserId = 123,
    FirstName = "Alice",
    LastName = "Smith"
};

// Default: PascalCase property names
string defaultJson = JsonSerializer.Serialize(response);
// {"UserId":123,"FirstName":"Alice","LastName":"Smith"}

// camelCase naming policy
var camelCaseOptions = new JsonSerializerOptions
{
    PropertyNamingPolicy = JsonNamingPolicy.CamelCase
};
string camelCaseJson = JsonSerializer.Serialize(response, camelCaseOptions);
// {"userId":123,"firstName":"Alice","lastName":"Smith"}

// snake_case_lower naming policy
var snakeCaseOptions = new JsonSerializerOptions
{
    PropertyNamingPolicy = JsonNamingPolicy.SnakeCaseLower
};
string snakeCaseJson = JsonSerializer.Serialize(response, snakeCaseOptions);
// {"user_id":123,"first_name":"Alice","last_name":"Smith"}

// kebab-case-lower naming policy
var kebabCaseOptions = new JsonSerializerOptions
{
    PropertyNamingPolicy = JsonNamingPolicy.KebabCaseLower
};
string kebabCaseJson = JsonSerializer.Serialize(response, kebabCaseOptions);
// {"user-id":123,"first-name":"Alice","last-name":"Smith"}
```
