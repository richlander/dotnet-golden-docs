# Span-Based String Processing
## UTF-8 String Literals with Spans

Use UTF-8 string literals for direct byte processing:

```csharp
// UTF-8 string literal - type is ReadOnlySpan<byte>
ReadOnlySpan<byte> greeting = "Hello, World!"u8;

// Process as UTF-8 bytes without conversion
static void WriteUtf8(ReadOnlySpan<byte> utf8Data)
{
    // Direct UTF-8 processing
    Console.OutputEncoding = System.Text.Encoding.UTF8;
    foreach (byte b in utf8Data)
    {
        Console.Write($"{b:X2} ");
    }
}

WriteUtf8(greeting);

// Pattern matching on UTF-8 spans
static bool StartsWithHttp(ReadOnlySpan<byte> url)
{
    return url.StartsWith("http://"u8) || url.StartsWith("https://"u8);
}
```

## First-Class Span Conversions (C# 14)

C# 14 provides implicit conversions for span types:

```csharp
// Implicit conversion from array to Span<T>
void ProcessData(Span<int> data)
{
    for (int i = 0; i < data.Length; i++)
    {
        data[i] *= 2;
    }
}

int[] numbers = { 1, 2, 3, 4, 5 };
ProcessData(numbers);  // Implicit conversion to Span<int>

// Implicit conversion from string to ReadOnlySpan<char>
void PrintLength(ReadOnlySpan<char> text)
{
    Console.WriteLine($"Length: {text.Length}");
}

PrintLength("Hello");  // Implicit conversion to ReadOnlySpan<char>
```

## Relationships & Integration

Span-based string processing integrates with several .NET features:

- **String methods**: Many string methods have span-based equivalents (e.g., `string.AsSpan()`, `MemoryExtensions`)
- **Encoding classes**: UTF8, ASCII, Unicode provide span-based encoding/decoding methods
- **`SearchValues<T>`**: Efficient searching for character sets within spans
- **Regex**: Pattern matching with spans (limited scenarios)
- **Stream APIs**: Reading directly into spans without intermediate buffers
- **PipeReader/PipeWriter**: High-performance I/O with span-based operations

Common integration patterns:

```csharp
using System;
using System.Buffers;
using System.Text;

// SearchValues with spans for efficient character searching
private static readonly SearchValues<char> s_whitespace = 
    SearchValues.Create(" \t\r\n");

static ReadOnlySpan<char> TrimStart(ReadOnlySpan<char> text)
{
    int firstNonWhitespace = text.IndexOfAnyExcept(s_whitespace);
    return firstNonWhitespace >= 0 
        ? text.Slice(firstNonWhitespace) 
        : ReadOnlySpan<char>.Empty;
}

// Encoding with spans
static void EncodeToUtf8(ReadOnlySpan<char> text, Span<byte> destination)
{
    Encoding.UTF8.GetBytes(text, destination);
}

// Reading from streams into spans
static async Task<int> ReadIntoSpanAsync(Stream stream, Memory<byte> buffer)
{
    return await stream.ReadAsync(buffer);
}
```
