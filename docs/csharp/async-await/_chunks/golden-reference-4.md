# Async and Await
## Common Scenarios
### File I/O Integration

.NET provides async methods for file operations:

```csharp
// Read file asynchronously
public async Task<string> ReadFileAsync(string path)
{
    return await File.ReadAllTextAsync(path);
}

// Write file asynchronously
public async Task WriteFileAsync(string path, string content)
{
    await File.WriteAllTextAsync(path, content);
}

// Stream file reading
public async Task<List<string>> ReadLinesAsync(string path)
{
    var lines = new List<string>();
    
    using var reader = new StreamReader(path);
    string line;
    while ((line = await reader.ReadLineAsync()) != null)
    {
        lines.Add(line);
    }
    
    return lines;
}
```

### HttpClient Integration

HttpClient is designed for async operations:

```csharp
public async Task<Product> GetProductAsync(int id)
{
    using var client = new HttpClient();
    return await client.GetFromJsonAsync<Product>($"https://api.example.com/products/{id}");
}

public async Task<string> PostDataAsync(string url, object data)
{
    using var client = new HttpClient();
    var response = await client.PostAsJsonAsync(url, data);
    response.EnsureSuccessStatusCode();
    return await response.Content.ReadAsStringAsync();
}
```

## Common Scenarios

### Web API Request with Error Handling

**When to use**: Making HTTP requests with proper error handling and timeouts.

```csharp
public async Task<ApiResponse<T>> CallApiAsync<T>(string url)
{
    using var client = new HttpClient();
    using var cts = new CancellationTokenSource(TimeSpan.FromSeconds(30));
    
    try
    {
        var response = await client.GetAsync(url, cts.Token);
        response.EnsureSuccessStatusCode();
        
        var data = await response.Content.ReadFromJsonAsync<T>(cancellationToken: cts.Token);
        
        return new ApiResponse<T>
        {
            Success = true,
            Data = data
        };
    }
    catch (HttpRequestException ex)
    {
        return new ApiResponse<T>
        {
            Success = false,
            Error = $"HTTP error: {ex.Message}"
        };
    }
    catch (OperationCanceledException)
    {
        return new ApiResponse<T>
        {
            Success = false,
            Error = "Request timeout"
        };
    }
}
```

**Considerations**: Always use cancellation tokens and handle timeouts appropriately.
