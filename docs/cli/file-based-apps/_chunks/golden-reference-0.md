# File-based Apps

## Overview

File-based apps enable developers to run and publish single `.cs` files directly without creating traditional project structures. This .NET 10+ feature streamlines scripting, prototyping, and automation by eliminating project setup overhead while maintaining full .NET runtime capabilities.

What it is: A simplified approach where `dotnet run app.cs` executes standalone C# files. The dotnet host automatically builds these files in a temporary folder, supporting top-level statements or classic `Main` methods. File-based apps support a set of directives -- package and project references -- that otherwise would require a project file. These directives make file-based apps flexible and expressive while maintaining compatibility with MSBuild concepts. On Linux and macOS, file-based apps can be run as shebang-style scripts.

Core capabilities:

- Direct execution: Run `.cs` files without project files using `dotnet run app.cs`
- Package integration: Add NuGet packages with `#:package` directives
- Project references: Reference local projects with `#:project` directives
- Publishing flexibility: Create standalone executables with `dotnet publish app.cs` (Native AOT and single file capable)
- Cross-platform scripting: Unix shebang support for direct shell execution
- Seamless conversion: Transform scripts to full projects with `dotnet project convert app.cs`

When to use:

- Learning C# fundamentals and experimenting with language features
- Quick scripts and automation tasks
- Rapid prototyping and algorithm experimentation
- Command-line utilities with minimal setup overhead
- Cross-platform scripting (alternative to shell scripts or PowerShell)
- LLM-generated tools and single-purpose utilities

Key benefits:

- Reduced complexity: No `.csproj` files, solution management, or project structure
- Simplified workflow: Files run directly without explicit project setup or build commands
- Full .NET ecosystem: Access to all .NET libraries, NuGet packages, and language features
- Publishing options: Native AOT compilation available for published executables
- Gradual migration: Seamless path from simple scripts to complex projects
- Development velocity: Lower entry barriers for C# learning and experimentation

Key tradeoffs:

- Single file constraint: Only works with exactly one `.cs` file per directory
- Limited build artifacts: `dotnet build` intentionally doesn't create persistent outputs (use `dotnet publish` instead)
- Team collaboration: Not optimized for multi-developer workflows or complex project management
- Advanced scenarios: Better suited for simple utilities than enterprise applications with complex dependencies
