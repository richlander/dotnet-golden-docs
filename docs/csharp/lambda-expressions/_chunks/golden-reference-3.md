# Lambda Expressions
## Default Parameters

Lambda expressions can declare default parameter values (C# 12).

```csharp
var increment = (int value, int step = 1) => value + step;

Console.WriteLine(increment(5));    // 6 (uses default step=1)
Console.WriteLine(increment(5, 3)); // 8 (uses step=3)
```

Default parameters work with method groups:

```csharp
static int Add(int a, int b = 0) => a + b;

var add = Add; // Lambda has default parameter
Console.WriteLine(add(5));    // 5
Console.WriteLine(add(5, 3)); // 8
```

## Static Lambdas

The `static` modifier prevents a lambda from capturing local variables or instance state. This helps avoid unintended allocations and memory leaks.

```csharp
int multiplier = 2;

// Regular lambda captures 'multiplier'
Func<int, int> multiply1 = x => x * multiplier; // Allocates closure

// Static lambda prevents capture
// Func<int, int> multiply2 = static x => x * multiplier; // Error

// Static lambda with const is valid
const int factor = 2;
Func<int, int> multiply3 = static x => x * factor; // OK
```

**Use static lambdas when:**

- Lambda doesn't need to capture variables
- Performance-critical code (avoids closure allocation)
- Preventing accidental captures

## Async Lambdas

Lambdas can use `async` and `await` for asynchronous operations.

```csharp
Func<Task<string>> getData = async () =>
{
    using var client = new HttpClient();
    return await client.GetStringAsync("https://api.example.com/data");
};

// Event handler with async lambda
button.Click += async (sender, e) =>
{
    button.Enabled = false;
    try
    {
        var data = await FetchDataAsync();
        label.Text = data;
    }
    finally
    {
        button.Enabled = true;
    }
};
```

**Async lambda returning void (fire-and-forget):**

```csharp
Action fireAndForget = async () =>
{
    await Task.Delay(1000);
    Console.WriteLine("Completed");
};
```
