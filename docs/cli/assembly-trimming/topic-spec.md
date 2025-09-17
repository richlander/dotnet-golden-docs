# Assembly Trimming - Topic Specification

## Feature Description
Assembly trimming is a size-reduction optimization for self-contained .NET applications that removes unused code from the application and its dependencies. The trimmer performs build-time analysis to identify and eliminate code that is not statically reachable, significantly reducing deployment size while maintaining application functionality.

## Relationships
Enables: Reduced deployment size, Faster deployment, Lower storage costs, Improved container performance
Conflicts with: Dynamic assembly loading, Unbounded reflection, C++/CLI, WPF/WinForms (currently)
Alternative to: Manual dependency reduction, Framework-dependent deployment
Prerequisite: Self-contained deployment, .NET 6+ (fully supported), Static code analysis compatibility
Synergistic with: Native AOT compilation, Single-file deployment, Source generators

## Hierarchy
Name: Assembly Trimming
ID: assembly-trimming
Category: CLI
Complexity: Intermediate | Advanced
Audience: Performance-focused developers | Cloud developers | Library authors
Priority: 2 (Common)

## Source Authority
Primary Sources (High confidence):
- https://docs.microsoft.com/en-us/dotnet/core/deploying/trimming/trim-self-contained - Main trimming guide - Last verified: 2020-04-03
- https://docs.microsoft.com/en-us/dotnet/core/deploying/trimming/trimming-options - Trimming configuration options - Last verified: 2025-05-01
- https://docs.microsoft.com/en-us/dotnet/core/deploying/trimming/incompatibilities - Known incompatibilities - Last verified: 2023-11-08
- https://docs.microsoft.com/en-us/dotnet/core/deploying/trimming/prepare-libraries-for-trimming - Library preparation guide - Last verified: 2023-06-12

Secondary Sources (Good quality):
- ILLink tool documentation, Community trimming experiences, Platform-specific optimization guides

Validation Requirements:
- [ ] Code examples compile and run with trimming enabled
- [ ] Library compatibility analysis across major frameworks
- [ ] Size reduction benchmarks vs untrimmed deployments
- [ ] Cross-platform trimming behavior verification

## Generation Hints
Emphasize: Size reduction benefits, Build-time analysis, Library compatibility, Warning resolution
Avoid: Dynamic code generation scenarios, Complex reflection patterns
Cross-reference discover from: publishing, deployment-optimization, size-reduction
Cross-reference surface to: native-aot, single-file, source-generators, library-compatibility

## Token Budget Guidance
Minimum viable content: 600 tokens - Basic PublishTrimmed usage, key benefits and limitations
Comprehensive coverage: 2400 tokens - Configuration options, warning resolution, library preparation, incompatibilities
Full reference: 4800 tokens - Advanced scenarios, custom annotations, library authoring best practices