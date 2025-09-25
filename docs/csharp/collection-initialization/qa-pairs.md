# Collection Initialization - Q&A Pairs

## Q: How do I create an empty List<string> in C#?
A: Use the constructor: `List<string> names = new List<string>();` or with target-typed new: `List<string> names = new();`

## Q: What's the difference between new List<int>() and new List<int>(100)?
A: The first creates an empty list with default capacity, while the second pre-allocates space for 100 items, improving performance when you know the approximate size.

## Q: How do I initialize a List with values in C#?
A: Use collection initializer syntax: `List<string> fruits = new List<string> { "apple", "banana", "orange" };` or `List<string> fruits = new() { "apple", "banana", "orange" };`

## Q: Can I use target-typed new with collection initializers?
A: Yes: `List<int> numbers = new() { 1, 2, 3, 4, 5 };` combines both features for cleaner syntax.

## Q: How do I initialize a Dictionary with values?
A: Use key-value pair syntax: `Dictionary<string, int> ages = new() { {"Alice", 30}, {"Bob", 25} };` or index initializer: `Dictionary<string, int> ages = new() { ["Alice"] = 30, ["Bob"] = 25 };`

## Q: What's the best way to initialize a large collection for performance?
A: Pre-size the collection if you know the approximate count: `List<int> numbers = new List<int>(10000);` to avoid internal resizing operations.

## Q: How do I create an array with specific values?
A: Use array initializer: `int[] numbers = new int[] { 1, 2, 3 };` or simplified syntax: `int[] numbers = { 1, 2, 3 };`

## Q: Can I initialize a HashSet with duplicate values?
A: Yes, but duplicates will be automatically removed: `HashSet<int> numbers = new() { 1, 2, 2, 3 };` results in {1, 2, 3}.

## Q: How do I initialize nested collections like List<List<int>>?
A: Use nested initializer syntax: `List<List<int>> matrix = new() { new() { 1, 2 }, new() { 3, 4 } };`

## Q: What happens if I don't initialize a string array?
A: Array elements default to null: `string[] names = new string[3];` creates [null, null, null], which can cause NullReferenceException if accessed without checking.

## Q: How do I initialize a collection from another collection?
A: Pass the source collection to the constructor: `List<int> copy = new List<int>(originalList);`

## Q: Can I use var with collection initialization?
A: Only with explicit type information: `var numbers = new List<int> { 1, 2, 3 };` works, but `var numbers = { 1, 2, 3 };` doesn't compile.

## Q: How do I initialize a Queue or Stack with values?
A: Pass an array or collection to the constructor: `Queue<string> queue = new Queue<string>(new[] { "first", "second" });`

## Q: What's the difference between List<T> and Array initialization?
A: Lists are dynamic and can grow: `List<int> list = new() { 1, 2, 3 };` Arrays have fixed size: `int[] array = { 1, 2, 3 };`

## Q: How do I conditionally add items during initialization?
A: Use separate initialization and conditional addition, or create helper methods that return the appropriate collection based on conditions.

## Q: Can I initialize readonly collections?
A: Use ImmutableList or similar: `ImmutableList<int> numbers = ImmutableList.Create(1, 2, 3);` or initialize a regular collection and convert it.

## Q: How do I initialize a Dictionary with complex value types?
A: Use object initializer for values: `Dictionary<string, Person> people = new() { ["John"] = new Person { Age = 30 } };`

## Q: What's the most memory-efficient way to initialize large collections?
A: Pre-size collections when possible and consider using arrays for fixed-size data: `int[] numbers = new int[1000];` or `List<int> numbers = new(1000);`

## Q: Can I use collection initialization with interfaces?
A: Yes, as long as the concrete type supports it: `IList<int> numbers = new List<int> { 1, 2, 3 };`

## Q: How do I initialize an empty array vs. null array?
A: Empty array: `int[] empty = new int[0];` or `int[] empty = { };`. Null array: `int[] nullArray = null;` (requires null check before use).