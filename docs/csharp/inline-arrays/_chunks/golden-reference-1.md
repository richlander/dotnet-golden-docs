# Inline Arrays
## Overview
### Main Approaches

**As struct fields**: Embed fixed-size buffers directly in types
- Use inline arrays as struct fields for known-size data
- Replace unsafe fixed buffers with safe inline arrays
- Create efficient data structures with embedded buffers

**With Span conversion**: Convert to spans for flexible access
- Convert inline arrays to `Span<T>` for unified processing
- Use span indexers and slicing for element access
- Pass inline arrays as spans to avoid copying

**Stack allocated buffers**: Create temporary buffers without heap allocation
- Allocate inline arrays on the stack with `stackalloc`-like patterns
- Process fixed-size data without GC pressure
- Use for temporary buffers in performance-critical code

### When to Use

Use inline arrays when:
- You need a fixed-size buffer with known length at compile time
- You want type safety without using unsafe code
- You're replacing unsafe fixed-size buffers with safe alternatives
- You need efficient interop with native code requiring fixed layouts
- You want to embed small buffers directly in structs
- Performance matters and you want to avoid heap allocations

Avoid inline arrays when:
- The buffer size is only known at runtime (use `Span<T>` or arrays instead)
- You need dynamic resizing (use `List<T>` or `ArrayPool<T>`)
- The buffer is very large (consider heap allocation)
- You're targeting older runtimes that don't support inline arrays (requires .NET 8+)
