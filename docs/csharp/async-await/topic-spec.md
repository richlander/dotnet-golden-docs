# Async and Await - Topic Specification

## Feature Description

The `async` and `await` keywords enable asynchronous programming in C#, allowing developers to write non-blocking code that appears synchronous. This programming model makes it straightforward to handle I/O-bound operations without blocking threads, improving application responsiveness and scalability. The compiler transforms async methods into state machines that enable efficient cooperative multitasking.

## Primary Sources

| Repo | Path | Description | Last Verified |
| --- | --- | --- | --- |
| dotnet/docs | docs/csharp/asynchronous-programming/task-asynchronous-programming-model.md | Task-based async pattern documentation | e4d5897c11 |
| dotnet/docs | docs/csharp/asynchronous-programming/async-return-types.md | Async return types documentation | e4d5897c11 |
| dotnet/docs | docs/csharp/asynchronous-programming/index.md | Async programming overview | e4d5897c11 |

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| https://docs.microsoft.com/dotnet/csharp/async | rendered | Async programming overview | 2025-10-14 |
| https://docs.microsoft.com/dotnet/csharp/language-reference/keywords/async | rendered | Async keyword reference | 2025-10-14 |
| https://docs.microsoft.com/dotnet/csharp/language-reference/operators/await | rendered | Await operator reference | 2025-10-14 |
| https://github.com/dotnet/runtime | rendered | Runtime repository (Task implementation) | 2025-10-14 |

## Secondary Sources

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| https://devblogs.microsoft.com/dotnet/configureawait-faq/ | rendered | ConfigureAwait FAQ and best practices | 2025-10-14 |
| https://devblogs.microsoft.com/dotnet/understanding-the-whys-whats-and-whens-of-valuetask/ | rendered | ValueTask explanation | 2025-10-14 |
| https://docs.microsoft.com/aspnet/core/fundamentals/best-practices#avoid-blocking-calls | rendered | ASP.NET Core async best practices | 2025-10-14 |

## Metadata

| Property | Value |
| --- | --- |
| Name | Async and Await |
| ID | async-await |
| Category | C# Language |
| Namespace | (language feature) |
| Description | Language keywords enabling asynchronous programming with non-blocking I/O operations and improved scalability through the Task-based Asynchronous Pattern. |
| Complexity | 0.40 |
| Audience | All .NET developers |
| Priority | 1 (Fundamental - core language feature) |
| Version | 5.0 (async/await introduced) |
| Year | 2012 |

## Hashes

| Name | Kind | Fingerprint |
|------|------|-------------|
| overview | simhash | 17748041905982472506 |
| technical | simhash | 12992239188741849468 |

## Relationships

| Type | Target |
| --- | --- |
| Enables | Non-blocking I/O, scalable applications, responsive UI, async iteration |
| Conflicts with | None |
| Alternative to | Callback-based async, blocking I/O |
| Prerequisite | Understanding of Task and asynchronous concepts |
| Synergistic with | Task, IAsyncEnumerable, System.Text.Json, Entity Framework Core, ASP.NET Core, HttpClient, File I/O APIs |

## Keywords

| Keyword | Score |
|---------|-------|
| async | 26.00 |
| use | 29.00 |
| async operations | 8.00 |
| await | 11.00 |
| operations | 11.00 |
| task | 7.00 |
| async methods | 4.00 |
| considerations | 8.00 |
| async code | 3.00 |
| avoid | 6.00 |
| code | 8.00 |
| threads | 4.00 |

## APIs

| API | Type | Count |
|-----|------|-------|
| FetchDataAsync | method | 20 |
| Console.WriteLine | method | 18 |
| HttpClient | method | 14 |
| Task.Delay | method | 11 |
| ConfigureAwait | method | 10 |
| GetDataAsync | method | 10 |
| GetStringAsync | method | 10 |
| Task.Run | method | 9 |
| CalculateAsync | method | 8 |
| LoadDataAsync | method | 8 |
| ProcessDataAsync | method | 8 |
| SaveDataAsync | method | 8 |

## Diagnostic Codes

(No specific diagnostic codes for these keywords)

## Similarity Scores

| Category | Neighbor | Similarity |
|----------|----------|------------|
| libraries | libraries/system-threading-tasks-task | 0.8707 |
| libraries | libraries/system-collections-generic-iasyncenumerable | 0.8273 |
| csharp | csharp | 0.7305 |
| libraries | libraries/system-collections-generic-ienumerable | 0.7291 |
| csharp | csharp/lambda-expressions | 0.7270 |
| libraries | libraries/json-streaming-io | 0.7119 |
| libraries | libraries/collections-performance | 0.7065 |
| csharp | csharp/csharp-14-features | 0.7049 |
| dotnet | dotnet | 0.7034 |
| libraries | libraries/system-text-json | 0.6964 |
| libraries | libraries/dotnet-10-library-improvements | 0.6850 |
| libraries | libraries/system-text-json-jsonserializer | 0.6825 |

## Authority Scores

(Authority scores will be computed based on keyword analysis)

## Chunks

**Source**: `golden-reference.md`
**Count**: 12
**Baseline (Conceptual)**: 0
**Baseline (Technical)**: 1

| Index | Title | Conceptual Similarity | Technical Similarity |
|-------|-------|----------------------|---------------------|
| 0 | Main Approaches | 1.000 | 0.695 |
| 1 | Concurrent Async Operations | 0.695 | 1.000 |
| 2 | Task and Task&lt;T&gt; | 0.669 | 0.659 |
| 3 | ASP.NET Core Integration | 0.610 | 0.605 |
| 4 | Web API Request with Error Handling | 0.668 | 0.669 |
| 5 | Async Initialization Pattern | 0.634 | 0.661 |
| 6 | Async Lock Pattern | 0.620 | 0.645 |
| 7 | Task.FromResult for Sync Returns | 0.642 | 0.690 |
| 8 | Use ConfigureAwait(false) in Libraries | 0.634 | 0.641 |
| 9 | Async Methods Have Overhead | 0.661 | 0.671 |
| 10 | Can't Use Await in Lock Statements | 0.621 | 0.610 |
| 11 | Exceptions in Task.WhenAll | 0.648 | 0.655 |
