# Async and Await
## Best Practices

### Use Async All the Way

Once you start async, keep it async throughout the call chain:

```csharp
// Good: Async all the way
public async Task<string> Controller_Action()
{
    var data = await Service_GetDataAsync();
    return await Processor_ProcessAsync(data);
}

// Bad: Mixing sync and async (can cause deadlocks)
public string Controller_Action()
{
    var data = Service_GetDataAsync().Result; // Blocking!
    return Processor_ProcessAsync(data).Result; // Blocking!
}
```

### Always Use CancellationToken

Pass cancellation tokens through async call chains:

```csharp
public async Task<Data> ProcessDataAsync(CancellationToken cancellationToken = default)
{
    var raw = await FetchDataAsync(cancellationToken);
    var processed = await TransformDataAsync(raw, cancellationToken);
    return processed;
}
```

### Avoid Async Void

Only use `async void` for event handlers:

```csharp
// Good: Event handler
private async void Button_Click(object sender, EventArgs e)
{
    await LoadDataAsync();
}

// Bad: Regular method
private async void LoadData() // Can't be awaited, swallows exceptions
{
    await FetchDataAsync();
}

// Good: Regular method
private async Task LoadDataAsync()
{
    await FetchDataAsync();
}
```

### Use ConfigureAwait(false) in Libraries

Library code should not capture synchronization context:

```csharp
// Library code
public async Task<Data> ProcessDataAsync()
{
    var data = await FetchDataAsync().ConfigureAwait(false);
    var result = await TransformDataAsync(data).ConfigureAwait(false);
    return result;
}

// Application code can omit ConfigureAwait (defaults to true)
public async Task UpdateUIAsync()
{
    var data = await FetchDataAsync();
    this.Label.Text = data.ToString(); // Can update UI
}
```
