# Project references
## Essential Command Categories

### Project Management Commands

```bash
# Project creation and templates
dotnet new console                    # Create new console application
dotnet new webapi                     # Create new Web API project
dotnet new sln                        # Create solution file
dotnet sln add MyProject.csproj       # Add project to solution

# List available templates
dotnet new list

# Install custom templates
dotnet new install Microsoft.AspNetCore.SpaTemplates

# Project building and compilation
dotnet build                          # Build project in current directory
dotnet build -c Release              # Build in Release configuration
dotnet clean                          # Clean build outputs

# Running applications
dotnet run                            # Run application in current directory
dotnet run --project MyApp            # Run specific project
dotnet run -- arg1 arg2              # Pass arguments to application
dotnet MyApp.dll                     # Run specific application
dotnet exec MyApp.dll                # Execute with explicit path

# Watch for changes and auto-rebuild/rerun
dotnet watch run
dotnet watch test
```

### Package and Dependency Management

```bash
# NuGet package management
dotnet add package Newtonsoft.Json   # Add package reference
dotnet add package Microsoft.EntityFrameworkCore --version 7.0.0
dotnet remove package PackageName    # Remove package reference
dotnet list package                  # List package references
dotnet list package --outdated       # Check for outdated packages
dotnet restore                       # Restore project dependencies

# Project references
dotnet add reference ../MyLib.csproj # Add project reference
dotnet list reference               # List project references
