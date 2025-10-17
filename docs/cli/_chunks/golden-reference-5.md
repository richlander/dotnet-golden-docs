# Build performance optimization
## Integration & Environment

### IDE and Editor Integration

The CLI integrates seamlessly with development environments.

Visual Studio Integration: The CLI commands power Visual Studio's build system, with all operations ultimately translating to CLI calls.

VS Code Integration: The C# extension uses the CLI for IntelliSense, debugging, and build tasks. The integrated terminal provides direct CLI access.

Command Line Development: Full-featured development workflow using only the CLI and text editors, particularly valuable for remote development and containers.

### Development Workflow Patterns

Established patterns for efficient CLI-based development.

Watch-Driven Development:

```bash
# Auto-rebuild and restart on file changes
dotnet watch run

# Auto-test on changes
dotnet watch test --project MyApp.Tests
```

Configuration Management:

```bash
# Environment-specific builds
dotnet build --configuration Development
dotnet build --configuration Release
dotnet build --configuration Docker

# Multiple target frameworks
dotnet build --framework net8.0
dotnet build --framework net481
```

### CI/CD Pipeline Integration

The CLI is designed for automation and continuous integration scenarios.

Optimized CI Pipeline Commands:

```bash
# Comprehensive CI workflow
dotnet restore --locked-mode --packages /packages
dotnet build --no-restore --configuration Release
dotnet test --no-build --logger trx --results-directory /results
dotnet publish --no-build --configuration Release --output /publish

# Build performance optimization
dotnet build --no-dependencies      # Skip dependency building
dotnet build --no-incremental       # Force full rebuild
dotnet build -m:1                   # Control parallel builds
