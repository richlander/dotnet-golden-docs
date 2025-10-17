# Local tool management
dotnet new tool-manifest            # Create tool manifest
dotnet tool install dotnet-ef       # Install project-local tool
dotnet tool run dotnet-ef           # Run local tool
dotnet ef migrations add InitialCreate  # Tool commands available directly

# Workload management
dotnet workload list                 # List available workloads
dotnet workload install maui        # Install specific workload
dotnet workload search              # Search available workloads
dotnet workload update              # Update all workloads
dotnet workload repair              # Repair workload installations
```

### Runtime and Environment Information

```bash
# Environment inspection
dotnet --info                       # Detailed environment information
dotnet --version                    # SDK version information
dotnet --list-sdks                  # List installed SDKs
dotnet --list-runtimes              # List installed runtimes
dotnet sdk check                    # Check SDK compatibility
```

## Modern CLI Features

### File-Based Applications

Streamlined development for single-file scenarios without project overhead.

```bash
# Run single C# files directly
dotnet run hello-world.cs
dotnet run script.cs -- arg1 arg2

# Publish file-based apps
dotnet publish hello-world.cs --configuration Release --output ./dist
```

### Solution Management

Comprehensive solution file management and organization.

```bash
# Create solutions
dotnet new sln -n MySolution

# Add projects to solutions
dotnet sln add MyApp/MyApp.csproj
dotnet sln add MyLib/MyLib.csproj
dotnet sln add **/*.csproj          # Add all projects

# List solution projects
dotnet sln list
