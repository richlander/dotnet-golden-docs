# Build and Compilation - Topic Specification

## Feature Description
Build and compilation encompasses the development-time workflow of transforming source code into executable binaries, managing dependencies, and preparing projects for testing and deployment. This includes the core commands `dotnet build`, `dotnet restore`, `dotnet clean`, along with MSBuild integration, multi-targeting, and build optimization strategies.

## Relationships
Enables: Application development, Testing workflows, Publishing preparation, CI/CD automation
Conflicts with: None (fundamental workflow)
Alternative to: Manual MSBuild invocation, IDE-specific build systems
Prerequisite: .NET SDK installation, Project files (*.csproj, *.sln)
Synergistic with: Package management, Testing frameworks, Publishing workflows, Code analysis tools

## Hierarchy
Name: Build and Compilation
ID: build-and-compilation
Category: CLI
Complexity: Beginner | Intermediate | Advanced
Audience: All .NET developers | DevOps engineers | Build engineers
Priority: 1 (Critical)

## Source Authority
Primary Sources (High confidence):
- https://docs.microsoft.com/en-us/dotnet/core/tools/dotnet-build - dotnet build command reference - Last verified: 2023-11-27
- https://docs.microsoft.com/en-us/dotnet/core/tools/dotnet-restore - dotnet restore command reference - Last verified: 2023-07-19
- https://docs.microsoft.com/en-us/dotnet/core/tools/dotnet-clean - dotnet clean command reference - Last verified: 2024-08-15
- https://docs.microsoft.com/en-us/visualstudio/msbuild/ - MSBuild documentation - Last verified: 2024-09-12

Secondary Sources (Good quality):
- Build performance optimization guides, CI/CD best practices, Multi-targeting strategies

Validation Requirements:
- [ ] Code examples compile across .NET versions and platforms
- [ ] Build configuration patterns work in CI/CD environments
- [ ] Performance optimization techniques provide measurable improvements
- [ ] Multi-targeting scenarios function correctly

## Generation Hints
Emphasize: Core workflow commands, Dependency management, Build configurations, Performance optimization
Avoid: Complex MSBuild internals, IDE-specific workflows
Cross-reference discover from: project-management, development-workflow, msbuild
Cross-reference surface to: publishing-and-deployment, testing, package-management, ci-cd

## Token Budget Guidance
Minimum viable content: 600 tokens - Basic build, restore, clean commands with essential options
Comprehensive coverage: 2400 tokens - Build configurations, dependencies, multi-targeting, optimization
Full reference: 4800 tokens - Advanced MSBuild integration, enterprise scenarios, performance tuning