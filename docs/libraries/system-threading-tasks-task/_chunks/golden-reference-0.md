# Task and Task&lt;T&gt;

## Overview

`Task` and `Task<T>` are types that represent asynchronous operations in .NET. They are the foundation of the Task-based Asynchronous Pattern (TAP) and work with the `async` and `await` keywords to enable non-blocking, composable asynchronous code.

A `Task` represents an ongoing operation that produces no value, while `Task<T>` represents an operation that will eventually produce a value of type `T`. These types provide a consistent way to handle asynchronous operations across the .NET ecosystem, from I/O operations to background computations.

```csharp
// Task<T> represents an operation that returns a value
Task<string> fetchTask = client.GetStringAsync("https://api.example.com");
string result = await fetchTask;

// Task represents an operation with no return value
Task saveTask = File.WriteAllTextAsync("data.txt", result);
await saveTask;

// Check task status
Console.WriteLine($"Is completed: {fetchTask.IsCompleted}");
Console.WriteLine($"Status: {fetchTask.Status}");
```

### Key Advantages

- **Unified async model**: Consistent pattern across all async APIs in .NET
- **Composability**: Chain and combine async operations easily
- **State tracking**: Monitor task status, cancellation, and completion
- **Exception handling**: Exceptions propagate naturally through await
- **Continuations**: Schedule work to run after task completion
- **Flexibility**: Support both I/O-bound and CPU-bound scenarios

### Main Approaches

**Creating Tasks**:
- `async/await` methods automatically return Task
- `Task.Run` for offloading CPU-bound work
- `Task.FromResult` for synchronous completion
- `TaskCompletionSource` for manual task control
- Constructor-based creation (legacy, avoid)

**Consuming Tasks**:
- `await` keyword for async consumption
- `Task.Wait()` for blocking (avoid in async code)
- `Task.Result` for getting value synchronously (avoid deadlocks)
- `ContinueWith` for continuations (prefer await)
