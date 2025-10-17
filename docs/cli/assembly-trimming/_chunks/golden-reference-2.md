# Explicit trimming flag
## Gotchas & Limitations
### Library Authoring Best Practices

```csharp
// Annotate reflection-dependent code
[RequiresUnreferencedCode("This method uses reflection")]
public void ProcessType(Type type)
{
    // Reflection code that may not work with trimming
}

// Specify required members for reflection
public void ProcessTypeMembers([DynamicallyAccessedMembers(DynamicallyAccessedMemberTypes.PublicMethods)] Type type)
{
    var methods = type.GetMethods(); // Safe with annotation
}

// Suppress warnings when requirements are guaranteed
[UnconditionalSuppressMessage("Trimming", "IL2070", Justification = "Type is guaranteed to have constructor")]
public object CreateInstance(Type type)
{
    return Activator.CreateInstance(type);
}
```

## Using Assembly Trimming for Cloud-Native Applications

```xml
<!-- Optimized for container deployment -->
<PropertyGroup>
    <PublishTrimmed>true</PublishTrimmed>
    <InvariantGlobalization>true</InvariantGlobalization>
    <EventSourceSupport>false</EventSourceSupport>
    <HttpActivityPropagationSupport>false</HttpActivityPropagationSupport>
</PropertyGroup>
```

## Using Assembly Trimming for Desktop Applications

```xml
<!-- Balanced approach for desktop apps -->
<PropertyGroup>
    <PublishTrimmed>true</PublishTrimmed>
    <TrimmerSingleWarn>false</TrimmerSingleWarn>
    <!-- Keep debugger support for better crash reporting -->
    <DebuggerSupport>true</DebuggerSupport>
</PropertyGroup>
```

## Assembly Trimming for Library Development

```csharp
// Example trim-compatible library code
public class JsonProcessor
{
    // Use source generation instead of reflection
    public string Serialize<T>(T obj, JsonSerializerContext context)
        where T : class
    {
        return JsonSerializer.Serialize(obj, context.GetTypeInfo(typeof(T)));
    }

    // Annotate unavoidable reflection
    [RequiresUnreferencedCode("Dynamic type processing requires unreferenced code")]
    public object ProcessDynamicType(Type type, string data)
    {
        return JsonSerializer.Deserialize(data, type);
    }
}
```

## Gotchas & Limitations

### Critical Incompatibilities

- WPF applications: Trimming currently disabled due to extensive reflection usage
- Windows Forms: Disabled due to COM marshalling dependencies
- C++/CLI: Mixed-mode assemblies not supported
- Dynamic assembly loading: Assembly.LoadFrom/LoadFile patterns incompatible
- Unbounded reflection: Serializers using complex reflection patterns
