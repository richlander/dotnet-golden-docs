# Build and Compilation - Q&A Pairs

## Basic Build Commands Questions

Q: What's the difference between dotnet build and dotnet run?
A: `dotnet build` compiles your project into binaries without executing it, while `dotnet run` builds and immediately executes the application. Use `dotnet build` to verify compilation success and `dotnet run` for development testing.

Q: How do I build a specific project in a solution with multiple projects?
A: Use `dotnet build MyProject.csproj` to build a specific project, or `dotnet build --project MyProject` when working from the solution directory. You can also navigate to the project directory and run `dotnet build`.

Q: What does dotnet restore do and when do I need it?
A: `dotnet restore` downloads NuGet packages and resolves project dependencies. It's automatically run by most commands (build, run, test), but you may need it explicitly in CI/CD scenarios or when dependencies change.

Q: How do I clean build artifacts?
A: Use `dotnet clean` to remove build outputs from the current project. Add `-c Release` to clean specific configurations or `-f net8.0` to clean specific target frameworks.

Q: What's the difference between Debug and Release builds?
A: Debug builds include debugging symbols, disable optimizations, and define DEBUG constants for easier debugging. Release builds enable optimizations, remove debug symbols, and are suitable for production deployment.

## Build Configuration Questions

Q: How do I build in Release configuration?
A: Use `dotnet build -c Release` or `dotnet build --configuration Release`. Release configuration enables optimizations and is recommended for production deployments.

Q: How do I build for a specific target framework?
A: Use `dotnet build -f net8.0` to build for .NET 8, or `dotnet build --framework net6.0` for .NET 6. This is useful for multi-target projects.

Q: How do I build for a specific platform or runtime?
A: Use `dotnet build -r win-x64` for Windows 64-bit, `dotnet build -r linux-x64` for Linux, or `dotnet build -r osx-arm64` for macOS Apple Silicon.

Q: How do I create a custom build configuration?
A: Add a new configuration in your project file:

```xml
<PropertyGroup Condition="'$(Configuration)' == 'Staging'">
    <Optimize>true</Optimize>
    <DefineConstants>STAGING</DefineConstants>
</PropertyGroup>
```

Then build with `dotnet build -c Staging`.

Q: How do I set MSBuild properties from the command line?
A: Use `-p:PropertyName=Value` syntax, like `dotnet build -p:TreatWarningsAsErrors=true` or `dotnet build -p:VersionPrefix=1.2.3`.

## Multi-Targeting and Framework Questions

Q: How do I build a library that targets multiple .NET versions?
A: Set multiple target frameworks in your project file:

```xml
<PropertyGroup>
    <TargetFrameworks>net8.0;net6.0;netstandard2.0</TargetFrameworks>
</PropertyGroup>
```

Then `dotnet build` will build for all targets.

Q: How do I build only one framework from a multi-target project?
A: Use `dotnet build -f net8.0` to build only the .NET 8 target, or `dotnet build --framework netstandard2.0` for .NET Standard 2.0.

Q: How do I add framework-specific dependencies?
A: Use conditional item groups:

```xml
<ItemGroup Condition="'$(TargetFramework)' == 'net6.0'">
    <PackageReference Include="System.Text.Json" Version="6.0.0" />
</ItemGroup>
```

Q: What's the difference between TargetFramework and TargetFrameworks?
A: `<TargetFramework>` (singular) specifies one target framework. `<TargetFrameworks>` (plural) specifies multiple frameworks separated by semicolons for multi-targeting.

## Performance and Optimization Questions

Q: How do I speed up my builds?
A: Use incremental builds (`dotnet build` without `--no-incremental`), enable parallel builds (default), skip restore when dependencies haven't changed (`dotnet build --no-restore`), and use build servers for caching.

Q: What does --no-restore do and when should I use it?
A: `--no-restore` skips the package restore phase. Use it in CI/CD when you've already run `dotnet restore` separately, or during development when you know dependencies haven't changed.

Q: How do I force a complete rebuild?
A: Use `dotnet build --no-incremental` to force rebuilding all files, or `dotnet clean && dotnet build` to remove all artifacts and rebuild from scratch.

Q: How do I control build parallelism?
A: Use `-m:N` where N is the number of parallel processes: `dotnet build -m:1` for single-threaded builds, or `dotnet build -m:4` to use 4 processes. Default is optimal for your CPU.

Q: What are build servers and should I disable them?
A: Build servers cache compilation for faster subsequent builds. Disable with `--disable-build-servers` only for troubleshooting or clean CI environments where caching might cause issues.

## Dependency Management Questions

Q: How do I restore packages from a specific source?
A: Use `dotnet restore --source https://api.nuget.org/v3/index.json` or configure sources in nuget.config file. Multiple sources can be specified with multiple `--source` parameters.

