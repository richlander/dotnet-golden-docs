# Build and runtime issues
### Performance Considerations

- First-time experience: Initial package restore and template downloads can be slow
- Parallel builds: Default parallelism may overwhelm system resources
- Incremental builds: Not always reliable with complex project graphs
- Package caching: Global package cache can grow large over time
- Cold Start: First restore operations can be slow due to package downloads and cache population
- Large Solutions: Very large solutions with many projects may have slower build and restore times
- Network Dependencies: Package restore and tool operations require network access and can be affected by connectivity issues

### Common Error Scenarios

```bash
# Network and authentication issues
dotnet nuget list source            # Verify configured sources
dotnet nuget config set credentialProviders /path/to/provider

# Build and runtime issues
dotnet clean && dotnet restore      # Clear build cache
dotnet --info | grep "RID"          # Verify runtime identifier
```

### Platform-Specific Limitations

- Path Length: Windows path length limitations can affect deep project hierarchies
- File Permissions: Unix-like systems require explicit executable permissions for published outputs
- Case Sensitivity: File system case sensitivity differences between platforms can cause issues

### Security and Trust Considerations

- Package source verification: Always verify package sources in enterprise environments
- Code signing: Consider package signature verification for security-critical applications
- Telemetry and privacy: CLI collects telemetry by default, can be disabled
- Tool installation: Global tools run with user permissions, verify before installing
