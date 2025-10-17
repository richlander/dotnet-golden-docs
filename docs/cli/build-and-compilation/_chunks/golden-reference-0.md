# Build and Compilation

## Overview

Build and compilation is the foundational development workflow that transforms source code into executable binaries, manages project dependencies, and prepares applications for testing and deployment. The .NET CLI provides a unified, cross-platform build experience through MSBuild integration that works consistently across Windows, macOS, and Linux.

Core build workflow stages:

1. Dependency resolution: Restore NuGet packages and project references
2. Compilation: Transform source code to Intermediate Language (IL)
3. Assembly generation: Create .dll files and executable binaries
4. Asset preparation: Generate runtime configuration and dependency files

Key principles:

- Incremental builds: Only rebuild changed components for performance
- Parallel compilation: Utilize multiple CPU cores for faster builds
- Multi-targeting: Build for multiple .NET framework versions simultaneously
- Configuration-based: Support Debug, Release, and custom build configurations

The build system serves multiple audiences:

- Developers: Local development and debugging workflows
- DevOps engineers: CI/CD pipeline automation and optimization
- Build engineers: Complex build orchestration and performance tuning
