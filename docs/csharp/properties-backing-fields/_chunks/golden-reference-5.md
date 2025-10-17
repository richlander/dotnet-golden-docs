# Properties and Backing Fields
## Access Modifiers

Properties support different access levels for `get` and `set` accessors.

```csharp
public class BankAccount
{
    // Public read, private write
    public decimal Balance { get; private set; }
    
    // Public read, protected write
    public DateTime LastModified { get; protected set; }
    
    // Internal read, private write
    internal string AccountId { get; private set; } = Guid.NewGuid().ToString();
    
    public void Deposit(decimal amount)
    {
        Balance += amount;
        LastModified = DateTime.UtcNow;
    }
}
```

The accessor with the more restrictive modifier must be more restrictive than the property's overall accessibility. You cannot have a `private` property with a `public` accessor.

## Considerations

- **Auto-property backing field:** Cannot access the compiler-generated backing field directly except through the `field` keyword.
- **Init accessor restriction:** More restrictive than `private set`. Can only be called during object initialization or in constructors.
- **Required and nullable:** `required` enforces initialization, not non-null. A `required string?` property must be initialized but can be set to `null`.
- **Field keyword preview:** The `field` keyword is a preview feature in C# 13 and may have syntax changes.
- **Expression-bodied properties:** Cannot have a setter. They're inherently read-only.
- **Accessor access modifiers:** Individual accessor modifiers must be more restrictive than the property's overall accessibility.
- **Partial properties:** Cannot use auto-property syntax for the implementing declaration. Use explicit accessors or the `field` keyword.
