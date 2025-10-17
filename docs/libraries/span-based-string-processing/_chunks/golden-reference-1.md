# Span-Based String Processing
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
