# Explicit trimming flag
## Troubleshooting Common Issues
### Common Warning Scenarios

```csharp
// This will generate trim warnings
public void ProblematicCode()
{
    // IL2070: 'this' argument does not satisfy 'DynamicallyAccessedMemberTypes.PublicMethods'
    var type = typeof(MyClass);
    var methods = type.GetMethods(); // Warning: may not work after trimming
}

// Fixed version
public void FixedCode([DynamicallyAccessedMembers(DynamicallyAccessedMemberTypes.PublicMethods)] Type type)
{
    var methods = type.GetMethods(); // Safe with annotation
}
```

### Performance Considerations

- Build time: Trimming analysis adds significant compile time
- First deployment: Initial trimmed builds are slower
- Warning investigation: Time investment required to resolve compatibility issues
- Testing overhead: Need to test trimmed applications thoroughly

### Framework Feature Limitations

When trimming is enabled, several features are automatically disabled:

- Built-in COM interop support
- Custom resource type support
- C++/CLI host activation
- Startup hook support
- Some binary formatter scenarios

## Troubleshooting Common Issues

### Resolving Reflection Warnings

```csharp
// Problem: Dynamic type creation
public T CreateInstance<T>() where T : new()
{
    return (T)Activator.CreateInstance(typeof(T)); // May generate warnings
}

// Solution: Use constraints and annotations
[RequiresUnreferencedCode("Generic type creation requires unreferenced code")]
public T CreateInstance<T>() where T : class, new()
{
    return new T(); // Preferred approach when possible
}
```

### Library Migration Strategies

1. Enable analysis: Add `<EnableTrimAnalyzer>true</EnableTrimAnalyzer>`
2. Fix warnings progressively: Start with high-impact APIs
3. Use source generators: Replace reflection with compile-time alternatives
4. Document requirements: Clearly state trim compatibility status
5. Test thoroughly: Create trim-enabled test applications
