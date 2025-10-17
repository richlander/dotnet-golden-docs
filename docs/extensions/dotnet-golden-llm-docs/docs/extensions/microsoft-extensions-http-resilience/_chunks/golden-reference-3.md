# Microsoft.Extensions.Http.Resilience
## Microservices Communication Reliability
### API Gateway Resilience Pattern

```csharp
public class ApiGatewayService
{
    private readonly Dictionary<string, HttpClient> _serviceClients;

    public ApiGatewayService(IHttpClientFactory factory)
    {
        _serviceClients = new Dictionary<string, HttpClient>
        {
            ["users"] = factory.CreateClient("UserService"),
            ["orders"] = factory.CreateClient("OrderService"),
            ["catalog"] = factory.CreateClient("CatalogService")
        };
    }

    public async Task<AggregatedResponse> GetDashboardDataAsync(string userId)
    {
        // Execute multiple service calls with resilience
        var tasks = new Dictionary<string, Task<HttpResponseMessage>>
        {
            ["user"] = _serviceClients["users"].GetAsync($"/api/users/{userId}"),
            ["orders"] = _serviceClients["orders"].GetAsync($"/api/orders/user/{userId}"),
            ["recommendations"] = _serviceClients["catalog"].GetAsync($"/api/recommendations/{userId}")
        };

        // Wait for all with timeout
        await Task.WhenAll(tasks.Values);

        var result = new AggregatedResponse();

        foreach (var task in tasks)
        {
            try
            {
                var response = await task.Value;
                if (response.IsSuccessStatusCode)
                {
                    result.Data[task.Key] = await response.Content.ReadAsStringAsync();
                }
                else
                {
                    result.Failures[task.Key] = $"HTTP {response.StatusCode}";
                }
            }
            catch (Exception ex)
            {
                result.Failures[task.Key] = ex.Message;
            }
        }

        return result;
    }
}
```

### External API Integration with Fallbacks

```csharp
public class WeatherService
{
    private readonly HttpClient _primaryWeatherClient;
    private readonly HttpClient _fallbackWeatherClient;
    private readonly IMemoryCache _cache;

    public async Task<WeatherData> GetWeatherAsync(string location)
    {
        // Try primary service with resilience
        try
        {
            var response = await _primaryWeatherClient.GetAsync($"/api/weather/{location}");
            if (response.IsSuccessStatusCode)
            {
                var data = await response.Content.ReadFromJsonAsync<WeatherData>();
                _cache.Set($"weather:{location}", data, TimeSpan.FromMinutes(30));
                return data;
            }
        }
        catch (Exception ex) when (IsRetryableException(ex))
        {
            // Primary service failed after retries, try fallback
        }

        // Try fallback service
        try
        {
            var response = await _fallbackWeatherClient.GetAsync($"/weather?q={location}");
            if (response.IsSuccessStatusCode)
            {
                return await response.Content.ReadFromJsonAsync<WeatherData>();
            }
        }
        catch
        {
            // Both services failed, return cached data if available
        }

        // Return cached data as last resort
        if (_cache.TryGetValue($"weather:{location}", out WeatherData cached))
        {
            return cached;
        }

        throw new WeatherServiceUnavailableException("All weather services are currently unavailable");
    }
}
```
