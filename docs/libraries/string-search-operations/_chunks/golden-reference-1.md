# String Search Operations
## Essential Syntax & Examples

### String.Contains

The simplest way to check for substring existence:

```csharp
string text = "The quick brown fox";

// Basic containment check (ordinal by default)
bool hasFox = text.Contains("fox");  // true

// Case-insensitive search
bool hasQuick = text.Contains("QUICK", StringComparison.OrdinalIgnoreCase);  // true

// Single character check (ordinal, no StringComparison parameter)
bool hasQ = text.Contains('q');  // true
```

**Best practice**: Use CA2249 code analyzer to prefer `Contains` over `IndexOf >= 0`:

```csharp
// Avoid this pattern
if (text.IndexOf("fox") >= 0) { }

// Prefer this
if (text.Contains("fox")) { }
```

### String.IndexOf

Find the position of the first occurrence:

```csharp
string path = "C:\\Users\\Documents\\file.txt";

// Find first backslash
int firstSlash = path.IndexOf('\\');  // Returns 2

// Find substring with comparison type
int docsPos = path.IndexOf("documents", StringComparison.OrdinalIgnoreCase);  // Returns 9

// Search from specific position
int secondSlash = path.IndexOf('\\', firstSlash + 1);  // Returns 8

// Not found returns -1
int notFound = path.IndexOf("missing");  // Returns -1
```

**Culture considerations**:

```csharp
// WARNING: Without StringComparison, string overloads use CurrentCulture
string text = "Hel\0lo";
int idx1 = text.IndexOf("\0");  // May vary by culture/platform!

// RECOMMENDED: Always specify StringComparison for strings
int idx2 = text.IndexOf("\0", StringComparison.Ordinal);  // Consistent behavior
```

### String.LastIndexOf

Find the last occurrence:

```csharp
string filePath = "folder/subfolder/file.txt";

// Find last separator
int lastSlash = filePath.LastIndexOf('/');  // Returns 16

// Get filename
string fileName = filePath.Substring(lastSlash + 1);  // "file.txt"

// Find last occurrence of substring
int lastDot = filePath.LastIndexOf(".txt");  // Returns 21
```
