# ReadyToRun publishing
## Publishing Modes Overview

### Framework-Dependent Deployment (Default)

Use case: Shared runtime environments, enterprise deployments
Benefits: Smallest deployment size, automatic security updates, cross-platform portability
Requirements: Target runtime must be pre-installed

```bash
# Basic framework-dependent publishing
dotnet publish                            # Current platform, Debug config
dotnet publish -c Release                # Release configuration
dotnet publish -r win-x64                # Platform-specific executable
dotnet publish -f net8.0                 # Specific target framework
```

### Self-Contained Deployment

Use case: Isolated deployments, controlled runtime versions
Benefits: No runtime installation required, version control, deployment independence
Trade-offs: Larger deployment size, manual security updates

```bash
# Self-contained publishing
dotnet publish -r win-x64 --self-contained        # Windows 64-bit
dotnet publish -r linux-x64 --self-contained      # Linux 64-bit
dotnet publish -r osx-arm64 --self-contained      # macOS Apple Silicon
```

### Single-File Deployment

Use case: Simplified distribution, desktop applications, utility tools
Benefits: Single executable file, easy deployment, reduced file clutter
Considerations: Larger executable size, slower cold start

```bash
# Single-file deployment
dotnet publish -r win-x64 -p:PublishSingleFile=true
dotnet publish -r linux-x64 -p:PublishSingleFile=true --self-contained
```

### ReadyToRun Compilation

Use case: Improved startup performance, frequent application restarts
Benefits: Faster startup time, reduced JIT overhead, better first-run performance
Trade-offs: Larger deployment size, longer build time

```bash
# ReadyToRun publishing
dotnet publish -r win-x64 -p:PublishReadyToRun=true
dotnet publish -c Release -p:PublishReadyToRun=true --self-contained
```
