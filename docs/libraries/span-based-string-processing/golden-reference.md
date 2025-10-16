# Span-Based String Processing

## Overview

Span-based string processing enables high-performance text operations without heap allocations. By using `Span<char>`, `ReadOnlySpan<char>`, and related types, you can process strings, perform conversions, and manipulate text data with minimal memory overhead. The .NET runtime and libraries provide extensive support for span-based operations, including UTF-8 processing, string normalization, hex conversion, and pattern matching.

Key capabilities include:

- **Zero-allocation text processing**: Process strings without creating temporary string objects
- **UTF-8 direct processing**: Work with UTF-8 data without converting to UTF-16 strings
- **Span-based string normalization**: Normalize Unicode strings without allocating new strings
- **Hex string conversion**: Convert between binary data and hex representations using UTF-8 spans
- **Pattern matching on spans**: Use pattern matching directly on `ReadOnlySpan<char>` for efficient text analysis
- **First-class span support**: C# 14 provides implicit conversions and natural syntax for span types

These techniques are particularly valuable when:

1. Processing text in hot code paths where allocations impact performance
2. Working with large text data or streams
3. Converting between different text encodings efficiently
4. Parsing or validating text without creating intermediate strings

## UTF-8 Hex String Conversion

Convert hexadecimal strings to binary data using UTF-8 without string allocations:

```csharp
using System;

// Convert hex UTF-8 bytes to binary data
// Common when reading hex strings from files or config
ReadOnlySpan<byte> hexUtf8 = "48656C6C6F"u8;
Span<byte> result = stackalloc byte[hexUtf8.Length / 2];

if (Convert.TryFromHexString(hexUtf8, result, out int bytesWritten))
{
    // result contains: { 0x48, 0x65, 0x6C, 0x6C, 0x6F }
    // Use the binary data directly
    ProcessBinaryData(result.Slice(0, bytesWritten));
}

// Also works with hex strings from files
byte[] fileBytes = File.ReadAllBytes("hash.txt");  // Contains "A3B2C1..."
Span<byte> hash = stackalloc byte[fileBytes.Length / 2];
if (Convert.TryFromHexString(fileBytes, hash, out int written))
{
    // hash now contains the binary representation
    VerifyHash(hash.Slice(0, written));
}
```

## String Normalization with Spans

Normalize Unicode strings without creating new string objects:

```csharp
using System;
using System.Text;

string input = "café";  // Contains 'é' as single character

// Check if already normalized
if (input.AsSpan().IsNormalized(NormalizationForm.FormD))
{
    Console.WriteLine("Already normalized");
}
else
{
    // Get required buffer size
    int length = input.AsSpan().GetNormalizedLength(NormalizationForm.FormD);
    
    // Normalize into span
    Span<char> normalized = stackalloc char[length];
    if (input.AsSpan().TryNormalize(normalized, out int written, NormalizationForm.FormD))
    {
        // normalized contains decomposed form: "cafe\u0301"
        string result = new string(normalized.Slice(0, written));
        Console.WriteLine(result);
    }
}
```

## Pattern Matching on `ReadOnlySpan<char>`

Use pattern matching to analyze text without string allocations:

```csharp
static bool IsValidCommand(ReadOnlySpan<char> input)
{
    return input switch
    {
        "start" => true,
        "stop" => true,
        "restart" => true,
        ['/', ..] => true,  // List pattern - starts with '/'
        _ => false
    };
}

// Usage - no string allocation
ReadOnlySpan<char> command = "start";
bool valid = IsValidCommand(command);  // true

// Works with string slices too
string userInput = "/help config";
bool isSlash = IsValidCommand(userInput.AsSpan(0, 5));  // true
```

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

## UTF-8 Processing Without String Conversions

Working directly with UTF-8 data eliminates conversion overhead:

```csharp
using System;
using System.IO;
using System.Text;

// Read file as UTF-8 bytes, process without creating strings
static void ProcessUtf8File(string path)
{
    byte[] fileBytes = File.ReadAllBytes(path);
    ReadOnlySpan<byte> utf8Data = fileBytes;
    
    // Process UTF-8 directly
    int lineCount = 0;
    while (!utf8Data.IsEmpty)
    {
        int newlinePos = utf8Data.IndexOfAny("\r\n"u8);
        
        if (newlinePos >= 0)
        {
            ReadOnlySpan<byte> line = utf8Data.Slice(0, newlinePos);
            ProcessUtf8Line(line);
            
            lineCount++;
            utf8Data = utf8Data.Slice(newlinePos + 1);
            
            // Skip \n if we found \r
            if (newlinePos < fileBytes.Length && fileBytes[newlinePos] == '\r' &&
                !utf8Data.IsEmpty && utf8Data[0] == (byte)'\n')
            {
                utf8Data = utf8Data.Slice(1);
            }
        }
        else
        {
            ProcessUtf8Line(utf8Data);
            break;
        }
    }
    
    Console.WriteLine($"Processed {lineCount} lines");
}

static void ProcessUtf8Line(ReadOnlySpan<byte> utf8Line)
{
    // Process the UTF-8 line directly
    // Only convert to string if needed for output
}
```

