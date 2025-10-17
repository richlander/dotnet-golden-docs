# System.Text.Json Source Generation
## Considerations
### Native AOT Applications

Source generation is mandatory for Native AOT. Reflection-based serialization fails at runtime:

```csharp
// Fails in AOT with IL2026/IL3050 warnings
var json = JsonSerializer.Serialize<User>(user);

// Works in AOT
var json = JsonSerializer.Serialize(user, ApiJsonContext.Default.User);
```

When publishing with AOT enabled (`<PublishAot>true</PublishAot>`) or building libraries with `<IsAotCompatible>true</IsAotCompatible>`, the compiler generates errors for reflection-based serialization. Always use `JsonTypeInfo<T>` overloads.

For class libraries, use `IsAotCompatible` to validate AOT compatibility without publishing as AOT:

```xml
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>net9.0</TargetFramework>
    <IsAotCompatible>true</IsAotCompatible>
  </PropertyGroup>
</Project>
```

## Considerations

### AOT Compatibility

Reflection-based `JsonSerializer` methods generate IL2026 and IL3050 warnings in AOT projects. These warnings indicate runtime failures:

- **IL2026**: Trimmer cannot determine required types
- **IL3050**: AOT cannot generate reflection code

Always use overloads accepting `JsonTypeInfo<T>` or `JsonSerializerOptions` configured with a `TypeInfoResolver`.

### Type Registration

All serialized types must be registered with `[JsonSerializable]` attributes. Forgetting nested types or collections causes runtime errors:

```csharp
// Missing nested type registration
[JsonSerializable(typeof(User))]
public partial class UserContext : JsonSerializerContext { }

// Complete registration
[JsonSerializable(typeof(User))]
[JsonSerializable(typeof(Address))]        // Nested type
[JsonSerializable(typeof(List<User>))]     // Collection
public partial class UserContext : JsonSerializerContext { }
```

### Performance Optimization

Reuse `JsonSerializerOptions` instances across operations. Creating new options on each call adds overhead:

```csharp
// Pre-computed options
public static class JsonDefaults
{
    public static readonly JsonSerializerOptions Options = new()
    {
        TypeInfoResolver = ApiJsonContext.Default,
        WriteIndented = false
    };
}

// Efficient reuse
var json = JsonSerializer.Serialize(obj, JsonDefaults.Options);
```

UTF-8 methods (`JsonSerializer.SerializeToUtf8Bytes`) avoid string encoding overhead when working with byte streams.
