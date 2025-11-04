# 🔷 C#/.NET Development Guide

Complete guide for C# and .NET development.

---

## Setup

### Language Server
**omnisharp** (via Mason)

### Debugger
**netcoredbg** (via Mason)

### .NET Installation
```bash
# Debian/Ubuntu
wget https://dot.net/v1/dotnet-install.sh
chmod +x dotnet-install.sh
./dotnet-install.sh --channel 8.0

# Arch
sudo pacman -S dotnet-sdk
```

---

## Features

- IntelliSense completion
- Go to definition
- Find references
- Refactoring tools
- NuGet package support

---

## Project Setup

### Console App
```bash
dotnet new console -n MyApp
cd MyApp
nvim Program.cs
```

### Web API
```bash
dotnet new webapi -n MyApi
cd MyApi
nvim Controllers/
```

---

## Debugging

**Program.cs**:
```csharp
using System;

class Program
{
    static int Add(int a, int b)
    {
        int sum = a + b;  // Breakpoint (F9)
        return sum;
    }

    static void Main()
    {
        int result = Add(5, 3);
        Console.WriteLine($"Result: {result}");
    }
}
```

Steps:
1. Build: `dotnet build`
2. Open: `nvim Program.cs`
3. Breakpoint: `F9`
4. Debug: `F5`
5. Enter DLL path: `bin/Debug/net8.0/MyApp.dll`

---

## Commands

```vim
:!dotnet build     " Build project
:!dotnet run       " Run project
:!dotnet test      " Run tests
```

---

## Resources

- [.NET Documentation](https://learn.microsoft.com/en-us/dotnet/)
- [OmniSharp](https://www.omnisharp.net/)
