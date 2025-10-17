# System.Text.Json.JsonDocument
## Converting to Strongly-Typed Objects

Deserialize specific portions of JSON into strongly-typed objects.

```csharp
public record UserProfile(string Name, string Email, int Age);

string json = """
{
    "user": {
        "name": "Alice",
        "email": "alice@example.com",
        "age": 30
    },
    "timestamp": "2024-01-15T10:30:00Z",
    "metadata": {"source": "api"}
}
""";

using JsonDocument doc = JsonDocument.Parse(json);
JsonElement root = doc.RootElement;

// Get raw JSON text of specific element
JsonElement userElement = root.GetProperty("user");
string userJson = userElement.GetRawText();

// Deserialize just that portion
UserProfile profile = JsonSerializer.Deserialize<UserProfile>(userJson)!;

Console.WriteLine($"{profile.Name} is {profile.Age} years old");
```

## Cloning JsonElement

JsonElement references memory owned by JsonDocument. To retain values beyond document lifetime, extract them or clone the raw JSON.

```csharp
string json = """{"name":"Alice","settings":{"theme":"dark"}}""";

// JsonElement becomes invalid after Dispose
JsonElement capturedElement;
using (JsonDocument doc = JsonDocument.Parse(json))
{
    JsonElement root = doc.RootElement;
    
    // Wrong: Element references disposed memory
    // capturedElement = root.GetProperty("settings");
    
    // Right: Extract the value
    string settingsJson = root.GetProperty("settings").GetRawText();
    
    // Or parse into new document
    using JsonDocument settingsDoc = JsonDocument.Parse(settingsJson);
    capturedElement = settingsDoc.RootElement.Clone();
}

// Clone creates a copy that outlives the original document
// Clone allocates new memory, losing the pooling benefit
```

## Using with Webhook Routing

Route webhook events based on event type without deserializing entire payload.

```csharp
public async Task ProcessWebhook(HttpRequest request)
{
    using Stream body = request.Body;
    using JsonDocument doc = await JsonDocument.ParseAsync(body);
    JsonElement root = doc.RootElement;
    
    // Extract event type for routing
    string eventType = root.GetProperty("event_type").GetString()!;
    
    // Route based on event type
    switch (eventType)
    {
        case "order.created":
            JsonElement orderData = root.GetProperty("data");
            string orderJson = orderData.GetRawText();
            Order order = JsonSerializer.Deserialize<Order>(orderJson)!;
            await ProcessOrder(order);
            break;
            
        case "user.updated":
            JsonElement userData = root.GetProperty("data");
            string userJson = userData.GetRawText();
            User user = JsonSerializer.Deserialize<User>(userJson)!;
            await UpdateUser(user);
            break;
            
        case "payment.completed":
            JsonElement paymentData = root.GetProperty("data");
            string paymentJson = paymentData.GetRawText();
            Payment payment = JsonSerializer.Deserialize<Payment>(paymentJson)!;
            await ProcessPayment(payment);
            break;
            
        default:
            throw new NotSupportedException($"Unknown event type: {eventType}");
    }
}
```
