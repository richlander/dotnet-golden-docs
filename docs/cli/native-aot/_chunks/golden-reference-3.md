# Publish file-based app (new in .NET 10)
## Relationships & Integration
### System.Text.Json Source Generation
#### Enabling Source Generation for Generic Methods with JsonTypeInfo

For generic methods that work with any type in AOT scenarios, use `JsonTypeInfo<T>`:

```csharp
// AOT-compatible generic deserialization
public static T DeserializeFromApi<T>(string json, JsonTypeInfo<T> typeInfo) where T : class
{
    return JsonSerializer.Deserialize(json, typeInfo)!;
}

// Usage with different types
var person = DeserializeFromApi(personJson, PersonContext.Default.Person);
var product = DeserializeFromApi(productJson, ProductContext.Default.Product);
```

When using System.Text.Json with Native AOT, it is important that source generation is configured for every type that will be serialized. This need is most critical a method (not a class) that defines its own `T`. That means that a matching `JsonTypeInfo<T>` needs to provided so that serialization will be successful. The most convenient way to do that if in the same `T` method, as you can see in the prior example. This approach will ensure that the correct types are included with the JSON source generation process. If a matching `JsonTypeInfo<T>` is not available, then there will ba runtime exception. The reflection-based runtime serializer is not available. The `class` generic constraint is a useful performance optimization. The code that Native AOT needs to compile will be much simpler and smaller if is constrained to classes.

#### Common AOT Errors

When using reflection-based JSON serialization in Native AOT projects, you'll encounter:

```
warning IL2026: Using member 'JsonSerializer.Serialize<TValue>' which has
'RequiresUnreferencedCodeAttribute' can break functionality when trimming.
Use the overload that takes a JsonTypeInfo or JsonSerializerContext.

warning IL3050: Using member 'JsonSerializer.Serialize<TValue>' which has
'RequiresDynamicCodeAttribute' can break functionality when AOT compiling.
Use System.Text.Json source generation for native AOT applications.
```

These warnings indicate runtime failures in AOT scenarios. Always use source generation overloads.
