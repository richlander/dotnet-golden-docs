# Async and Await
## Relationships & Integration
### Error Handling

```csharp
public async Task<string> FetchDataWithErrorHandlingAsync(string url)
{
    try
    {
        using var client = new HttpClient();
        return await client.GetStringAsync(url);
    }
    catch (HttpRequestException ex)
    {
        Console.WriteLine($"Request failed: {ex.Message}");
        return string.Empty;
    }
    catch (TaskCanceledException ex)
    {
        Console.WriteLine($"Request timeout: {ex.Message}");
        return string.Empty;
    }
}
```

### Cancellation Support

```csharp
public async Task<string> FetchDataAsync(string url, CancellationToken cancellationToken)
{
    using var client = new HttpClient();
    
    // Pass cancellation token to async operations
    return await client.GetStringAsync(url, cancellationToken);
}

// Usage with timeout
var cts = new CancellationTokenSource(TimeSpan.FromSeconds(30));

try
{
    string data = await FetchDataAsync("https://api.example.com", cts.Token);
    Console.WriteLine(data);
}
catch (OperationCanceledException)
{
    Console.WriteLine("Operation was cancelled");
}
```

### ConfigureAwait

```csharp
// Library code - don't capture synchronization context
public async Task<Data> ProcessDataAsync()
{
    var raw = await FetchRawDataAsync().ConfigureAwait(false);
    var processed = await TransformDataAsync(raw).ConfigureAwait(false);
    return processed;
}

// UI code - capture context to update UI
public async Task LoadDataAsync()
{
    var data = await FetchDataAsync(); // Captures context by default
    this.DataLabel.Text = data.ToString(); // Can update UI safely
}
```

### Async Void (Event Handlers Only)

```csharp
// Async void for event handlers only
private async void Button_Click(object sender, EventArgs e)
{
    try
    {
        await LoadDataAsync();
    }
    catch (Exception ex)
    {
        MessageBox.Show($"Error: {ex.Message}");
    }
}

// Avoid async void for other methods - use async Task instead
```

## Relationships & Integration

### Task and Task&lt;T&gt;

`async` and `await` work with the `Task` type, which represents asynchronous operations:

```csharp
// Async method returns Task<T>
public async Task<int> GetValueAsync()
{
    await Task.Delay(100);
    return 42;
}

// Task represents the ongoing operation
Task<int> task = GetValueAsync();

// Await the task to get the result
int value = await task;

// Can also check status without awaiting
if (task.IsCompleted)
{
    int result = task.Result; // Don't block in async code
}
```
