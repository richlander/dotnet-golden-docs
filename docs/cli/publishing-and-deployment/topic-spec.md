# Publishing and Deployment - Topic Specification

## Feature Description
Publishing and deployment encompasses the distribution-time workflow of preparing .NET applications for production use, including packaging, optimization, and deployment strategies. This covers all publishing modes from framework-dependent to self-contained, single-file, Native AOT, and container deployment, along with the decision matrix for choosing appropriate deployment strategies.

## Relationships
Enables: Production deployment, Application distribution, Performance optimization, Platform targeting
Conflicts with: None (comprehensive workflow)
Alternative to: Manual deployment processes, Platform-specific packaging
Prerequisite: Successful build compilation, Target platform selection
Synergistic with: Build and compilation, Assembly trimming, Native AOT, Container technologies

## Hierarchy
Name: Publishing and Deployment
ID: publishing-and-deployment
Category: CLI
Complexity: Beginner | Intermediate | Advanced
Audience: All .NET developers | DevOps engineers | System administrators
Priority: 1 (Critical)

## Source Authority
Primary Sources (High confidence):
- https://docs.microsoft.com/en-us/dotnet/core/tools/dotnet-publish - dotnet publish command reference - Last verified: 2025-01-07
- https://docs.microsoft.com/en-us/dotnet/core/deploying/index - Application publishing overview - Last verified: 2025-08-11
- https://docs.microsoft.com/en-us/dotnet/core/rid-catalog - Runtime Identifier catalog - Last verified: 2024-08-25
- https://docs.microsoft.com/en-us/dotnet/core/deploying/ready-to-run - ReadyToRun compilation - Last verified: 2024-07-15

Secondary Sources (Good quality):
- Container deployment guides, Cloud platform documentation, CI/CD best practices

Validation Requirements:
- [ ] Publishing commands work across all supported platforms
- [ ] Deployment strategies verified in production-like environments
- [ ] Performance comparisons between publishing modes
- [ ] Container and cloud deployment examples functional

## Generation Hints
Emphasize: Publishing mode comparison, Decision guidance, Platform targeting, Optimization strategies
Avoid: Build-time concerns (covered in build-and-compilation), Implementation details of specific optimizations
Cross-reference discover from: deployment, distribution, publishing-modes, dotnet-publish
Cross-reference surface to: native-aot, assembly-trimming, single-file-deployment, build-and-compilation

## Token Budget Guidance
Minimum viable content: 600 tokens - Basic framework-dependent vs self-contained publishing
Comprehensive coverage: 2400 tokens - All publishing modes, decision matrix, platform considerations, optimization strategies
Full reference: 4800 tokens - Advanced scenarios, enterprise deployment, performance optimization, troubleshooting