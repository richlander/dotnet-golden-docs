# C# Language
## Essential Language Features

### Syntax and Familiarity

C# is in the C family of languages. C# syntax is familiar if you used C, C++, JavaScript, TypeScript, or Java. Like C and C++, semi-colons (`;`) define the end of statements. C# identifiers are case-sensitive. C# has the same use of braces, `{` and `}`, control statements like `if`, `else` and `switch`, and looping constructs like `for`, and `while`. C# also has a `foreach` statement for any collection type.

### Type System and Object Orientation

C# is a strongly typed language. Every variable you declare has a type known at compile time. The compiler, or editing tools tell you if you're using that type incorrectly. You must fix those errors before you run your program.

Fundamental Types: C# has built-in value types like `int`, `double`, `char`, `bool` and built-in reference types like `string`, `object`, `delegate`, and arrays. The array syntax enables multiple modeling scenarios: single-dimension (`int[]`), multi-dimensional (`int[,]`), and jagged (`int[][]`). `Span<T>` offers zero-cost contiguous windows over arrays. Most other collections come from the .NET class library, though `IEnumerable` and `IEnumerable<T>` have special language support through the `foreach` statement and enumerable pattern recognition. Collection expressions enable terse creation of array, `Span<T>`, and `IEnumerable<T>` typed data. As you write your programs, you can create your own types using `struct` types for values, or `class` types that define object-oriented behavior.

Generics: Generic types and methods use type parameters to provide a placeholder for an actual type when used. This enables type-safe collections and algorithms that work with multiple types.

Object-Oriented Features: C# supports inheritance, polymorphism, encapsulation, and abstraction. You can define `interface` definitions, which define a contract that implementing types must provide. You can add the `record` modifier to either `struct` or `class` types so the compiler synthesizes code for equality comparisons.