### Finding PEM Data in UTF-8 Files

Process PEM-encoded files without UTF-8 to string conversion:

```csharp
using System;
using System.IO;
using System.Security.Cryptography;

static void ProcessPemFile(string path)
{
    byte[] fileBytes = File.ReadAllBytes(path);
    
    // Find PEM data in UTF-8 bytes directly
    PemFields pemFields = PemEncoding.FindUtf8(fileBytes);
    
    if (pemFields.Location == -1)
    {
        Console.WriteLine("No PEM data found");
        return;
    }
    
    // Extract and decode the base64 data (still in UTF-8 bytes)
    ReadOnlySpan<byte> base64Utf8 = fileBytes.AsSpan()[pemFields.Base64Data];
    
    // Decode from UTF-8 base64 directly to bytes
    Span<byte> decoded = stackalloc byte[pemFields.DecodedDataLength];
    if (Convert.TryFromBase64Chars(
        System.Text.Encoding.UTF8.GetString(base64Utf8), 
        decoded, 
        out int bytesWritten))
    {
        // Process the decoded PEM content
        Console.WriteLine($"Decoded {bytesWritten} bytes of PEM data");
    }
}
```

## High-Performance Text Parsing

Use spans for parsing without allocations:

```csharp
using System;

// Parse CSV line without creating substring allocations
static void ParseCsvLine(ReadOnlySpan<char> line)
{
    while (!line.IsEmpty)
    {
        int commaPos = line.IndexOf(',');
        
        ReadOnlySpan<char> field = commaPos >= 0 
            ? line.Slice(0, commaPos) 
            : line;
        
        ProcessField(field);
        
        if (commaPos >= 0)
        {
            line = line.Slice(commaPos + 1);
        }
        else
        {
            break;
        }
    }
}

static void ProcessField(ReadOnlySpan<char> field)
{
    // Process field without allocation
    // Only create string if needed for storage
    if (field.Length > 0)
    {
        Console.WriteLine(field);  // ToString() only called for display
    }
}

// Parse integers from span
static bool TryParseIntList(ReadOnlySpan<char> input, Span<int> output)
{
    int outputIndex = 0;
    
    while (!input.IsEmpty && outputIndex < output.Length)
    {
        int commaPos = input.IndexOf(',');
        ReadOnlySpan<char> numberSpan = commaPos >= 0 
            ? input.Slice(0, commaPos) 
            : input;
        
        if (!int.TryParse(numberSpan, out int value))
        {
            return false;
        }
        
        output[outputIndex++] = value;
        
        if (commaPos >= 0)
        {
            input = input.Slice(commaPos + 1).TrimStart();
        }
        else
        {
            break;
        }
    }
    
    return true;
}

// Usage
string csvNumbers = "10, 20, 30, 40, 50";
Span<int> numbers = stackalloc int[10];
if (TryParseIntList(csvNumbers, numbers))
{
    // numbers contains: [10, 20, 30, 40, 50, 0, 0, 0, 0, 0]
}
```

## String Normalization Patterns

Normalize Unicode strings efficiently:

```csharp
using System;
using System.Text;

// Check normalization without allocation
static bool IsNormalizedUtf8(string input, NormalizationForm form = NormalizationForm.FormC)
{
    return input.AsSpan().IsNormalized(form);
}

// Normalize with size estimation
static string NormalizeString(string input, NormalizationForm form = NormalizationForm.FormC)
{
    ReadOnlySpan<char> inputSpan = input.AsSpan();
    
    // Check if already normalized
    if (inputSpan.IsNormalized(form))
    {
        return input;
    }
    
    // Get required length
    int requiredLength = inputSpan.GetNormalizedLength(form);
    
    // Small strings use stackalloc, large strings use array pool
    if (requiredLength <= 128)
    {
        Span<char> buffer = stackalloc char[requiredLength];
        if (inputSpan.TryNormalize(buffer, out int written, form))
        {
            return new string(buffer.Slice(0, written));
        }
    }
    else
    {
        char[] rented = ArrayPool<char>.Shared.Rent(requiredLength);
        try
        {
            if (inputSpan.TryNormalize(rented, out int written, form))
            {
                return new string(rented, 0, written);
            }
        }
        finally
        {
            ArrayPool<char>.Shared.Return(rented);
        }
    }
    
    // Fallback to original string if normalization fails
    return input;
}
```

## Text Validation Without Allocations

Validate text using span-based operations:

