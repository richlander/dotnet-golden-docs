# Version management and consistency
## Gotchas and Limitations
### Developer Productivity Tools

```bash
# Development server and hot reload
dotnet watch run                     # Auto-restart on file changes
dotnet dev-certs https --trust       # Setup HTTPS development certificates

# Code generation and scaffolding
dotnet add package Microsoft.EntityFrameworkCore.Tools
dotnet ef migrations add InitialCreate
dotnet ef database update
```

## Team Development Patterns

CLI usage patterns that support team collaboration:

- Solution Organization: Using solution files to group related projects and enable efficient bulk operations
- Tool Manifests: Committing tool manifests to ensure consistent tooling across team members
- Global.json: Pinning SDK versions for consistent builds across development machines

## Project Template Customization

```bash
# Custom template creation and usage
dotnet new install ./MyTemplate     # Install custom template
dotnet new mytemplate -n NewProject # Use custom template
dotnet new uninstall MyTemplate     # Remove custom template
```

## Enterprise and Team Development

```bash
# Centralized package management
dotnet nuget config set repositoryPath /shared/packages

# Version management and consistency
dotnet sdk check                    # Check SDK compatibility
dotnet workload repair              # Repair workload installations
```

## Gotchas and Limitations

### Version and Compatibility Management

- Multiple SDK versions: Global.json controls which SDK version is used
- Runtime compatibility: Forward compatibility generally works, but breaking changes exist
- Platform differences: Some commands behave differently across operating systems
- Path limitations: Long paths can cause issues on Windows without proper configuration
