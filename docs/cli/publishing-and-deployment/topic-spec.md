# Publishing and Deployment - Topic Specification

## Feature Description
Publishing and deployment encompasses the distribution-time workflow of preparing .NET applications for production use, including packaging, optimization, and deployment strategies. This covers all publishing modes from framework-dependent to self-contained, single-file, Native AOT, and container deployment, along with the decision matrix for choosing appropriate deployment strategies.

## Relationships
Enables: Production deployment, Application distribution, Performance optimization, Platform targeting
Conflicts with: None (comprehensive workflow)
Alternative to: Manual deployment processes, Platform-specific packaging
Prerequisite: Successful build compilation, Target platform selection
Synergistic with: Build and compilation, Assembly trimming, Native AOT, Container technologies

## Metadata
Name: Publishing and Deployment
ID: publishing-and-deployment
Category: CLI
Description: Publishing and deployment encompasses the distribution-time workflow of preparing .NET applications for production use, including packaging, optimization, and deployment strategies.
Complexity: 0.6
Audience: All .NET developers | DevOps engineers | System administrators
Priority: 1 (Critical)
Introduced-Version: 1.0
Introduced-Year: 2016

## Official Sources
Documentation: https://docs.microsoft.com/dotnet/core/tools/dotnet-publish
Announcement: https://devblogs.microsoft.com/dotnet/announcing-net-core-1-0/

## Primary Sources
- https://raw.githubusercontent.com/dotnet/docs/main/docs/core/tools/dotnet-publish.md
- https://raw.githubusercontent.com/dotnet/docs/main/docs/core/deploying/index.md
- https://raw.githubusercontent.com/dotnet/docs/main/docs/core/rid-catalog.md

## Secondary Sources
- https://github.com/dotnet/core/tree/main/release-notes
- Container deployment guides and cloud platform documentation
- CI/CD best practices and community tutorials

## Generation Hints
Emphasize: Publishing mode comparison, Decision guidance, Platform targeting, Optimization strategies
Avoid: Build-time concerns (covered in build-and-compilation), Implementation details of specific optimizations
Cross-reference discover from: deployment, distribution, publishing-modes, dotnet-publish
Cross-reference surface to: native-aot, assembly-trimming, single-file-deployment, build-and-compilation

## Token Budget Guidance
Minimum viable content: 600 tokens - Basic framework-dependent vs self-contained publishing
Comprehensive coverage: 2400 tokens - All publishing modes, decision matrix, platform considerations, optimization strategies
Full reference: 4800 tokens - Advanced scenarios, enterprise deployment, performance optimization, troubleshooting
