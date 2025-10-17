# Solution-level operations
dotnet build MySolution.sln         # Build entire solution
dotnet test MySolution.sln          # Test entire solution
```

## Architecture and Design Patterns

### Command Structure and Organization

The CLI follows a hierarchical command structure:

- Root command: `dotnet` provides global options and runtime hosting
- Verb commands: Primary actions like `build`, `test`, `publish`
- Noun commands: Object-focused like `sln`, `package`, `reference`
- Composite commands: Multi-level like `dotnet tool install`, `dotnet workload list`

### Configuration and Customization

```bash
# Global configuration
dotnet nuget config set globalPackagesFolder /path/to/packages
dotnet nuget config set repositoryPath /shared/packages

# Environment-specific behavior
export DOTNET_CLI_TELEMETRY_OPTOUT=1  # Disable telemetry
export DOTNET_SKIP_FIRST_TIME_EXPERIENCE=1  # Skip welcome experience
```

### Integration Patterns

```bash
# CI/CD integration patterns
dotnet restore --locked-mode         # Ensure reproducible builds
dotnet build --no-restore           # Skip restore in pipeline
dotnet test --no-build              # Skip build in testing phase
dotnet publish --no-build           # Skip build in deployment phase

# Multi-target framework handling
dotnet build -f net8.0              # Build specific framework
dotnet test -f net8.0               # Test specific framework
```
