# Incorrect - arguments may be interpreted by dotnet run
### Migration Path

Transform file-based apps to traditional projects when complexity grows:

```bash
# Convert file-based app to traditional project
dotnet project convert utility.cs

# This creates:
# - utility.csproj with appropriate package references
# - Preserves existing code in Program.cs
# - Maintains all functionality while enabling multi-file development
```

### Command Line Usage Patterns

```bash
# File-based execution
dotnet run utility.cs -- arg1 arg2

# Traditional project execution
dotnet run --project ./MyUtility -- arg1 arg2

# Both support the same publishing options
dotnet publish utility.cs -o ./dist
dotnet publish ./MyUtility -o ./dist
```

## Best Practices

### Argument Handling

Always use the `--` separator when passing arguments that might conflict with dotnet commands:

```bash
# Correct - prevents argument conflicts
dotnet run script.cs -- --verbose --output results.txt

# Incorrect - arguments may be interpreted by dotnet run
dotnet run script.cs --verbose --output results.txt
```

### Package Management

Use specific package versions for production scripts to ensure consistency:

```csharp
// Recommended for production scripts
#:package Newtonsoft.Json/13.0.3
#:package Microsoft.Extensions.Logging/8.0.0

// Acceptable for experimentation
#:package Newtonsoft.Json
```

### Error Handling and Exit Codes

Implement proper error handling and return meaningful exit codes:

```csharp
try
{
    // Script logic here
    Console.WriteLine("Script completed successfully");
    return 0;
}
catch (FileNotFoundException ex)
{
    Console.Error.WriteLine($"File not found: {ex.FileName}");
    return 1;
}
catch (Exception ex)
{
    Console.Error.WriteLine($"Unexpected error: {ex.Message}");
    return 2;
}
```
