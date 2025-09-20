# Assembly Trimming - Topic Specification

## Feature Description
Assembly trimming is a size-reduction optimization for self-contained .NET applications that removes unused code from the application and its dependencies. The trimmer performs build-time analysis to identify and eliminate code that is not statically reachable, significantly reducing deployment size while maintaining application functionality.

## Relationships
Enables: Reduced deployment size, Faster deployment, Lower storage costs, Improved container performance
Conflicts with: Dynamic assembly loading, Unbounded reflection, C++/CLI, WPF/WinForms (currently)
Alternative to: Manual dependency reduction, Framework-dependent deployment
Prerequisite: Self-contained deployment, .NET 6+ (fully supported), Static code analysis compatibility
Synergistic with: Native AOT compilation, Single-file deployment, Source generators

## Metadata
Name: Assembly Trimming
ID: assembly-trimming
Category: CLI
Description: Assembly trimming is a size-reduction optimization for self-contained .NET applications that removes unused code from the application and its dependencies.
Complexity: 0.7
Audience: Performance-focused developers | Cloud developers | Library authors
Priority: 2 (Common)
Introduced-Version: 6.0
Introduced-Year: 2021

## Official Sources
Documentation: https://docs.microsoft.com/dotnet/core/deploying/trimming/trim-self-contained
Announcement: https://devblogs.microsoft.com/dotnet/announcing-net-6/

## Primary Sources
- https://raw.githubusercontent.com/dotnet/docs/main/docs/core/deploying/trimming/trim-self-contained.md
- https://raw.githubusercontent.com/dotnet/docs/main/docs/core/deploying/trimming/trimming-options.md
- https://raw.githubusercontent.com/dotnet/docs/main/docs/core/deploying/trimming/incompatibilities.md

## Secondary Sources
- https://github.com/mono/linker
- Community trimming experiences and platform-specific guides
- ILLink tool documentation

## Generation Hints
Emphasize: Size reduction benefits, Build-time analysis, Library compatibility, Warning resolution
Avoid: Dynamic code generation scenarios, Complex reflection patterns
Cross-reference discover from: publishing, deployment-optimization, size-reduction
Cross-reference surface to: native-aot, single-file, source-generators, library-compatibility

## Token Budget Guidance
Minimum viable content: 600 tokens - Basic PublishTrimmed usage, key benefits and limitations
Comprehensive coverage: 2400 tokens - Configuration options, warning resolution, library preparation, incompatibilities
Full reference: 4800 tokens - Advanced scenarios, custom annotations, library authoring best practices
