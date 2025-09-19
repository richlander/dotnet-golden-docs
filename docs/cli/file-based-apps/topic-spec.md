# File-based apps - Topic Specification

## Feature Description
File-based apps allow developers to run and publish single .cs files directly without creating a traditional project structure. This feature streamlines simple scripting, prototyping, and automation tasks by eliminating project setup overhead while maintaining full .NET runtime capabilities.

## Hierarchy
Name: File-based apps
ID: file-based-apps
Category: CLI
Description: File-based apps allow developers to run and publish single .cs files directly without creating a traditional project structure.
Complexity: beginner to intermediate
Audience: all developers, especially those focused on scripting and automation
Priority: 2 (Common usage - recent high-interest feature)

## Relationships
Enables: scripting, rapid prototyping, LLM-generated tools
Neutral: native AOT compilation, cross-platform development
Conflicts with: multi-file projects, complex MSBuild scenarios, team collaboration workflows
Alternative to: dotnet script, traditional project files, shell scripting, PowerShell
Synergistic with: Visual Studio Code
Prerequisite: .NET 10 SDK

## Hints
Flexible: app files can have any name, like `Program.cs`, `hello-world.cs`, or `app.cs`.
Emphasize: developer productivity, cross-platform scripting, single-file simplicity
Avoid: complex enterprise scenarios, multi-file project patterns, team development workflows, solution files

## Critical limitations
- Single file constraint: only works with exactly one .cs file in the directory
- Build command limitation: `dotnet build app.cs` intentionally doesn't produce persistent artifacts
- Publishing focus: use `dotnet publish app.cs` for deployable outputs, not `dotnet build`
- Argument separator: requires `--` separator in `dotnet run app.cs -- args` for proper argument passing

## Key scenarios to cover
1. Basic execution: `dotnet run hello.cs` with argument handling
2. Package dependencies: using `#:package` directives for NuGet packages
3. Project references: using `#:project` directives for local project dependencies
4. Cross-platform scripting: shebang support for Unix-like systems
5. Publishing options: creating executables with `publish` including Native AOT support
6. Migration paths: when and how to convert to traditional projects
7. Troubleshooting: common issues with multi-file directories and argument passing

## Anti-patterns to avoid
- Recommending `dotnet script` when file-based apps are more appropriate (.NET 10+)
- Suggesting .csx files for scenarios where .cs works better
- Missing `--` separator in command-line examples for aguments that overlap with `dotnet run`
- Incomplete migration guidance from legacy approaches
