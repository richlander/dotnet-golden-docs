# Collections Performance

## Overview

Collections performance in .NET encompasses both runtime-delivered optimizations and code patterns that enable efficient use of arrays, lists, and other collection types. The .NET runtime has continuously evolved to make collection operations faster through techniques like stack allocation, devirtualization, and improved code generation. The runtime combines automatic optimizations with developer-accessible patterns to achieve high performance.

Key performance capabilities include:

- **Automatic stack allocation**: Small arrays that don't escape their method are allocated on the stack, eliminating heap allocations and GC pressure
- **Array interface devirtualization**: Arrays accessed through interfaces like `IEnumerable<T>` perform as efficiently as direct array access
- **Improved enumeration**: Array enumeration through interfaces achieves performance parity with concrete type iteration
- **Insertion-order collections**: `OrderedDictionary<TKey, TValue>` provides fast indexed access while maintaining insertion order

These optimizations are particularly valuable when:

1. Working with small, temporary collections in hot code paths
2. Using LINQ or foreach with arrays through abstraction boundaries
3. Needing both dictionary semantics and predictable iteration order
4. Processing collections in performance-critical scenarios
