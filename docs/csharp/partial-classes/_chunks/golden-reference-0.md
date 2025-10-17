# Partial Classes

## Overview

Partial classes split the definition of a type (class, struct, or interface) across multiple source files. Each file contains a section of the type definition, and all parts combine at compile time to form the complete type.

This separation is valuable when working with code generators, which can generate part of a class while developers write the rest in separate files without modifying generated code. Partial classes also enable platform-specific implementations where different source files contain Linux, macOS, or Windows-specific members of the same type. Source generators use partial classes and partial members to add generated functionality to developer-written types.

All partial declarations use the `partial` keyword modifier and must be in the same assembly and namespace. Partial types can contain partial members, where the member signature is declared in one file and the implementation in another.
