# String Search Operations

## Overview

String search operations in .NET provide a comprehensive set of methods for locating substrings, characters, and patterns within text. These operations range from simple character lookups to complex pattern matching, offering solutions for various performance and functionality requirements.

The .NET string search ecosystem includes:

1. **Basic string methods**: Contains, IndexOf, LastIndexOf, StartsWith, EndsWith
2. **SearchValues**: Pre-optimized search for repeated character/substring searches (.NET 8+)
3. **Regular expressions**: Pattern-based matching for complex scenarios
4. **Span-based operations**: Allocation-free searching for high-performance code

Understanding when to use each approach is critical for writing efficient, maintainable code.
