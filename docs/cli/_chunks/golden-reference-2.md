# Package creation and publishing
dotnet pack                          # Pack libraries into NuGet packages
dotnet pack --configuration Release --output ./artifacts
dotnet nuget push MyPackage.1.0.0.nupkg --api-key YOUR_API_KEY --source https://api.nuget.org/v3/index.json
```

### Testing and Quality Assurance

```bash
# Testing commands
dotnet test                          # Run all tests in solution
dotnet test --logger trx            # Run tests with specific logger
dotnet test --collect:"XPlat Code Coverage"  # Run with coverage
dotnet test MyApp.Tests              # Run specific test projects
dotnet test --filter "Category=Integration"  # Filter tests

# Code formatting and analysis
dotnet format                        # Format code according to style rules
dotnet format --verify-no-changes   # Verify formatting in CI scenarios
dotnet build --verbosity normal     # Shows analyzer warnings
```

### Publishing and Deployment

```bash
# Basic publishing
dotnet publish                       # Publish framework-dependent
dotnet publish -r win-x64           # Publish self-contained for Windows
dotnet publish -c Release           # Publish in Release configuration

# Advanced publishing modes
dotnet publish -p:PublishSingleFile=true    # Single-file deployment
dotnet publish -p:PublishTrimmed=true       # Trimmed deployment
dotnet publish -p:PublishAot=true           # Native AOT compilation
dotnet publish -p:PublishReadyToRun=true    # ReadyToRun optimization

# Cross-platform publishing
dotnet publish -r linux-x64         # Linux 64-bit
dotnet publish -r osx-arm64          # macOS Apple Silicon
dotnet publish -r win-arm64          # Windows ARM64
```

### Tool and Workload Management

```bash
# Global tool management
dotnet tool install -g dotnet-ef    # Install global tool
dotnet tool list -g                 # List installed global tools
dotnet tool update -g ToolName      # Update specific tool
