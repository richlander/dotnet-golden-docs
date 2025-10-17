# Lambda Expressions
## Statement Lambdas

Statement lambdas use a block of statements enclosed in braces. Explicit `return` statements are required for non-void lambdas.

```csharp
Func<int, int> factorial = n =>
{
    int result = 1;
    for (int i = 2; i <= n; i++)
        result *= i;
    return result;
};

Action<string> log = message =>
{
    Console.WriteLine($"[{DateTime.Now}] {message}");
};
```

**With event handlers:**

```csharp
button.Click += (sender, e) =>
{
    var button = (Button)sender;
    button.Text = "Clicked!";
    button.Enabled = false;
};
```

## Natural Type Inference

Lambdas can have a natural type when the compiler can infer the delegate type from the lambda's signature.

```csharp
// Compiler infers Func<string, int>
var parse = (string s) => int.Parse(s);

// Can assign to object or Delegate
object obj = (string s) => int.Parse(s);
Delegate del = (string s) => int.Parse(s);

// Method groups with one overload have natural type
var read = Console.Read; // Func<int>
```

**Without natural type (requires explicit delegate type):**

```csharp
// Multiple overloads - can't infer
// var write = Console.Write; // Error

// Must specify the delegate type
Action<string> write = Console.Write;
```

## Parameter Modifiers

Lambdas support `ref`, `out`, `in`, and `params` modifiers on parameters. Since C# 14, modifiers can be used without explicit parameter types.

**ref parameters** - Pass by reference for mutation:

```csharp
delegate void Transform(ref int value);
Transform double = (ref int x) => x *= 2;

int num = 5;
double(ref num);
Console.WriteLine(num); // 10
```

**out parameters** - Return multiple values:

```csharp
var tryParse = (string text, out int result) => int.TryParse(text, out result);

if (tryParse("123", out int value))
    Console.WriteLine(value);
```

**in parameters** - Read-only reference for large structs:

```csharp
delegate double Calculate(in Matrix matrix);
Calculate determinant = (in Matrix m) => m.Determinant();
```

**params parameters** - Variable arguments (requires explicit type):

```csharp
Func<int[], int> sum = (params int[] numbers) => numbers.Sum();
var total = sum(1, 2, 3, 4, 5);
```
