# System.Buffers.SearchValues

## Overview

SearchValues<T> is a performance-focused type introduced in .NET 8 that provides optimized searching for specific sets of values within spans. It creates an immutable, pre-computed data structure that accelerates repeated searches for the same set of values, making it ideal for high-performance scenarios where the same search criteria are used multiple times.

Key advantages include:

- Pre-computed optimization: Analysis happens once at creation time
- SIMD acceleration: Leverages hardware vector instructions when possible
- Multiple value types: Supports byte, char, and string (substring) searches
- Zero allocation: Designed for allocation-free search operations
- Consistent performance: Predictable search behavior across platforms

SearchValues is particularly valuable when:

1. The same set of values is searched repeatedly
2. Performance is critical and allocation should be minimized
3. You need to search for multiple values simultaneously
4. Working with spans and high-performance string/buffer operations
