# .NET
## Essential Architecture & Components

.NET includes the following components:

- Runtime -- executes application code with automatic memory management and type safety
- Libraries -- provides utility functionality like JSON parsing and thousands of APIs
- Compiler -- compiles C# (and other languages) source code into runtime executable code
- SDK and tools -- enable building and monitoring apps with modern workflows
- App stacks -- like ASP.NET Core and Windows Forms, that enable writing specific types of apps

### The Three Pillars of .NET

The runtime, libraries, and languages are the pillars of the .NET stack. Higher-level components build on top of these pillars:

Runtime: Executes application code with automatic memory management via a self-tuning, tracing Garbage Collector (GC). It provides type safety, memory safety, and cross-platform execution. The runtime was initially called the "Common Language Runtime (CLR)" and supports multiple programming languages.

Libraries: The core libraries expose thousands of types that integrate with and fuel the C# language. Examples include `foreach` statement support for collections, `IDisposable` for resource management, and extensive APIs for networking, compression, cryptography, and serialization. Extensions are provided via NuGet packages.

Languages: C# is the primary programming language for .NET and much of .NET is written in C#. It's object-oriented, requires garbage collection, and spans from high-level features like data-oriented records to low-level features like function pointers. The runtime also supports F#, Visual Basic, and many community languages.
