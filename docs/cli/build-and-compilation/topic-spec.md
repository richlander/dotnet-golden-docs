# Build and Compilation - Topic Specification

## Feature Description
Build and compilation encompasses the development-time workflow of transforming source code into executable binaries, managing dependencies, and preparing projects for testing and deployment. This includes the core commands `dotnet build`, `dotnet restore`, `dotnet clean`, along with MSBuild integration, multi-targeting, and build optimization strategies.

## Relationships
Enables: Application development, Testing workflows, Publishing preparation, CI/CD automation
Conflicts with: None (fundamental workflow)
Alternative to: Manual MSBuild invocation, IDE-specific build systems
Prerequisite: .NET SDK installation, Project files (*.csproj, *.sln)
Synergistic with: Package management, Testing frameworks, Publishing workflows, Code analysis tools

## Metadata
Name: Build and Compilation
ID: build-and-compilation
Category: CLI
Description: Build and compilation encompasses the development-time workflow of transforming source code into executable binaries, managing dependencies, and preparing projects for testing and deployment.
Complexity: 0.5
Audience: All .NET developers | DevOps engineers | Build engineers
Priority: 1 (Critical)
Introduced-Version: 1.0
Introduced-Year: 2016

## Official Sources
Documentation: https://docs.microsoft.com/dotnet/core/tools/dotnet-build
Announcement: https://devblogs.microsoft.com/dotnet/announcing-net-core-1-0/

## Primary Sources
- https://raw.githubusercontent.com/dotnet/docs/main/docs/core/tools/dotnet-build.md
- https://raw.githubusercontent.com/dotnet/docs/main/docs/core/tools/dotnet-restore.md
- https://raw.githubusercontent.com/dotnet/docs/main/docs/core/tools/dotnet-clean.md

## Secondary Sources
- https://github.com/dotnet/msbuild
- Build performance optimization guides and CI/CD best practices
- Multi-targeting strategies and community tutorials

## Generation Hints
Emphasize: Core workflow commands, Dependency management, Build configurations, Performance optimization
Avoid: Complex MSBuild internals, IDE-specific workflows
Cross-reference discover from: project-management, development-workflow, msbuild
Cross-reference surface to: publishing-and-deployment, testing, package-management, ci-cd

## Token Budget Guidance
Minimum viable content: 600 tokens - Basic build, restore, clean commands with essential options
Comprehensive coverage: 2400 tokens - Build configurations, dependencies, multi-targeting, optimization
Full reference: 4800 tokens - Advanced MSBuild integration, enterprise scenarios, performance tuning
