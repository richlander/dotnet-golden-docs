# Type Extensions
## See Also
### Document Extension Behavior

Clearly document what extensions do and any side effects.

```csharp
public static class FileExtensions
{
    extension (FileInfo file)
    {
        /// <summary>
        /// Reads entire file content as text.
        /// </summary>
        /// <remarks>
        /// Loads entire file into memory. Not suitable for large files.
        /// File must exist or IOException is thrown.
        /// </remarks>
        public string ReadAllText() => File.ReadAllText(file.FullName);
    }
}
```

## See Also

### Related Language Features

- **Extension Methods (C# 3.0)**: Original extension method pattern with `this` modifier
- **Extension Properties**: Property members in extension blocks
- **Extension Operators**: Operator overloading via extensions
- **LINQ**: Standard query operators implemented as extension methods
- **Static Classes**: Container for extension declarations

### Framework Integration

- **System.Linq**: LINQ query operators (extension methods)
- **System.Collections.Generic**: Collection extension methods
- **IEnumerable\<T\>**: Primary target for query extensions
- **Span\<T\> and Memory\<T\>**: Performance-oriented extension targets

### Design Patterns

- **Adapter Pattern**: Adapting types to new interfaces
- **Decorator Pattern**: Adding behavior without inheritance
- **Fluent Interfaces**: Method chaining for readable APIs
- **Builder Pattern**: Incremental object construction

### Performance Considerations

- **Zero-cost abstraction**: Extensions compile to static methods
- **Inline optimization**: JIT can inline extension methods
- **Struct extensions**: Use `ref` to avoid copying
- **Iterator methods**: `yield return` for deferred execution
