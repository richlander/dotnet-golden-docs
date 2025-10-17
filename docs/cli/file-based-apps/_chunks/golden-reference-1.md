# File-based Apps
## Relationships & Integration

Ecosystem positioning: File-based apps sit between simple scripts and full project structures, bridging the gap for .NET developers who need more than basic scripting but less than enterprise project complexity.

MSBuild integration: File-level directives (`#:package`, `#:project`, `#:property`) maintain full compatibility with MSBuild concepts while avoiding explicit project file creation. The dotnet host synthesizes temporary project files behind the scenes.

NuGet ecosystem: Direct package integration via `#:package` directives provides immediate access to the entire NuGet ecosystem without package.config or PackageReference management.

Cross-platform scripting: Can replace platform-specific scripting solutions (PowerShell on Windows, bash/Python on Unix) with a unified C# approach that works consistently across all .NET-supported platforms.

Migration pathways:

- From scripts: Upgrade from .csx (C# Script) or shell scripts to full C# with complete IntelliSense and debugging
- To projects: Use `dotnet project convert app.cs` to transform growing file-based apps into traditional project structures when complexity increases

IDE integration: Works seamlessly with Visual Studio Code and other editors that support C# language services, providing full IntelliSense, debugging, and syntax highlighting without project setup.

Publishing flexibility: Integrates with all .NET publishing options including Native AOT, single-file deployment, framework-dependent deployment, and self-contained deployment through file-level property directives.
