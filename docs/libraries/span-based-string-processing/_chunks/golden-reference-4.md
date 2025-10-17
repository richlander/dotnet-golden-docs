# Span-Based String Processing
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
