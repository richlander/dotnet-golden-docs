# Assembly Trimming

## Overview

Assembly trimming is a build-time optimization that reduces the size of self-contained .NET applications by removing unused code from the application and its dependencies. The trimmer uses static analysis to identify code that is never reached during execution and eliminates it from the final deployment.

Key benefits include:

- Significant size reduction: 20-70% smaller deployments depending on application complexity
- Faster deployment: Reduced download and transfer times
- Lower storage costs: Particularly important for cloud and container scenarios
- Improved cold start: Less code to load and JIT compile (when combined with ReadyToRun)

The technology works by:

1. Static analysis: Analyzing code paths from application entry points
2. Dependency tracking: Following method calls, field accesses, and type references
3. Dead code elimination: Removing unreachable code and unused assemblies
4. Metadata reduction: Stripping unused reflection metadata

Trimming is particularly valuable for:

- Cloud applications: Reduced container image sizes and deployment times
- Desktop applications: Smaller installers and faster startup
- IoT applications: Reduced storage requirements on constrained devices
- Serverless functions: Faster cold starts and reduced memory footprint
