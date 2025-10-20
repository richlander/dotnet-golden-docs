# Inline Arrays
## Limitations and Considerations

### Runtime and Language Version Requirements

Inline arrays require C# 12 and .NET 8 or later:

```csharp
// Requires:
// - C# 12 language version
// - .NET 8+ runtime
// - System.Runtime.CompilerServices.InlineArrayAttribute

[InlineArray(10)]  // Error if not C# 12+
public struct Buffer10
{
    private int _element0;
}
```

Older runtimes and compilers don't support inline arrays.

### Single Field Requirement

Inline array types must declare exactly one instance field:

```csharp
// Error: Multiple fields
[InlineArray(10)]
public struct InvalidBuffer
{
    private int _element0;
    private int _element1;  // Error CS9169
}

// Error: No fields
[InlineArray(10)]
public struct InvalidBuffer2
{
    // Error CS9169
}

// Correct: Single field
[InlineArray(10)]
public struct ValidBuffer
{
    private int _element0;
}
```

### No Explicit Layout

Inline arrays cannot use explicit struct layout:

```csharp
// Error: Explicit layout not allowed
[StructLayout(LayoutKind.Explicit)]
[InlineArray(10)]
public struct InvalidBuffer
{
    [FieldOffset(0)]
    private int _element0;  // Error CS9168
}

// Correct: Use sequential or auto layout
[InlineArray(10)]
public struct ValidBuffer
{
    private int _element0;
}
```

### Length Must Be Constant

The inline array length must be a constant expression greater than zero:

```csharp
// Error: Non-constant length
public struct InvalidBuffer1
{
    const int Size = GetSize();  // Not constant
    
    [InlineArray(Size)]  // Error
    public struct Buffer
    {
        private int _element0;
    }
}

// Error: Zero or negative length
[InlineArray(0)]  // Error CS9167
public struct InvalidBuffer2
{
    private int _element0;
}

[InlineArray(-1)]  // Error CS9167
public struct InvalidBuffer3
{
    private int _element0;
}

// Correct: Positive constant
[InlineArray(10)]
public struct ValidBuffer
{
    private int _element0;
}
```
