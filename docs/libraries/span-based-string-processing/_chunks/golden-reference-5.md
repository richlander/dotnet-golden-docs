# Span-Based String Processing
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
