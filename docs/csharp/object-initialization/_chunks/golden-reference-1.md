# Object Initialization
## Basic Object Initializer Syntax

### Simple Property Initialization

Object initializers set properties after the constructor runs:

```csharp
public class Person
{
    public string Name { get; set; }
    public int Age { get; set; }
    public string Email { get; set; }
}

// Object initializer syntax
Person person = new Person
{
    Name = "Alice Johnson",
    Age = 28,
    Email = "alice@example.com"
};

// Target-typed new
Person modernPerson = new()
{
    Name = "Bob Smith",
    Age = 35,
    Email = "bob@example.com"
};
```

### Combining Constructors and Initializers

Constructors handle required parameters, initializers handle optional configuration:

```csharp
public class Person
{
    public Person(string name)
    {
        Name = name;
    }

    public string Name { get; }
    public int Age { get; set; }
    public string City { get; set; }
}

// Constructor provides required name, initializer sets optional properties
Person person = new Person("Charlie")
{
    Age = 42,
    City = "Seattle"
};
```

### Nested Object Initialization

Objects can initialize their nested object properties:

```csharp
public class Address
{
    public string Street { get; set; }
    public string City { get; set; }
    public string ZipCode { get; set; }
}

public class Person
{
    public string Name { get; set; }
    public Address HomeAddress { get; set; }
    public Address WorkAddress { get; set; }
}

// Nested initialization
Person person = new Person
{
    Name = "David Wilson",
    HomeAddress = new Address
    {
        Street = "123 Main St",
        City = "Portland",
        ZipCode = "97201"
    },
    WorkAddress = new()
    {
        Street = "456 Corporate Blvd",
        City = "Portland",
        ZipCode = "97205"
    }
};
```
