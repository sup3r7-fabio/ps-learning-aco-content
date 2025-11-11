<#
.SYNOPSIS
    PowerShell Fundamentals - Practice Exercises
    
.DESCRIPTION
    Hands-on exercises to practice basic PowerShell commands, cmdlets, and concepts.
    Each exercise has a difficulty rating and hints to guide you.
    
.NOTES
    Difficulty levels:
    ⭐ = Basic (1-2 lines, straightforward)
    ⭐⭐ = Intermediate (3-5 lines, requires understanding)
    ⭐⭐⭐ = Advanced (5+ lines, requires problem-solving)
    
    Try to solve each exercise without looking at solutions.ps1 first!
    Then compare your solution with the provided one.
#>

# =============================================================================
# EXERCISE 1: Navigation and File Operations ⭐
# =============================================================================

<#
PROBLEM: 
Navigate to your home directory and list all PowerShell files (.ps1).

HINT:
- Use Set-Location to go to home directory
- Use Get-ChildItem with -Filter parameter
- Home directory is typically stored in $HOME variable

YOUR SOLUTION HERE:
#>

# Solution outline:
# 1. Change to home directory
# 2. List files matching *.ps1 pattern


# =============================================================================
# EXERCISE 2: Getting Process Information ⭐
# =============================================================================

<#
PROBLEM:
Get all running processes and display only those using more than 100MB of memory.
Show the process name and memory usage in megabytes.

HINT:
- Use Get-Process to list all processes
- Use Where-Object to filter (or the shorthand ?)
- Use Select-Object to choose properties
- Memory is stored in WorkingSet property (in bytes)
- Divide by 1MB to convert to megabytes

YOUR SOLUTION HERE:
#>

# Solution outline:
# 1. Get all processes
# 2. Filter for those with WorkingSet > 100MB
# 3. Select Name and calculated Memory in MB
# 4. Consider sorting by memory (descending)


# =============================================================================
# EXERCISE 3: File Creation and Content ⭐⭐
# =============================================================================

<#
PROBLEM:
Create a new file called "inventory.txt" in your Documents folder with the
following content:
  Item,Quantity,Price
  Laptop,5,1200
  Mouse,20,25
  Keyboard,15,75

Then read the file and display its contents.

HINT:
- Use New-Item to create the file OR Out-File to write to a file
- Use Write-Host or Get-Content to display
- Consider using @" ... "@  for multi-line strings
- Path can be: "$HOME\Documents\inventory.txt"

YOUR SOLUTION HERE:
#>

# Solution outline:
# 1. Create the file path
# 2. Write content to the file
# 3. Read and display the file


# =============================================================================
# EXERCISE 4: Parameter Usage ⭐⭐
# =============================================================================

<#
PROBLEM:
Create a function that accepts two parameters: a directory path and a file
extension. The function should count how many files of that extension exist
in that directory.

Function signature:
  function Count-Files { param($Path, $Extension) }

HINT:
- Use Get-ChildItem with -Path and -Filter parameters
- Filter format is: "*.$Extension"
- Use .Count property or Measure-Object
- Add error handling for invalid paths

YOUR SOLUTION HERE:
#>

function Count-Files {
    param(
        [string]$Path,
        [string]$Extension
    )
    
    # Your code here
}

# Test the function:
# Count-Files -Path "$HOME\Documents" -Extension "txt"


# =============================================================================
# EXERCISE 5: Working with Objects and Methods ⭐⭐
# =============================================================================

<#
PROBLEM:
Get all services on your computer that are currently running. Count them
and display the top 5 services by display name (alphabetically sorted).

HINT:
- Use Get-Service to list all services
- Filter for Status = "Running"
- Use Sort-Object for sorting
- Use Select-Object -First 5 for top 5
- Use Measure-Object to count

YOUR SOLUTION HERE:
#>

# Solution outline:
# 1. Get all services
# 2. Filter for running status
# 3. Sort by DisplayName alphabetically
# 4. Select first 5
# 5. Show count of total running services


# =============================================================================
# EXERCISE 6: Variables and Data Types ⭐
# =============================================================================

<#
PROBLEM:
Create variables for:
- Your name (string)
- Your age (integer)
- Whether you know PowerShell (boolean)
- A list of your favorite programming languages (array)

Then display each variable and its type.

HINT:
- Prefix variable names with $
- Use @() for arrays
- Use $true and $false for booleans
- Use GetType() method to see the type
- Use Write-Host with string interpolation for display

YOUR SOLUTION HERE:
#>

# Variable declarations:
$name = 

$age = 

$knowsPowerShell = 

$languages = 

# Display them:


