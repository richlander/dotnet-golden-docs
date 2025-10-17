# .NET
## Relationships & Integration
### Key Technical Features

Type System: Offers significant breadth with object-oriented programming, generics, delegates, value types, and reference types. The type system enables single inheritance, interfaces with default implementations, and virtual method dispatch.

Memory Management: The .NET runtime provides automatic memory management via a garbage collector that eliminates heap corruption bugs. It's a self-tuning, tracing GC that delivers "hands-off" operation while offering configuration for extreme workloads.

Concurrency: Support for async/await and Task primitives makes it easy to write asynchronous operations. The runtime provides multiple levels of abstraction from Thread and ThreadPool to high-level patterns like Parallel.ForEach.

Reflection: A "programs as data" paradigm allowing dynamic querying and invocation of assemblies, types, and members. Particularly useful for late-bound programming models and tools.

## Relationships & Integration

### .NET Ecosystem and Variants

There are multiple variants of .NET, each supporting different types of applications:

- .NET Framework -- The original .NET that provides access to Windows and Windows Server capabilities. Actively supported in maintenance mode.
- Mono -- The original community and open-source .NET. A cross-platform implementation actively supported for Android, iOS, and WebAssembly.
- .NET (Core) -- Modern .NET. Cross-platform and open-source, rethought for the cloud age while remaining significantly compatible with .NET Framework. Actively supported for Linux, macOS, and Windows.
