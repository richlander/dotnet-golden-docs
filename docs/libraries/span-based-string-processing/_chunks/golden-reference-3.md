# Span-Based String Processing
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
