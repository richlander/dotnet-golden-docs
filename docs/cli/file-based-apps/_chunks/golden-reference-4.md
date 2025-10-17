# File-based Apps
## Alternative Syntax Options
### Command Line Processing

Handle both arguments and standard input with proper validation:

```csharp
if (args.Length > 0)
{
    string message = string.Join(' ', args);
    Console.WriteLine(message);
}
else
{
    while (Console.ReadLine() is string line && line.Length > 0)
    {
        Console.WriteLine(line);
    }
}
```

### Learning and Experimentation

Perfect for exploring C# language features without project setup:

```csharp
// Demonstrate top-level statements with local functions
var testData = new[] { "hello", "world", "123", "" };

foreach (var item in testData)
{
    Console.WriteLine($"{item} -> {ClassifyInput(item)}");
}

string ClassifyInput(string input) => input switch
{
    "" => "Empty",
    var s when int.TryParse(s, out _) => "Number",
    var s when s.Length < 5 => "Short text",
    _ => "Long text"
};
```

## Alternative Syntax Options

File-based apps complement traditional project structures rather than replacing them. Both approaches remain valid for different scenarios:

### Traditional Project Structure

```csharp
// Traditional approach with .csproj file
// MyUtility.csproj
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <OutputType>Exe</OutputType>
    <TargetFramework>net9.0</TargetFramework>
  </PropertyGroup>
  <ItemGroup>
    <PackageReference Include="Newtonsoft.Json" Version="13.0.3" />
  </ItemGroup>
</Project>

// Program.cs
using Newtonsoft.Json;

var data = new { Name = "Alice", Age = 30 };
string json = JsonConvert.SerializeObject(data);
Console.WriteLine(json);
```

### File-based App Equivalent

```csharp
// utility.cs - Same functionality with file-based approach
#:package Newtonsoft.Json

using Newtonsoft.Json;

var data = new { Name = "Alice", Age = 30 };
string json = JsonConvert.SerializeObject(data);
Console.WriteLine(json);
```
