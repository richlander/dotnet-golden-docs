# Partial Classes
## Documentation Comments

When both declaring and implementing declarations include XML documentation comments:
- For methods, properties, indexers, and events: implementing declaration comments take precedence
- If only one declaration has comments, those comments are used
- Caller info attributes on declaring declarations take precedence; compiler warns if both declarations have caller info attributes

## When to Use Partial Classes

**Code generation and source generators:**
- Separate generated code from developer-written code
- Windows Forms, WPF designer-generated classes
- Entity Framework context classes
- Source generators implementing attributed members

**Platform-specific implementations:**
- Different source files for Linux, macOS, or Windows-specific members
- Conditional compilation for platform APIs
- Organize platform differences without preprocessor directives scattered throughout code

```csharp
// Shared.cs
public partial class FileSystem
{
    public partial string GetPathSeparator();
}

// Windows.cs (conditional compilation)
#if WINDOWS
public partial class FileSystem
{
    public partial string GetPathSeparator() => "\\";
}
#endif

// Unix.cs (conditional compilation)
#if LINUX || MACOS
public partial class FileSystem
{
    public partial string GetPathSeparator() => "/";
}
#endif
```

**Separation of concerns:**
- Keep generated code separate from custom code
- Organize large classes by responsibility (data, methods, events)
- Implement interfaces in separate files

## Considerations

- **Same assembly requirement:** All partial declarations must be in the same assembly and module (same .exe or .dll).
- **Partial keyword required:** All parts must use the `partial` keyword.
- **Accessibility must match:** All parts must have the same accessibility (public, internal, etc.).
- **Name and type parameters match:** Class name and generic type parameters must match exactly.
- **Keyword placement:** The `partial` modifier must appear immediately before `class`, `struct`, or `interface`.
- **Not allowed on:** Cannot use `partial` on delegates, enumerations, finalizers, static constructors, or operator overloads.
- **Attributes merge:** Attributes from all partial declarations are combined. If you apply the same attribute to multiple partial declarations, it appears multiple times on the final type (unless the attribute has `AllowMultiple=false`).
- **Base class agreement:** All parts that specify a base class must specify the same base class. Parts that omit the base class still inherit from it.
- **Auto-properties:** The implementing declaration of a partial property cannot use auto-property syntax (`{ get; set; }`). The compiler cannot distinguish between an auto-property and a declaring declaration. Use explicit accessors or the `field` keyword.
- **Primary constructors:** Only one partial type declaration can include primary constructor syntax. This prevents conflicts in parameter definitions.
- **Optional methods removed:** If an optional partial method (private, void return, no out parameters) lacks implementation, the compiler removes all calls to it. Any argument expressions in those calls are also removed, including potential side effects.
- **Generic constraints:** Generic constraints must match on all partial declarations. The same constraint must be specified on every partial declaration of a generic partial type.
