# Object Initialization

## Overview

Object initialization solves the problem of creating an object and setting its properties in a single expression. Rather than creating an object and then setting properties in separate statements, you can declare the object and configure it all at once.

Object initialization encompasses several patterns: object initializer syntax for setting properties, collection initialization for collection properties, constructor parameters for required values, and special features like init-only properties and required members for ensuring object validity.

```csharp
// Constructor with parameters for required values
Person person1 = new Person("John", 30);

// Object initializer for property configuration
Person person2 = new Person { Name = "John", Age = 30 };

// Target-typed syntax eliminates redundancy
Person person3 = new() { Name = "John", Age = 30 };
```