Q: What is packages.lock.json and how do I use it?
A: It's a lock file that ensures reproducible builds by pinning exact package versions. Generate with `dotnet restore --use-lock-file` and use `dotnet restore --locked-mode` in CI/CD.

Q: How do I force package re-download?
A: Use `dotnet restore --force` to re-evaluate dependencies and `dotnet restore --no-cache` to bypass the local package cache entirely.

Q: How do I restore packages to a custom location?
A: Use `dotnet restore --packages /path/to/packages` to specify a custom package cache directory. Useful for CI/CD or shared development environments.

Q: How do I handle package conflicts?
A: Use `dotnet list package --include-transitive` to see all packages, add explicit `<PackageReference>` for the desired version, or use `<PackageVersion>` in a Directory.Packages.props file.

## CI/CD and Automation Questions

Q: What's the optimal build sequence for CI/CD?
A: Separate restore and build phases:

```bash
dotnet restore --locked-mode
dotnet build --no-restore --configuration Release
dotnet test --no-build --configuration Release
```

Q: How do I create reproducible builds?
A: Enable deterministic builds with:

```xml
<PropertyGroup>
    <Deterministic>true</Deterministic>
    <ContinuousIntegrationBuild>true</ContinuousIntegrationBuild>
</PropertyGroup>
```

Q: How do I handle version numbers in CI/CD?
A: Use MSBuild properties: `dotnet build -p:VersionPrefix=1.2.3 -p:VersionSuffix=beta` or set in environment variables and reference in project files.

Q: How do I get detailed build logs for troubleshooting?
A: Use `dotnet build -v diagnostic` for maximum verbosity, or `dotnet build -bl:build.binlog` to create a binary log file for analysis.

Q: Should I commit packages.lock.json to source control?
A: Yes, commit lock files to ensure all developers and CI/CD use the same package versions. This prevents "works on my machine" dependency issues.

## Troubleshooting Questions

Q: Why is my build failing with "project.assets.json not found"?
A: Run `dotnet restore` first to generate the assets file, or ensure your build command includes implicit restore (most commands do this automatically).

Q: How do I fix "Assembly could not be found" errors?
A: Check project references with `dotnet list reference`, ensure packages are restored with `dotnet restore`, and verify target framework compatibility.

Q: Why do I get different build results on different machines?
A: Ensure consistent SDK versions (use global.json), use locked mode for packages (`--locked-mode`), enable deterministic builds, and check for environment-specific configurations.

Q: How do I debug MSBuild issues?
A: Use diagnostic verbosity (`-v diagnostic`), create binary logs (`-bl`), disable node reuse (`--disable-build-servers`), and analyze with MSBuild Structured Log Viewer.

Q: Why is my incremental build not working correctly?
A: Try `dotnet clean && dotnet build` to reset, check for custom MSBuild targets that might not declare dependencies correctly, or use `--no-incremental` to force full builds.

## Advanced Build Configuration Questions

Q: How do I integrate code analysis into builds?
A: Enable analyzers in your project:

```xml
<PropertyGroup>
    <EnableNETAnalyzers>true</EnableNETAnalyzers>
    <TreatWarningsAsErrors>true</TreatWarningsAsErrors>
</PropertyGroup>
```

Q: How do I generate documentation files during build?
A: Enable XML documentation:

```xml
<PropertyGroup>
    <GenerateDocumentationFile>true</GenerateDocumentationFile>
</PropertyGroup>
```

Q: How do I customize build output paths?
A: Use MSBuild properties:

```xml
<PropertyGroup>
    <OutputPath>custom\bin\path</OutputPath>
    <BaseOutputPath>custom\output</BaseOutputPath>
</PropertyGroup>
```

Q: How do I conditionally include files based on build configuration?
A: Use MSBuild conditions:

```xml
<ItemGroup Condition="'$(Configuration)' == 'Debug'">
    <Content Include="DebugConfig.json" />
</ItemGroup>
```

Q: How do I pass custom parameters to MSBuild?
A: Use the `-p:` syntax for properties: `dotnet build -p:CustomParam=value`, or define properties in Directory.Build.props for project-wide settings.

## Integration and Workflow Questions

Q: How does dotnet build integrate with testing?
A: Build first, then test without rebuilding: `dotnet build && dotnet test --no-build`. This ensures tests run against the exact build artifacts.

Q: How do I build different projects with different configurations?
A: Build each project separately: `dotnet build ProjectA -c Debug` and `dotnet build ProjectB -c Release`, or use solution filters for complex scenarios.

Q: How do I integrate builds with package creation?
A: Use the build output for packing: `dotnet build -c Release && dotnet pack --no-build -c Release` to ensure package contents match build artifacts.

Q: How do I optimize builds for Docker containers?
A: Use multi-stage builds with layer caching: restore dependencies first (cached), then copy source and build. Use `--no-restore` in the build stage.
