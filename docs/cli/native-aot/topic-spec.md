# Native AOT - Topic Specification

## Feature Description
Native AOT (Ahead-of-Time) compilation is a publishing model that compiles .NET applications directly to native code at build time, eliminating the need for a just-in-time (JIT) compiler at runtime. This results in faster startup times, reduced memory footprint, and self-contained executables that don't require the .NET runtime to be installed on the target machine.

## Relationships
Enables: Fast startup times, Reduced memory usage, Self-contained deployment, Container optimization, Edge computing scenarios
Conflicts with: Dynamic code generation, Assembly.LoadFile, System.Reflection.Emit, C++/CLI
Alternative to: JIT compilation, Self-contained deployment, ReadyToRun
Prerequisite: .NET 7+ SDK, Platform-specific toolchain (C++ build tools)
Synergistic with: Source generators, Trimming, Single-file deployment, Container images

## Hierarchy
Name: Native AOT
ID: native-aot
Category: CLI
Description: Native AOT (Ahead-of-Time) compilation is a publishing model that compiles .NET applications directly to native code at build time, eliminating the need for a just-in-time (JIT) compiler at runtime.
Category: CLI
Complexity: Intermediate | Advanced
Audience: Performance-focused developers | Cloud developers | Desktop app developers
Priority: 2 (Common)

## Source Authority
Primary Sources (High confidence):
- https://docs.microsoft.com/en-us/dotnet/core/deploying/native-aot/ - Official Native AOT documentation - Last verified: 2023-06-12
- https://docs.microsoft.com/en-us/dotnet/core/whats-new/dotnet-10/sdk - .NET 10 file-based apps with Native AOT - Last verified: 2025-09-09
- https://docs.microsoft.com/en-us/dotnet/core/deploying/native-aot/cross-compile - Cross-compilation guide - Last verified: 2023-10-10
- https://github.com/dotnet/samples/tree/main/core/nativeaot - Official samples - Last verified: 2024-09-12

Secondary Sources (Good quality):
- Platform-specific setup guides, Performance benchmarks, Community migration experiences

Validation Requirements:
- [ ] Code examples compile and run across supported platforms
- [ ] Native AOT publish process completes successfully
- [ ] Performance benchmarks vs JIT compilation
- [ ] Cross-platform compatibility testing (Windows/Linux/macOS)

## Generation Hints
Emphasize: Performance benefits, Startup time improvements, Memory efficiency, Deployment simplicity
Avoid: Complex reflection scenarios, Dynamic code generation use cases
Cross-reference discover from: publishing, deployment-models, performance-optimization
Cross-reference surface to: trimming, single-file, containers, aspnet-core

## Token Budget Guidance
Minimum viable content: 600 tokens - Basic publishing with PublishAot, key benefits and limitations
Comprehensive coverage: 2400 tokens - Platform setup, advanced scenarios, troubleshooting, .NET 10 features
Full reference: 4800 tokens - Cross-compilation, performance optimization, compatibility analysis, enterprise scenarios