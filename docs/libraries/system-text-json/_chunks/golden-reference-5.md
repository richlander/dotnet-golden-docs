# System.Text.Json
## ASP.NET Core Integration

ASP.NET Core uses System.Text.Json as the default serializer for web APIs, Minimal APIs, and MVC. Source generation provides significant performance improvements for API responses since response types are known at compile time.

**Configure globally:**

```csharp
// In Program.cs - applies to all API responses
services.ConfigureHttpJsonOptions(options =>
{
    options.SerializerOptions.TypeInfoResolver = AppJsonContext.Default;
    options.SerializerOptions.PropertyNamingPolicy = JsonNamingPolicy.CamelCase;
});
```

**Define serialization context:**

```csharp
[JsonSerializable(typeof(User))]
[JsonSerializable(typeof(List<Product>))]
[JsonSerializable(typeof(ApiResponse))]
[JsonSerializable(typeof(ErrorDetails))]
internal partial class AppJsonContext : JsonSerializerContext { }
```

**Controllers automatically use configuration:**

```csharp
[ApiController]
[Route("api/[controller]")]
public class UsersController : ControllerBase
{
    // Return type uses source generation automatically
    [HttpGet("{id}")]
    public ActionResult<User> GetUser(int id)
    {
        return userService.GetUser(id);
    }

    // Request body deserialization uses source generation
    [HttpPost]
    public ActionResult<User> CreateUser(User user)
    {
        return userService.Create(user);
    }
}
```

**Minimal APIs:**

```csharp
app.MapGet("/users/{id}", (int id, IUserService users) =>
    Results.Ok(users.GetUser(id)));

app.MapPost("/users", (User user, IUserService users) =>
    Results.Created($"/users/{user.Id}", users.Create(user)));
```

Both controller and Minimal API endpoints automatically benefit from source generation configuration without code changes.

**Web defaults:**

Use `JsonSerializerOptions.Web` to match ASP.NET Core conventions outside of web API context:

```csharp
// Apply web conventions (camelCase, case-insensitive)
string json = JsonSerializer.Serialize(data, JsonSerializerOptions.Web);
```

## HttpClient Extensions

HttpClient JSON extension methods combine HTTP requests with JSON serialization/deserialization, reducing boilerplate for API calls. They support source generation when configured with `JsonSerializerOptions`.

**Basic usage:**

```csharp
// GET with deserialization
var user = await httpClient.GetFromJsonAsync<User>("https://api.example.com/users/123");

// POST with serialization
var response = await httpClient.PostAsJsonAsync("https://api.example.com/users", newUser);

// PUT with serialization
await httpClient.PutAsJsonAsync("https://api.example.com/users/123", updatedUser);

// PATCH with serialization
await httpClient.PatchAsJsonAsync("https://api.example.com/users/123", partialUpdate);
```

**With source generation:**

```csharp
// Configure HttpClient with source generation context
services.AddHttpClient("ApiClient", client =>
{
    client.BaseAddress = new Uri("https://api.example.com");
})
.AddJsonHttpMessageConverter(options =>
{
    options.SerializerOptions.TypeInfoResolver = AppJsonContext.Default;
});

// Extension methods use source generation automatically
var users = await httpClient.GetFromJsonAsync<List<User>>("/users");
```

**Per-request options:**

```csharp
var options = new JsonSerializerOptions 
{ 
    PropertyNameCaseInsensitive = true,
    TypeInfoResolver = AppJsonContext.Default
};

var data = await httpClient.GetFromJsonAsync<Data>("/data", options);
```

**Direct JsonTypeInfo for compile-time safety:**

```csharp
// Type mismatch caught at compile time
var user = await httpClient.GetFromJsonAsync(
    "https://api.example.com/users/123",
    AppJsonContext.Default.User);
```
