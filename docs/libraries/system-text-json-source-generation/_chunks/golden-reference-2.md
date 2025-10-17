# System.Text.Json Source Generation
## Multiple Contexts

Combine multiple contexts when working with types from different domains:

```csharp
[JsonSerializable(typeof(User))]
public partial class UserContext : JsonSerializerContext { }

[JsonSerializable(typeof(Product))]
public partial class ProductContext : JsonSerializerContext { }

// Combine contexts
var options = new JsonSerializerOptions
{
    TypeInfoResolver = JsonTypeInfoResolver.Combine(
        UserContext.Default,
        ProductContext.Default)
};

// Use with any registered type
var userJson = JsonSerializer.Serialize(user, options);
var productJson = JsonSerializer.Serialize(product, options);
```

## Using with ASP.NET Core Web APIs

Configure source generation for all API responses:

```csharp
// Program.cs
var builder = WebApplication.CreateBuilder(args);

builder.Services.ConfigureHttpJsonOptions(options =>
{
    options.SerializerOptions.TypeInfoResolver = JsonTypeInfoResolver.Combine(
        UserContext.Default,
        ProductContext.Default);
});

var app = builder.Build();

// Endpoints automatically use source generation
app.MapGet("/users/{id}", (int id) =>
{
    var user = GetUser(id);
    return Results.Ok(user); // Uses UserContext.Default.User
});

app.MapPost("/users", (User user) =>
{
    SaveUser(user); // Deserializes using UserContext.Default.User
    return Results.Created($"/users/{user.Id}", user);
});
```

## Using with HttpClient JSON Operations

Use source generation with HttpClient extension methods:

```csharp
// Direct usage with JsonTypeInfo<T>
var user = await httpClient.GetFromJsonAsync(
    "https://api.example.com/users/123",
    ApiJsonContext.Default.User);

await httpClient.PostAsJsonAsync(
    "https://api.example.com/users",
    newUser,
    ApiJsonContext.Default.User);

// Or configure options
var options = new JsonSerializerOptions
{
    TypeInfoResolver = ApiJsonContext.Default
};

var users = await httpClient.GetFromJsonAsync<List<User>>(
    "https://api.example.com/users",
    options);
```

### AI Structured Responses

Microsoft.Extensions.AI supports source generation for chat responses:

```csharp
public class WeatherForecast
{
    public string Location { get; set; } = string.Empty;
    public int Temperature { get; set; }
    public string Conditions { get; set; } = string.Empty;
}

[JsonSerializable(typeof(WeatherForecast))]
[JsonSourceGenerationOptions(PropertyNamingPolicy = JsonKnownNamingPolicy.SnakeCaseLower)]
public partial class AiJsonContext : JsonSerializerContext { }

// Get structured chat response
IChatClient client = GetChatClient();
var response = await client.GetResponseAsync<WeatherForecast>(
    "What's the weather in Seattle?",
    serializerOptions: AiJsonContext.Default.Options);

Console.WriteLine($"Temperature: {response.Result.Temperature}°F");
```
