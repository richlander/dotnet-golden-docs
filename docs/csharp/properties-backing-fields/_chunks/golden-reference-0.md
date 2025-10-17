# Properties and Backing Fields

## Overview

Properties provide a flexible mechanism to read, write, or compute values while appearing as public data members. They use special methods called accessors (`get` and `set`) that enable validation, computation, and controlled access to data. Properties eliminate the need for explicit getter and setter methods while maintaining encapsulation.

The compiler can generate backing fields automatically for properties, which can be accessed with a compiler-synthesized backing field using the `field` keyword, which custom logic is needed. Properties support various access patterns including read-only, write-only, init-only, and required initialization.
