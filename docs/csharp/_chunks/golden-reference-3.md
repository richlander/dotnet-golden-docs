# C# Language
## Relationships & Integration
### Memory Management and Safety

C# apps benefit from the .NET Runtime's automatic memory management, eliminating manual memory management concerns. C# provides type safety and memory safety as baseline capabilities:

- Automatic Memory Management: Variables either reference live objects, are `null`, or are out of scope. Memory is auto-initialized by default and bounds checking prevents accessing invalid indices
- Nullable Reference Types: A C# language and compiler feature that statically identifies code that is not safely handling `null`. The compiler warns you if you dereference a variable that might be null, and you can disallow `null` assignment
- Value Types: Structs and stack-allocated memory blocks for direct control over data layout
- Unsafe Code: Optional unsafe contexts for maximum performance when needed
- `Span<T>` and `Memory<T>`: High-performance memory management without allocations
- ref returns and ref locals: Efficient data manipulation without copying

## Relationships & Integration

### .NET Ecosystem Integration

C# is the primary programming language for .NET and much of .NET is written in C#. The runtime, libraries, and languages are the pillars of the .NET stack and have a symbiotic relationship, having been designed and built together by a single group. The libraries shape runtime capabilities into concepts and object models that enable developers to productively write algorithms in intuitive workflows.

Deep Language-Library Integration: The core libraries expose thousands of types, many of which integrate with and fuel the C# language. `foreach` enables enumerating arbitrary collections, with pattern-based optimizations that enable collections like `List<T>` to be processed simply and efficiently. Resource management may be left up to garbage collection, but prompt cleanup is possible via `IDisposable` and direct language support in `using`.

Rich Library Ecosystem: String interpolation in C# is both expressive and efficient, integrated with and powered by implementations across core library types like `string`, `StringBuilder`, and `Span<T>`. Language-integrated query (LINQ) features are powered by hundreds of sequence-processing routines in the libraries, like `Where`, `Select`, and `GroupBy`, with an extensible design and implementations that support both in-memory and remote data sources. The integration extends to comprehensive libraries from compression to cryptography to regular expressions, and a networking stack spanning from sockets to HTTP/3.
