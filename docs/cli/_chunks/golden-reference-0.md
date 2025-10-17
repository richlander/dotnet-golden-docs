# .NET CLI

## Overview

The .NET CLI (Command-Line Interface) is the primary cross-platform toolchain for developing, building, testing, and deploying .NET applications. It provides a unified command-line experience across Windows, macOS, and Linux for all stages of the application development lifecycle.

The CLI operates through the `dotnet` command as a generic driver that provides two main functions:

1. SDK commands: Tools for project development, building, testing, and deployment
2. Runtime host: Execution of .NET applications and libraries

Key architectural principles:

- Cross-platform: Consistent experience across all supported operating systems
- SDK-based: Commands require SDK installation, runtime hosting requires only runtime
- Extensible: Support for global and local tools, workloads, and project templates
- Version-aware: Multiple SDK and runtime versions can coexist

The CLI serves multiple audiences:

- Developers: Primary development workflow through command-line
- DevOps engineers: CI/CD pipeline automation and deployment
- System administrators: Runtime and SDK management
- Tool authors: Platform for building additional development tools