# =============================================================================
# EXERCISE 7: String Manipulation ⭐⭐
# =============================================================================

<#
PROBLEM:
Create a PowerShell script that:
1. Takes a sentence as input
2. Converts it to uppercase
3. Counts the number of words
4. Counts the number of characters
5. Replaces all vowels (a,e,i,o,u) with *

Input example: "PowerShell is awesome"

HINT:
- Use .ToUpper() method for case conversion
- Use .Split() for splitting into words, then .Count
- Use .Length property for character count
- Use -Replace operator with regex pattern '[aeiouAEIOU]'

YOUR SOLUTION HERE:
#>

$sentence = "PowerShell is awesome"

# Your code here


# =============================================================================
# EXERCISE 8: Filtering and Sorting ⭐⭐
# =============================================================================

<#
PROBLEM:
Get all files in your current directory that:
- Have a .txt extension
- Were created in the last 7 days
- Are larger than 1KB

Display them sorted by size (largest first).

HINT:
- Use Get-ChildItem with -Filter "*.txt"
- Use Where-Object to filter by date and size
- Use (Get-Date).AddDays(-7) for date calculation
- Use CreationTime property for creation date
- Use Length property for file size
- Sort-Object -Property Length -Descending

YOUR SOLUTION HERE:
#>

# Solution outline:
# 1. Get all txt files
# 2. Filter by creation date and size
# 3. Sort by size descending
# 4. Display results


# =============================================================================
# EXERCISE 9: Error Handling ⭐⭐⭐
# =============================================================================

<#
PROBLEM:
Create a function that safely reads a file. If the file doesn't exist,
it should display a user-friendly error message instead of crashing.
The function should:
- Accept a file path as parameter
- Return the file content if successful
- Return a friendly error message if file doesn't exist
- Return the actual error message if other error occurs

HINT:
- Use Try-Catch blocks
- Use Test-Path to check if file exists first
- Use Get-Content to read the file
- Use $_ for accessing the error object in catch block

YOUR SOLUTION HERE:
#>

function Read-Filesafely {
    param([string]$FilePath)
    
    # Your code here
}

# Test the function:
# Read-Filesafely -FilePath "$HOME\Documents\existing-file.txt"
# Read-Fileself -FilePath "$HOME\Documents\nonexistent-file.txt"


# =============================================================================
# EXERCISE 10: Pipe Operations and Formatting ⭐⭐⭐
# =============================================================================

<#
PROBLEM:
Create a complex pipeline that:
1. Gets all processes currently running
2. Filters for processes using more than 50MB of memory
3. Sorts them by memory usage (highest first)
4. Displays only: Name, ID, Memory (in MB), and Priority
5. Limits to top 10 processes
6. Exports the result to a CSV file called "top-processes.csv"

HINT:
- Pipe operations connect with |
- Use Where-Object for filtering
- Use Select-Object for choosing properties
- Use Sort-Object -Property -Descending
- Use Select-Object -First 10 for limiting
- Use Export-Csv -Path "filename.csv" -NoTypeInformation
- Calculate MB by: {$_.WorkingSet / 1MB}

YOUR SOLUTION HERE:
#>

# Solution outline:
# 1. Get processes
# 2. Filter by memory > 50MB
# 3. Sort by memory descending
# 4. Select top 10 with specific properties (calculate MB)
# 5. Export to CSV


# =============================================================================
# Challenge: Bonus Exercise ⭐⭐⭐⭐
# =============================================================================

<#
CHALLENGE PROBLEM:
Write a PowerShell script that:
1. Creates a folder structure for organizing documents by year
   (Current year, folders for Jan-Dec)
2. Creates sample files (2-3 per month) with content
3. Generates a report showing:
   - Total number of files created
   - Files per month
   - Total size of all files
   - List of all files organized by month
4. Exports the report to a text file

This combines: file creation, loops, object manipulation, filtering, and
formatting - everything you've learned in this module!

YOUR SOLUTION HERE:
#>

# This is a big one! Think about your approach first:
# Step 1: Create folder structure
# Step 2: Create sample files
# Step 3: Gather statistics using Get-ChildItem
# Step 4: Format and export report


# =============================================================================
# Tips for Success
# =============================================================================

<#
- Use Get-Help frequently: Get-Help Get-Process -Examples
- Use tab completion: Type "Get-C" and press Tab multiple times
- Use the pipeline more: Get-Process | Get-Member
- Don't memorize everything - understand the concepts
- Test commands in small parts before combining
- Use Write-Host to add debug output and understand flow
- Practice, practice, practice!

Ready for the quiz? Go to quiz.json to test your knowledge!
#>
