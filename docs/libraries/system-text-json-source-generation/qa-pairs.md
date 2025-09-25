# System.Text.Json Source Generation - Q&A Pairs

## Q: Why should I use source generation instead of reflection-based JSON serialization?
A: Source generation is required for Native AOT compatibility, provides better performance by eliminating runtime reflection, and enables compile-time type safety. It's essential when targeting AOT deployment scenarios.

## Q: Do I need JsonPropertyName attributes if I'm using JsonSourceGenerationOptions with a naming policy?
A: No, JsonPropertyName attributes are redundant when JsonSourceGenerationOptions already defines a naming policy like PropertyNamingPolicy = JsonKnownNamingPolicy.SnakeCaseLower. The policy automatically converts property names.

## Q: How do I handle generic methods with unconstrained T in AOT scenarios?
A: Pass JsonTypeInfo<T> as a parameter: `public static T Deserialize<T>(string json, JsonTypeInfo<T> typeInfo) => JsonSerializer.Deserialize<T>(json, typeInfo)!;`

## Q: What is a JsonSerializerContext and how do I create one?
A: A JsonSerializerContext is a partial class that inherits from JsonSerializerContext and uses [JsonSerializable] attributes to register types: `[JsonSerializable(typeof(Person))] public partial class PersonContext : JsonSerializerContext { }`

## Q: Can I use multiple naming policies in the same context?
A: No, JsonSourceGenerationOptions applies one naming policy per context. Create separate contexts for different naming policies or use JsonPropertyName for specific property overrides.

## Q: How do I serialize collections with source generation?
A: Register collection types explicitly: `[JsonSerializable(typeof(List<Person>))]` and use the generated property: `JsonSerializer.Serialize(people, PersonContext.Default.ListPerson);`

## Q: What's the difference between GenerationMode.Serialization and GenerationMode.Metadata?
A: Serialization mode generates code for writing JSON, Metadata mode generates code for reading JSON. Use both with `GenerationMode.Serialization | GenerationMode.Metadata` for bidirectional operations.

## Q: How do I combine multiple JsonSerializerContext instances?
A: Use JsonTypeInfoResolver.Combine(): `var resolver = JsonTypeInfoResolver.Combine(PersonContext.Default, ProductContext.Default);` then assign to JsonSerializerOptions.TypeInfoResolver.

## Q: Can I use custom JsonNamingPolicy with source generation?
A: Custom naming policies may not work in all AOT scenarios. Prefer built-in policies like JsonKnownNamingPolicy.CamelCase or JsonKnownNamingPolicy.SnakeCaseLower.

## Q: How do I handle nested objects in source generation?
A: Register all nested types with [JsonSerializable]: `[JsonSerializable(typeof(Person))] [JsonSerializable(typeof(Address))]` if Person contains Address properties.

## Q: What does the IL2026 warning mean and how do I fix it?
A: IL2026 indicates usage of reflection-based serialization that's incompatible with trimming/AOT. Fix by using JsonTypeInfo overloads: `JsonSerializer.Serialize(obj, typeInfo)` instead of `JsonSerializer.Serialize<T>(obj)`.

## Q: Can I use source generation with interfaces or abstract classes?
A: Source generation has limited support for polymorphism. Register concrete types explicitly and consider using union types or discriminated unions patterns instead.

## Q: How do I configure JsonSerializerOptions when using source generation?
A: Create options with TypeInfoResolver: `var options = new JsonSerializerOptions { TypeInfoResolver = PersonContext.Default, WriteIndented = true };`

## Q: Can I use init-only properties with source generation?
A: Yes, but with limitations. Some versions may have restrictions (SYSLIB1037). Test thoroughly and consider using regular properties with private setters if issues arise.

## Q: How do I handle DateTime serialization with source generation?
A: Configure DateTimeConverter in JsonSourceGenerationOptions or register DateTime explicitly: `[JsonSerializable(typeof(DateTime))]` and let the context handle formatting.

## Q: What happens if I forget to register a type in the JsonSerializerContext?
A: You'll get runtime errors like "JsonTypeInfo not found" or fall back to reflection-based serialization (breaking AOT compatibility). Always register all types you need to serialize.

## Q: Can I use source generation with ASP.NET Core?
A: Yes, configure it in Program.cs: `builder.Services.Configure<JsonOptions>(options => options.SerializerOptions.TypeInfoResolver = PersonContext.Default);`

## Q: How do I debug source generation issues?
A: Enable source generator logging in your project file, check generated code in obj folder, and ensure all required types are registered with [JsonSerializable] attributes.

## Q: Can I use JsonIgnore with source generation?
A: Yes, JsonIgnore and JsonIgnoreCondition work with source generation. Configure default behavior with JsonSourceGenerationOptions.DefaultIgnoreCondition.

## Q: How do I handle Dictionary<string, object> with source generation?
A: Register explicitly: `[JsonSerializable(typeof(Dictionary<string, object>))]` or use JsonElement for dynamic content: `[JsonSerializable(typeof(Dictionary<string, JsonElement>))]`