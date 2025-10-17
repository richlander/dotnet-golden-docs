# Native AOT

## Overview

Native AOT (Ahead-of-Time) compilation transforms .NET applications into native executables that run without requiring the .NET runtime on the target machine. This publishing model compiles IL code to native machine code at build time, rather than relying on just-in-time (JIT) compilation at runtime.

Key benefits include:

- Faster startup: 2-5x faster application startup compared to JIT compilation
- Reduced memory footprint: 20-50% lower memory usage at runtime
- Self-contained deployment: No .NET runtime installation required
- Smaller deployment size: Often smaller than self-contained deployments with full runtime
- Restricted environment compatibility: Runs in environments where JIT compilation is prohibited

The technology is particularly valuable for:

- Cloud and serverless: Fast cold start times for containers and functions
- Desktop applications: Improved user experience with instant startup
- IoT and edge computing: Reduced resource requirements for constrained devices
- Gaming and real-time systems: Predictable performance without JIT overhead
