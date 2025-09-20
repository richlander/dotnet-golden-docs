# Native AOT - Topic Specification

## Feature Description
Native AOT (Ahead-of-Time) compilation is a publishing model that compiles .NET applications directly to native code at build time, eliminating the need for a just-in-time (JIT) compiler at runtime. This results in faster startup times, reduced memory footprint, and self-contained executables that don't require the .NET runtime to be installed on the target machine.

## Relationships
Enables: Fast startup times, Reduced memory usage, Self-contained deployment, Container optimization, Edge computing scenarios
Conflicts with: Dynamic code generation, Assembly.LoadFile, System.Reflection.Emit, C++/CLI
Alternative to: JIT compilation, Self-contained deployment, ReadyToRun
Prerequisite: .NET 7+ SDK, Platform-specific toolchain (C++ build tools)
Synergistic with: Source generators, Trimming, Single-file deployment, Container images

## Metadata
Name: Native AOT
ID: native-aot
Category: CLI
Description: Native AOT (Ahead-of-Time) compilation is a publishing model that compiles .NET applications directly to native code at build time, eliminating the need for a just-in-time (JIT) compiler at runtime.
Complexity: 0.7
Audience: Performance-focused developers | Cloud developers | Desktop app developers
Priority: 2 (Common)
Introduced-Version: 7.0
Introduced-Year: 2022

## Official Sources
Documentation: https://docs.microsoft.com/dotnet/core/deploying/native-aot/
Announcement: https://devblogs.microsoft.com/dotnet/announcing-dotnet-7-preview-3/

## Primary Sources
- https://raw.githubusercontent.com/dotnet/docs/main/docs/core/deploying/native-aot/index.md
- https://raw.githubusercontent.com/dotnet/docs/main/docs/core/deploying/native-aot/cross-compile.md
- https://raw.githubusercontent.com/dotnet/core/main/release-notes/7.0/7.0.0/7.0.0.md

## Secondary Sources
- https://github.com/dotnet/samples/tree/main/core/nativeaot
- Platform-specific setup guides and performance benchmarks
- Community migration experiences

## Generation Hints
Emphasize: Performance benefits, Startup time improvements, Memory efficiency, Deployment simplicity
Avoid: Complex reflection scenarios, Dynamic code generation use cases
Cross-reference discover from: publishing, deployment-models, performance-optimization
Cross-reference surface to: trimming, single-file, containers, aspnet-core

## Token Budget Guidance
Minimum viable content: 600 tokens - Basic publishing with PublishAot, key benefits and limitations
Comprehensive coverage: 2400 tokens - Platform setup, advanced scenarios, troubleshooting, .NET 10 features
Full reference: 4800 tokens - Cross-compilation, performance optimization, compatibility analysis, enterprise scenarios
