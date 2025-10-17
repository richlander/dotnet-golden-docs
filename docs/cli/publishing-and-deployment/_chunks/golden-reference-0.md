# Publishing and Deployment

## Overview

Publishing and deployment is the distribution-time workflow that transforms build artifacts into production-ready applications. The .NET CLI provides multiple publishing modes optimized for different deployment scenarios, from simple framework-dependent deployments to highly optimized Native AOT executables.

Publishing fundamentally differs from building:

- Build: Development-time compilation for testing and debugging
- Publish: Distribution-time packaging for production deployment

Core publishing principles:

- Deployment target awareness: Framework-dependent vs self-contained strategies
- Performance optimization: ReadyToRun, trimming, Native AOT compilation
- Distribution optimization: Single-file packaging, container deployment
- Platform targeting: Runtime identifier (RID) specification for cross-platform deployment

The publishing system serves multiple deployment scenarios:

- Desktop applications: Self-contained executables with optimal startup
- Cloud services: Container-optimized deployments with minimal footprint
- IoT devices: Trimmed applications for resource-constrained environments
- Enterprise applications: Framework-dependent deployments with shared runtimes
