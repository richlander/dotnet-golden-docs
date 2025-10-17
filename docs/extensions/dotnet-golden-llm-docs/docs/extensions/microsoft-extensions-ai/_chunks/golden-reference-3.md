# Microsoft.Extensions.AI
## Multi-Turn Conversation Management

```csharp
var messages = new List<ChatMessage>();

while (true)
{
    Console.Write("You: ");
    string userInput = Console.ReadLine();
    if (string.IsNullOrEmpty(userInput)) break;

    messages.Add(new ChatMessage(ChatRole.User, userInput));

    var response = await client.GetResponseAsync(messages);
    Console.WriteLine($"AI: {response.Message.Text}");

    // Add response to conversation history
    messages.AddRange(response.Messages);
}
```

## Structured Output with Function Calling

```csharp
public record WeatherInfo(string Location, int Temperature, string Conditions);

WeatherInfo GetWeatherData(string location)
{
    // Simulate weather API call
    return new WeatherInfo(location, 75, "Sunny");
}

var tools = new List<AIFunction>
{
    AIFunctionFactory.Create(GetWeatherData)
};

var response = await client.GetResponseAsync(
    "Get me weather data for New York in a structured format",
    new ChatOptions { Tools = tools }
);
```

## Caching AI Responses

```csharp
services.AddMemoryCache();
services.AddSingleton<IChatClient>(serviceProvider =>
{
    var underlyingClient = new OpenAIChatClient();
    var cache = serviceProvider.GetRequiredService<IMemoryCache>();

    return new ChatClientBuilder()
        .UseDistributedCache(new MemoryDistributedCache(Options.Create(new MemoryDistributedCacheOptions())))
        .Use(underlyingClient)
        .Build();
});
```

## Cross-Provider Switching

```csharp
// Configuration-driven provider selection
IChatClient client = configuration["AIProvider"] switch
{
    "OpenAI" => new OpenAIChatClient(apiKey),
    "Azure" => new AzureOpenAIChatClient(endpoint, apiKey),
    "Local" => new OllamaChatClient(baseUri),
    _ => throw new InvalidOperationException("Unknown AI provider")
};

// Application code remains the same regardless of provider
var response = await client.GetResponseAsync("Hello, world!");
```

## Telemetry and Observability

```csharp
services.AddOpenTelemetry()
    .WithTracing(builder => builder.AddSource("Microsoft.Extensions.AI"));

var client = new ChatClientBuilder()
    .UseOpenTelemetry(loggerFactory, "MyApp")
    .Use(underlyingClient)
    .Build();

// All AI interactions are automatically traced
var response = await client.GetResponseAsync("Analyze this data");
```
