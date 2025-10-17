# Async and Await

## Overview

The `async` and `await` keywords enable asynchronous programming in C#, allowing you to write non-blocking code that appears synchronous. This programming model makes it straightforward to handle I/O-bound operations (network requests, file access, database queries) without blocking threads, improving application responsiveness and scalability.

Async/await represents a fundamental shift in how .NET handles asynchronous operations. Instead of callbacks or blocking waits, you write linear code that the compiler transforms into a state machine, enabling efficient cooperative multitasking.

```csharp
// Asynchronous method using async/await
public async Task<string> FetchDataAsync(string url)
{
    using var client = new HttpClient();
    string content = await client.GetStringAsync(url);
    return content;
}

// Calling async method
string data = await FetchDataAsync("https://api.example.com/data");
Console.WriteLine(data);
```

### Key Advantages

- **Non-blocking execution**: Free up threads while waiting for I/O operations
- **Improved scalability**: Handle more concurrent operations with fewer threads
- **Responsive UI**: Keep applications responsive during long-running operations
- **Linear code flow**: Write async code that looks like synchronous code
- **Composability**: Easily chain and combine async operations
- **Exception handling**: Use try/catch with async operations naturally

### Main Approaches

**Task-based async methods**:
- Use `async Task` for methods that perform async work and return no value
- Use `async Task<T>` for methods that return a value
- Use `async ValueTask<T>` for high-performance scenarios
- Use `async void` only for event handlers (avoid otherwise)

**Consuming async operations**:
- `await` expressions to wait for async operations
- `Task.WhenAll` for concurrent operations
- `Task.WhenAny` for race conditions or timeouts
- Async LINQ with `IAsyncEnumerable<T>`
