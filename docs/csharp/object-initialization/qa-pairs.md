# Object Initialization - Q&A Pairs

## Q: How do I create an object and set its properties in one expression?
A: Use object initializer syntax: `Person person = new Person { Name = "John", Age = 30 };` or with target-typed new: `Person person = new() { Name = "John", Age = 30 };`

## Q: Can I use both a constructor and object initializer together?
A: Yes: `Person person = new Person("John") { Age = 30, City = "Seattle" };` calls the constructor first, then sets the properties.

## Q: What's the difference between set and init properties?
A: `set` properties can be modified after object creation, `init` properties can only be set during initialization: `public string Name { get; init; }` is immutable after construction.

## Q: How do I initialize collections within an object initializer?
A: Use nested collection syntax: `Team team = new() { Name = "Dev Team", Members = new() { "Alice", "Bob" } };`

## Q: What are required members in C# 11?
A: Properties marked with `required` must be initialized: `public required string Name { get; init; }` forces initialization during object creation.

## Q: How do I create anonymous types in C#?
A: Use `new { }` syntax: `var person = new { Name = "John", Age = 30 };` - properties are read-only and inferred from values.

## Q: Can I nest object initializers?
A: Yes: `Person person = new() { Name = "John", Address = new() { Street = "123 Main St", City = "Seattle" } };`

## Q: How do I initialize a Dictionary property within an object?
A: Use dictionary initializer syntax: `Config config = new() { Settings = new() { ["key1"] = "value1", ["key2"] = "value2" } };`

## Q: What happens if I don't initialize a required member?
A: The compiler generates error CS9035: "Required member must be set in the object initializer or attribute constructor."

## Q: Can I use object initializers with records?
A: Yes: `PersonRecord person = new("John", 30) { Skills = new() { "C#", "JavaScript" } };` - constructor parameters and init properties work together.

## Q: How do I make an object immutable after initialization?
A: Use `init` properties instead of `set`: `public string Name { get; init; }` prevents modification after construction.

## Q: Can I initialize private properties using object initializers?
A: No, only public properties and fields can be initialized. Use constructor parameters for private member initialization.

## Q: What's the performance difference between constructor and object initializer?
A: Object initializers call the constructor first, then property setters. Multiple property assignments may be less efficient than a single constructor call.

## Q: How do I handle validation in object initializers?
A: Put validation in property setters or init accessors: `init => _name = ValidateName(value) ?? throw new ArgumentException("Invalid name");`

## Q: Can I use computed values in object initializers?
A: Yes: `Person person = new() { Name = firstName + " " + lastName, Age = DateTime.Now.Year - birthYear };`

## Q: How do I initialize read-only collections within objects?
A: Initialize with `init`: `public List<string> Items { get; init; } = new();` allows initialization but prevents reassignment.

## Q: What's the difference between object initializers and collection initializers?
A: Object initializers set properties `{ Property = Value }`, collection initializers add items to collections `{ item1, item2, item3 }`.

## Q: Can I use object initializers with inheritance?
A: Yes, you can initialize properties from both base and derived classes: `Derived obj = new() { BaseProperty = "value", DerivedProperty = 42 };`

## Q: How do I initialize nullable properties?
A: Set them explicitly or leave them null: `Person person = new() { Name = "John", MiddleName = null };` - uninitialized nullable properties default to null.

## Q: Can I use conditional logic in object initializers?
A: Use conditional expressions: `Person person = new() { Name = "John", Status = age >= 18 ? "Adult" : "Minor" };`