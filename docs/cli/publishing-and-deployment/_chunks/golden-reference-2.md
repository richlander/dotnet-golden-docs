# Container publishing (.NET 8+)
## Publishing Mode Decision Matrix
### Native AOT Deployment

Use case: Ultimate performance, memory-constrained environments, cloud functions
Benefits: Fastest startup, smallest memory footprint, no runtime dependency
Limitations: Limited reflection support, framework compatibility restrictions

```bash
# Native AOT publishing
dotnet publish -r win-x64 -p:PublishAot=true
dotnet publish -r linux-x64 -p:PublishAot=true -c Release
```

### Container Deployment

Use case: Cloud-native applications, microservices, scalable deployments
Benefits: Consistent deployment environment, scalability, cloud integration
Integration: Direct container image creation without Dockerfile

```bash
# Container publishing (.NET 8+)
dotnet publish -t:PublishContainer
dotnet publish -t:PublishContainer -r linux-x64
dotnet publish -p:PublishProfile=DefaultContainer
```

## Publishing Mode Decision Matrix

### By Deployment Scenario

| Scenario | Recommended Mode | Rationale |
|----------|------------------|-----------|
| Enterprise Web Apps | Framework-dependent | Shared runtime, security updates, smaller deployments |
| Desktop Applications | Self-contained + Single-file | No runtime dependency, easy distribution |
| Cloud Microservices | Container + ReadyToRun | Fast startup, consistent environment |
| Serverless Functions | Native AOT | Fastest cold start, minimal memory usage |
| IoT Devices | Self-contained + Trimmed | Resource constraints, no runtime installation |
| Development Tools | Single-file | Easy distribution, developer experience |

### By Performance Requirements

| Priority | Deployment Size | Startup Time | Memory Usage | Recommended Approach |
|----------|----------------|--------------|--------------|---------------------|
| Minimal Size | Framework-dependent | Framework-dependent | Native AOT | Framework-dependent |
| Fastest Startup | Native AOT | Native AOT | Native AOT | Native AOT |
| Lowest Memory | Native AOT | Native AOT | Native AOT | Native AOT + Trimming |
| Balanced | Self-contained + ReadyToRun | ReadyToRun | Self-contained | Self-contained + ReadyToRun |
