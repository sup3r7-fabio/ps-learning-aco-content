# PowerShell Fundamentals (PS-Basics)

## Learning Objectives

By completing this module, you will:
- ✅ Understand what PowerShell is and how it differs from other shells
- ✅ Execute basic PowerShell commands and navigate the filesystem
- ✅ Understand and work with cmdlets and parameters
- ✅ Manage processes, files, and system information
- ✅ Create and run your first PowerShell scripts

---

## Table of Contents

1. [What is PowerShell?](#what-is-powershell)
2. [Installation and Setup](#installation-and-setup)
3. [Basic Commands](#basic-commands)
4. [Cmdlets and Parameters](#cmdlets-and-parameters)
5. [Working with Objects](#working-with-objects)
6. [File System Navigation](#file-system-navigation)
7. [Key Takeaways](#key-takeaways)

---

## What is PowerShell?

PowerShell is a **task-based automation engine and configuration management framework**. It's fundamentally different from traditional shells like Bash because it's built on the .NET Framework and works with **objects** rather than text.

### PowerShell vs Other Shells

| Feature | PowerShell | Bash | CMD |
|---------|-----------|------|-----|
| Object-based | ✅ Yes | ❌ Text-based | ❌ Text-based |
| Platform | Windows, Linux, macOS | Linux, macOS | Windows only |
| Task automation | ✅ Full-featured | ✅ Capable | ⚠️ Limited |
| .NET Integration | ✅ Native | ❌ No | ❌ No |
| Learning curve | Moderate | Moderate | Easier but limited |

### Why Learn PowerShell?

- 🔧 Automate Windows/Azure administration
- 🌍 Cross-platform (Core 7.0+)
- 📦 Works with objects, not just text
- 🔌 Direct integration with .NET
- 🏢 Enterprise adoption widely used

---

## Installation and Setup

### PowerShell Core 7.0+

**Requirements:**
- Windows 10+, Ubuntu 16.04+, CentOS 7+, or macOS 10.14+
- 64-bit processor
- Internet connection (for installation)

### Install on Different Platforms

**Windows:**
```powershell
# Using Windows Package Manager
winget install Microsoft.PowerShell

# Or download from https://github.com/PowerShell/PowerShell/releases
```

**Linux (Ubuntu/Debian):**
```bash
# Add Microsoft repository
wget -q https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb

# Install PowerShell
sudo apt-get update
sudo apt-get install -y powershell
```

**macOS:**
```bash
# Using Homebrew
brew install powershell

# Or download from GitHub
```

### Verify Installation

```powershell
# Check PowerShell version
$PSVersionTable.PSVersion

# Should output: 7.0.0 or higher
```

### Your First PowerShell Command

```powershell
# Open PowerShell and type:
Write-Host "Hello, PowerShell!"

# Output:
# Hello, PowerShell!
```

---

## Basic Commands

### Navigation Commands

```powershell
# Print working directory (where you are)
Get-Location
pwd      # Alias

# List files and folders
Get-ChildItem
ls       # Unix-style alias
dir      # Windows-style alias

# Change directory
Set-Location -Path "C:\Users\YourName\Documents"
cd C:\Users\YourName\Documents

# Go to home directory
cd ~

# Go up one level
cd ..
```

### File Operations

```powershell
# Create a new file
New-Item -Path ".\hello.txt" -ItemType "file"
New-Item -Path ".\myfolder" -ItemType "directory"

# Copy files
Copy-Item -Path ".\file.txt" -Destination ".\backup\file.txt"

# Move files
Move-Item -Path ".\file.txt" -Destination ".\archive\file.txt"

# Delete files (be careful!)
Remove-Item -Path ".\oldfile.txt"

# View file contents
Get-Content -Path ".\hello.txt"
cat .\hello.txt    # Alias
```

### System Information

```powershell
# Get current user
[System.Security.Principal.WindowsIdentity]::GetCurrent().Name
whoami   # Cross-platform

# Get computer name
$env:COMPUTERNAME
hostname

# Get system information
Get-ComputerInfo | Select-Object CsSystemType, OsName, OsVersion

# Check disk space
Get-Volume
```

---

## Cmdlets and Parameters

### Cmdlet Structure

PowerShell commands are called **cmdlets** (pronounced "command-lets"). They follow a **Verb-Noun** naming convention:

```
Write-Host           Get-Process          Stop-Service
 │      │             │        │            │       │
Verb   Noun          Verb    Noun          Verb   Noun
```

### Common Verbs

| Verb | Purpose | Example |
|------|---------|---------|
| Get | Retrieve information | `Get-Process` |
| Set | Modify configuration | `Set-Location` |
| New | Create something | `New-Item` |
| Remove | Delete something | `Remove-Item` |
| Start | Begin a process | `Start-Service` |
| Stop | End a process | `Stop-Service` |
| Add | Add something | `Add-Member` |
| Select | Choose/filter | `Select-Object` |

### Working with Parameters

```powershell
# Basic parameter usage
Get-Process -Name "notepad"

# Multiple parameters
Copy-Item -Path ".\file.txt" -Destination ".\backup\" -Force

# Boolean parameters (switch)
Get-ChildItem -Path ".\Documents" -Recurse -Force

# Parameter with multiple values
Get-Service -Name "WinRM", "WinDefend", "Spooler"
```

### Getting Help

```powershell
# Get help for a cmdlet
Get-Help Get-Process

# Get detailed help
Get-Help Get-Process -Detailed

# Get examples
Get-Help Get-Process -Examples

# Get full help
Get-Help Get-Process -Full

# Search for cmdlets
Get-Command -Verb "Get" -Noun "Service*"

# Find cmdlets matching a description
Get-Command -Name "*process*"
```

---

## Working with Objects

**This is what makes PowerShell special!**

Everything in PowerShell is an **object** with **properties** and **methods**.

### Objects vs Text

```powershell
# Traditional shell (text output)
# OUTPUT: "cmd.exe      1234   Session0    0      12.5 MB"

# PowerShell (object output)
Get-Process | Select-Object Name, Id, SessionId, Handles, WorkingSet

# Each row is an object with properties you can work with!
```

### Viewing Object Properties

```powershell
# Get all properties of an object
Get-Process -Name "powershell" | Select-Object *

# Get specific properties
Get-Process -Name "powershell" | Select-Object Name, Id, CPU, Memory

# Format as table
Get-Process | Select-Object Name, Id, CPU | Format-Table

# Format as list
Get-Process -Name "powershell" | Format-List *
```

### Working with Object Methods

```powershell
# Get methods available on an object
Get-Process | Get-Member -MemberType Method

# Call a method
$process = Get-Process -Name "notepad"
$process.Kill()    # Terminates the process

# Get property values
$process.Name
$process.Id
$process.WorkingSet
```

### Example: Get Process Information

```powershell
# Get all running processes
Get-Process

# Get specific process
Get-Process -Name "explorer"

# Get process using CPU and memory
Get-Process | Sort-Object -Property CPU -Descending | Select-Object -First 5

# Get total memory used
(Get-Process | Measure-Object -Property WorkingSet -Sum).Sum / 1MB
```

---

## File System Navigation

### Directory Structure Basics

```
C:\                           # Root of C: drive
├── Windows\                  # System files
├── Program Files\            # Applications
├── Users\
│   └── YourName\
│       ├── Desktop\
│       ├── Documents\
│       ├── Downloads\
│       └── Pictures\
└── temp\
```

### Common Operations

```powershell
# Navigate to Documents
Set-Location -Path "$HOME\Documents"

# Create project folder structure
New-Item -Path ".\MyProject" -ItemType Directory
New-Item -Path ".\MyProject\src" -ItemType Directory
New-Item -Path ".\MyProject\data" -ItemType Directory

# Create multiple files
"This is a test" | Out-File -FilePath ".\file1.txt"
"Line 1`nLine 2`nLine 3" | Out-File -FilePath ".\file2.txt"

# List with details
Get-ChildItem -Path "." -Recurse | Format-Table Name, Length, LastWriteTime

# Find files of specific type
Get-ChildItem -Path ".\Documents" -Filter "*.pdf" -Recurse

# Get total size of folder
(Get-ChildItem -Path ".\Documents" -Recurse | Measure-Object -Property Length -Sum).Sum / 1MB
```

### Path Handling

```powershell
# Combine paths (cross-platform safe)
$path = Join-Path -Path $HOME -ChildPath "Documents\Projects"

# Get parent directory
Split-Path -Path "C:\Users\YourName\Documents\file.txt"

# Get filename only
Split-Path -Path "C:\Users\YourName\Documents\file.txt" -Leaf

# Test if path exists
Test-Path -Path "C:\Users\YourName\Documents"

# Get full/absolute path
Convert-Path -Path ".\relative\path"
```

---

## Key Takeaways

1. **PowerShell is object-based**, not text-based - this enables powerful automation
2. **Cmdlets follow Verb-Noun naming** - makes commands predictable and easy to learn
3. **Parameters modify command behavior** - most accept multiple values
4. **Get-Help is your friend** - it's built-in, comprehensive, and always available
5. **Objects have properties and methods** - you can access and manipulate them
6. **Cross-platform PowerShell (v7+) works** on Windows, Linux, and macOS
7. **Tab completion accelerates your workflow** - type partial command and press Tab

---

## Practice What You've Learned

Ready to apply this knowledge? 
👉 **Next:** Complete the [exercises.ps1](exercises.ps1) to practice these concepts!

Then take the [quiz.json](quiz.json) to test your understanding.

---

## Additional Resources

- **Official PowerShell Documentation:** https://docs.microsoft.com/en-us/powershell/
- **PowerShell Learn Path:** https://docs.microsoft.com/en-us/learn/modules/introduction-to-powershell/
- **Microsoft Learn:** https://learn.microsoft.com/
- **PowerShell GitHub:** https://github.com/PowerShell/PowerShell

---

**Ready to move forward? Complete the exercises and quiz!** 🚀