```csharp
using System;
using System.Buffers;

// Validate email format without creating substrings
static bool IsValidEmail(ReadOnlySpan<char> email)
{
    int atPos = email.IndexOf('@');
    if (atPos <= 0 || atPos == email.Length - 1)
    {
        return false;
    }
    
    ReadOnlySpan<char> localPart = email.Slice(0, atPos);
    ReadOnlySpan<char> domain = email.Slice(atPos + 1);
    
    // Check for invalid characters
    SearchValues<char> invalidChars = SearchValues.Create(" <>\"");
    if (localPart.ContainsAny(invalidChars) || domain.ContainsAny(invalidChars))
    {
        return false;
    }
    
    // Check domain has at least one dot
    return domain.Contains('.');
}

// Validate URL scheme
static bool HasHttpScheme(ReadOnlySpan<char> url)
{
    return url.StartsWith("http://", StringComparison.OrdinalIgnoreCase) ||
           url.StartsWith("https://", StringComparison.OrdinalIgnoreCase);
}

// Extract and validate port number
static bool TryGetPort(ReadOnlySpan<char> url, out int port)
{
    port = 0;
    
    // Find port separator
    int colonPos = url.LastIndexOf(':');
    if (colonPos < 0)
    {
        return false;
    }
    
    // Extract potential port number
    ReadOnlySpan<char> portSpan = url.Slice(colonPos + 1);
    
    // Parse without allocation
    return int.TryParse(portSpan, out port) && port > 0 && port <= 65535;
}
```

## Performance Characteristics

### Allocation Reduction

- **Span operations**: Zero heap allocations for slicing, searching, and manipulation
- **UTF-8 processing**: Eliminates UTF-8 to UTF-16 conversion overhead
- **String normalization**: Processes in-place or to preallocated buffers
- **Pattern matching**: No string allocations for comparison operations

### Processing Speed

- **Direct memory access**: Span operations work directly on underlying memory
- **Vectorization**: Many span operations use SIMD instructions
- **Reduced GC pressure**: Fewer allocations mean less garbage collection overhead
- **Cache efficiency**: Sequential memory access patterns improve CPU cache utilization

### Memory Overhead

- **Stack allocation**: Small buffers can use stackalloc instead of heap
- **ArrayPool**: Rent buffers for larger operations, avoiding repeated allocations
- **In-place operations**: Many operations modify data without creating copies

## Best Practices

1. **Use `ReadOnlySpan<char>` for parameters**: Accept ReadOnlySpan<char> instead of string for methods that don't need to store the value
2. **Prefer AsSpan() over Substring()**: Use `string.AsSpan(start, length)` instead of `string.Substring()` to avoid allocations
3. **Stack allocate small buffers**: Use stackalloc for temporary buffers under ~1KB
4. **Use ArrayPool for large buffers**: Rent arrays from `ArrayPool<T>.Shared` for larger temporary buffers
5. **Check normalization before normalizing**: Use `IsNormalized()` to avoid unnecessary work
6. **Process UTF-8 directly when possible**: Avoid converting to UTF-16 strings if working with UTF-8 data
7. **Combine with SearchValues**: Use SearchValues<char> for repeated character set searches

## Migration & Compatibility

### Adopting Span-Based String Processing

Migrating from string-based to span-based code:

```csharp
// Before: Creates substring allocations
static string GetFileExtension(string path)
{
    int dotPos = path.LastIndexOf('.');
    return dotPos >= 0 ? path.Substring(dotPos) : string.Empty;
}

// After: No allocations
static ReadOnlySpan<char> GetFileExtension(ReadOnlySpan<char> path)
{
    int dotPos = path.LastIndexOf('.');
    return dotPos >= 0 ? path.Slice(dotPos) : ReadOnlySpan<char>.Empty;
}

// Or return string when storage is needed
static string GetFileExtensionAsString(ReadOnlySpan<char> path)
{
    ReadOnlySpan<char> extension = GetFileExtension(path);
    return extension.IsEmpty ? string.Empty : new string(extension);
}
```

### UTF-8 String Processing Migration

```csharp
// Before: Convert UTF-8 to string, process, convert back
byte[] utf8Data = GetUtf8Data();
string text = Encoding.UTF8.GetString(utf8Data);
string upper = text.ToUpper();
byte[] result = Encoding.UTF8.GetBytes(upper);

// After: Process UTF-8 directly
byte[] utf8Data = GetUtf8Data();
Span<byte> result = new byte[utf8Data.Length * 2]; // Upper bound
int written = Encoding.UTF8.GetBytes(
    Encoding.UTF8.GetString(utf8Data).AsSpan().ToUpper(),
    result);
```

**Version requirements**:
- `Span<T>` and `ReadOnlySpan<T>`: .NET Core 2.1+
- Pattern matching on `ReadOnlySpan<char>`: C# 11 (.NET 7+)
- UTF-8 string literals: C# 11 (.NET 7+)
- UTF-8 hex string conversion: .NET 10+
- String normalization with spans: .NET 10+
- `PemEncoding.FindUtf8`: .NET 10+
- First-class span conversions: C# 14 (.NET 10+)

## Related Topics

- **`Span<T>` and `Memory<T>`**: Foundational types for span-based operations
- **`SearchValues<T>`**: For high-performance character set searching
- **System.Text.Encoding**: UTF-8, ASCII, and Unicode encoding with span support
- **String methods**: Many have span-based equivalents in MemoryExtensions
- **`ArrayPool<T>`**: For efficient buffer management
