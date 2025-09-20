# Repository Registry

This document defines the standard repositories referenced across topic specifications. Use the short names (Repo column) when referencing these repositories in topic-spec.md files.

## Official .NET Repositories

| Repo | Home | Rendered URL | Raw URL | Description |
| --- | --- | --- | --- | --- |
| dotnet/docs | https://github.com/dotnet/docs | https://github.com/dotnet/docs/blob/main/README.md | https://raw.githubusercontent.com/dotnet/docs/main/README.md | Official .NET documentation source |
| dotnet/csharplang | https://github.com/dotnet/csharplang | https://github.com/dotnet/csharplang/blob/main/README.md | https://raw.githubusercontent.com/dotnet/csharplang/main/README.md | C# language design and proposals |
| dotnet/roslyn | https://github.com/dotnet/roslyn | https://github.com/dotnet/roslyn/blob/main/README.md | https://raw.githubusercontent.com/dotnet/roslyn/main/README.md | C# and VB.NET compiler implementation |
| dotnet/runtime | https://github.com/dotnet/runtime | https://github.com/dotnet/runtime/blob/main/README.md | https://raw.githubusercontent.com/dotnet/runtime/main/README.md | .NET runtime and base class libraries |
| dotnet/core | https://github.com/dotnet/core | https://github.com/dotnet/core/blob/main/README.md | https://raw.githubusercontent.com/dotnet/core/main/README.md | .NET Core platform and releases |
| dotnet/aspnetcore | https://github.com/dotnet/aspnetcore | https://github.com/dotnet/aspnetcore/blob/main/README.md | https://raw.githubusercontent.com/dotnet/aspnetcore/main/README.md | ASP.NET Core web framework |
| dotnet/samples | https://github.com/dotnet/samples | https://github.com/dotnet/samples/blob/main/README.md | https://raw.githubusercontent.com/dotnet/samples/main/README.md | Official .NET code samples |
| dotnet/sdk | https://github.com/dotnet/sdk | https://github.com/dotnet/sdk/blob/main/README.md | https://raw.githubusercontent.com/dotnet/sdk/main/README.md | .NET SDK and command-line tools |

## Usage

When referencing repository files in topic specifications, use the short repo name and relative path:

### Repo Path Tables
```markdown
| Repo | Path | Description | Last Verified |
| --- | --- | --- | --- |
| dotnet/docs | docs/csharp/whats-new/csharp-12.md | C# 12 feature documentation | - |
| dotnet/csharplang | proposals/collection-expressions.md | Collection expressions proposal | - |
```

### URL Generation
- **Rendered URL**: `{Home}/blob/main/{Path}`
- **Raw URL**: `{Raw URL base}/{Path}` (replace README.md with the actual path)

Example:
- Repo: `dotnet/docs`
- Path: `docs/csharp/whats-new/csharp-12.md`
- Rendered: `https://github.com/dotnet/docs/blob/main/docs/csharp/whats-new/csharp-12.md`
- Raw: `https://raw.githubusercontent.com/dotnet/docs/main/docs/csharp/whats-new/csharp-12.md`

## Last Verified Commits

The repositories below have been verified and all referenced files are assumed to be valid as of the listed commit.

| Repository | Last Verified Commit | Verified Date |
| --- | --- | --- |
| dotnet/core | 24ff2259 | 2025-09-20 |
| dotnet/csharplang | 86c78a07 | 2025-09-20 |
| dotnet/docs | 4a6f5962 | 2025-09-20 |
| dotnet/roslyn | a01d4a05 | 2025-09-20 |
| dotnet/runtime | 80fb00f5 | 2025-09-20 |