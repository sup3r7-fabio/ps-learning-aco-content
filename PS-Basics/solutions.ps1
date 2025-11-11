<#
.SYNOPSIS
    PowerShell Fundamentals - Exercise Solutions
    
.DESCRIPTION
    Complete solutions and explanations for all PS-Basics exercises.
    Compare your solutions with these to learn different approaches.
    
.NOTES
    These are reference solutions. Your solution may look different but
    still be correct if it accomplishes the goal effectively.
#>

# =============================================================================
# SOLUTION 1: Navigation and File Operations ⭐
# =============================================================================

Write-Host "=== SOLUTION 1: Navigation and File Operations ===" -ForegroundColor Green

<# PROBLEM: Navigate to home directory and list all PowerShell files (.ps1) #>

# Solution approach:
$HomePath = $HOME
Set-Location -Path $HomePath

# List all .ps1 files
$psFiles = Get-ChildItem -Path $HomePath -Filter "*.ps1" -Recurse

# Alternative one-liner:
# Get-ChildItem -Path $HOME -Filter "*.ps1" -Recurse

Write-Host "PowerShell files found: $($psFiles.Count)"
$psFiles | Select-Object Name, Directory, Length


# =============================================================================
# SOLUTION 2: Getting Process Information ⭐
# =============================================================================

Write-Host "`n=== SOLUTION 2: Getting Process Information ===" -ForegroundColor Green

<# PROBLEM: Get processes using more than 100MB memory, show name and memory in MB #>

# Solution approach 1: Using pipeline
Get-Process |
    Where-Object { $_.WorkingSet -gt 100MB } |
    Select-Object Name, @{Name='MemoryMB'; Expression={[math]::Round($_.WorkingSet / 1MB, 2)}} |
    Sort-Object -Property MemoryMB -Descending

# Alternative approach 2: More readable with variables
$memoryThreshold = 100MB
$expensiveProcesses = Get-Process |
    Where-Object { $_.WorkingSet -gt $memoryThreshold }

$expensiveProcesses |
    Select-Object Name, 
                  @{Name='MemoryMB'; Expression={$_.WorkingSet / 1MB}} |
    Format-Table


# =============================================================================
# SOLUTION 3: File Creation and Content ⭐⭐
# =============================================================================

Write-Host "`n=== SOLUTION 3: File Creation and Content ===" -ForegroundColor Green

<# PROBLEM: Create inventory.txt with CSV data and display contents #>

# Solution approach:
$documentsPath = Join-Path -Path $HOME -ChildPath "Documents"
$filePath = Join-Path -Path $documentsPath -ChildPath "inventory.txt"

# Create content
$content = @"
Item,Quantity,Price
Laptop,5,1200
Mouse,20,25
Keyboard,15,75
"@

# Write to file
$content | Out-File -FilePath $filePath -Encoding UTF8

# Read and display
Write-Host "File contents:"
Get-Content -Path $filePath

# Alternative: Create file and add content separately
# New-Item -Path $filePath -ItemType File -Force
# Add-Content -Path $filePath -Value $content


# =============================================================================
# SOLUTION 4: Parameter Usage ⭐⭐
# =============================================================================

Write-Host "`n=== SOLUTION 4: Parameter Usage ===" -ForegroundColor Green

<# PROBLEM: Function to count files by extension in a directory #>

function Count-Files {
    param(
        [Parameter(Mandatory=$true)]
        [ValidateScript({Test-Path -Path $_})]
        [string]$Path,
        
        [Parameter(Mandatory=$true)]
        [string]$Extension
    )
    
    $filter = if ($Extension.StartsWith('.')) { "*$Extension" } else { "*.$Extension" }
    
    $files = Get-ChildItem -Path $Path -Filter $filter -File
    $count = $files.Count
    
    return @{
        Path = $Path
        Extension = $Extension
        Count = $count
        Files = $files
    }
}

# Test the function:
$result = Count-Files -Path "$HOME\Documents" -Extension "ps1"
Write-Host "Found $($result.Count) PowerShell files in Documents"

# Alternative simpler version:
function Count-FilesSimple {
    param($Path, $Extension)
    
    if (-not (Test-Path -Path $Path)) {
        Write-Error "Path does not exist: $Path"
        return
    }
    
    $files = @(Get-ChildItem -Path $Path -Filter "*.$Extension" -File)
    $files.Count
}


# =============================================================================
# SOLUTION 5: Working with Objects and Methods ⭐⭐
# =============================================================================

Write-Host "`n=== SOLUTION 5: Working with Objects and Methods ===" -ForegroundColor Green

<# PROBLEM: Top 5 running services, show count #>

# Solution approach:
$runningServices = Get-Service |
    Where-Object { $_.Status -eq 'Running' } |
    Sort-Object -Property DisplayName |
    Select-Object -First 5

Write-Host "Top 5 running services (alphabetically):"
$runningServices | Format-Table DisplayName, Status

# Count total running services
$totalRunning = (Get-Service | Where-Object { $_.Status -eq 'Running' }).Count
Write-Host "`nTotal running services: $totalRunning"

# More detailed output:
$allRunning = @(Get-Service | Where-Object { $_.Status -eq 'Running' })
Write-Host "`nTotal running services: $($allRunning.Count)"
Write-Host "First 5:"
$allRunning | Sort-Object DisplayName | Select-Object -First 5 -Property DisplayName, Status


# =============================================================================
# SOLUTION 6: Variables and Data Types ⭐
# =============================================================================

Write-Host "`n=== SOLUTION 6: Variables and Data Types ===" -ForegroundColor Green

<# PROBLEM: Create variables and display with types #>

$name = "Fabio"
$age = 35
$knowsPowerShell = $true
$languages = @("PowerShell", "C#", "Python", "JavaScript")

Write-Host "Variable Inventory:"
Write-Host "Name: $name (Type: $($name.GetType().Name))"
Write-Host "Age: $age (Type: $($age.GetType().Name))"
Write-Host "Knows PowerShell: $knowsPowerShell (Type: $($knowsPowerShell.GetType().Name))"
Write-Host "Languages: $($languages -join ', ') (Type: $($languages.GetType().Name))"

# Alternative with hashtable:
$variables = @{
    "Name" = $name
    "Age" = $age
    "PowerShell Knowledge" = $knowsPowerShell
    "Languages" = $languages
}

foreach ($key in $variables.Keys) {
    $value = $variables[$key]
    Write-Host "$key = $value (Type: $($value.GetType().Name))"
}


# =============================================================================
# SOLUTION 7: String Manipulation ⭐⭐
# =============================================================================

Write-Host "`n=== SOLUTION 7: String Manipulation ===" -ForegroundColor Green

<# PROBLEM: String manipulation - uppercase, word count, char count, replace vowels #>

$sentence = "PowerShell is awesome"

# Convert to uppercase
$upper = $sentence.ToUpper()
Write-Host "Uppercase: $upper"

# Count words
$wordCount = ($sentence -split '\s').Count
Write-Host "Word count: $wordCount"

# Count characters
$charCount = $sentence.Length
Write-Host "Character count: $charCount"

# Replace vowels with asterisks
$noVowels = $sentence -replace '[aeiouAEIOU]', '*'
Write-Host "Without vowels: $noVowels"

# Alternative comprehensive solution:
function Analyze-String {
    param([string]$Text)
    
    return @{
        Original = $Text
        Uppercase = $Text.ToUpper()
        Lowercase = $Text.ToLower()
        WordCount = ($Text -split '\s').Count
        CharCount = $Text.Length
        NoVowels = $Text -replace '[aeiouAEIOU]', '*'
    }
}

$analysis = Analyze-String -Text $sentence
$analysis | Format-Table


# =============================================================================
# SOLUTION 8: Filtering and Sorting ⭐⭐
# =============================================================================

Write-Host "`n=== SOLUTION 8: Filtering and Sorting ===" -ForegroundColor Green

<# PROBLEM: txt files from last 7 days, larger than 1KB, sorted by size #>

$sevenDaysAgo = (Get-Date).AddDays(-7)

Get-ChildItem -Path "." -Filter "*.txt" -File |
    Where-Object { 
        $_.CreationTime -gt $sevenDaysAgo -and 
        $_.Length -gt 1KB 
    } |
    Sort-Object -Property Length -Descending |
    Select-Object Name, 
                  Length, 
                  CreationTime, 
                  @{Name='SizeKB'; Expression={[math]::Round($_.Length / 1KB, 2)}}

# Alternative with more readable filtering:
$files = Get-ChildItem -Path "." -Filter "*.txt" -File

$filteredFiles = $files |
    Where-Object {
        $isNew = $_.CreationTime -gt $sevenDaysAgo
        $isLarge = $_.Length -gt 1KB
        return ($isNew -and $isLarge)
    }

$sorted = $filteredFiles | Sort-Object -Property Length -Descending
$sorted | Format-Table Name, Length, CreationTime


# =============================================================================
# SOLUTION 9: Error Handling ⭐⭐⭐
# =============================================================================

Write-Host "`n=== SOLUTION 9: Error Handling ===" -ForegroundColor Green

<# PROBLEM: Safe file reading with error handling #>

function Read-FileSafely {
    param(
        [Parameter(Mandatory=$true)]
        [string]$FilePath
    )
    
    try {
        if (-not (Test-Path -Path $FilePath)) {
            return "ERROR: File not found at '$FilePath'"
        }
        
        $content = Get-Content -Path $FilePath
        return $content
    }
    catch {
        $errorMsg = $_.Exception.Message
        return "ERROR: Could not read file - $errorMsg"
    }
}

# Test scenarios:
Write-Host "Test 1 - Existing file:"
$result1 = Read-FileSafely -FilePath "$HOME\Documents\test.txt"
Write-Host $result1

Write-Host "`nTest 2 - Non-existent file:"
$result2 = Read-FileSafely -FilePath "$HOME\Documents\nonexistent.txt"
Write-Host $result2

# More comprehensive version with different error types:
function Read-FileAdvanced {
    param([string]$Path)
    
    try {
        if (Test-Path -Path $Path) {
            Get-Content -Path $Path
        }
        else {
            Write-Error "File does not exist: $Path" -ErrorAction Stop
        }
    }
    catch [System.UnauthorizedAccessException] {
        Write-Error "Access denied to file: $Path"
    }
    catch [System.IO.FileNotFoundException] {
        Write-Error "File not found: $Path"
    }
    catch {
        Write-Error "Unexpected error: $($_.Exception.Message)"
    }
}


# =============================================================================
# SOLUTION 10: Pipe Operations and Formatting ⭐⭐⭐
# =============================================================================

Write-Host "`n=== SOLUTION 10: Pipe Operations and Formatting ===" -ForegroundColor Green

<# PROBLEM: Complex pipeline - processes >50MB, sort, display, export CSV #>

Get-Process |
    Where-Object { $_.WorkingSet -gt 50MB } |
    Sort-Object -Property WorkingSet -Descending |
    Select-Object -First 10 -Property @(
        'Name',
        'Id',
        @{Name='MemoryMB'; Expression={[math]::Round($_.WorkingSet / 1MB, 2)}},
        'PriorityClass'
    ) |
    Export-Csv -Path "top-processes.csv" -NoTypeInformation

Write-Host "Exported top 10 processes to top-processes.csv"

# Display what was exported:
Write-Host "`nTop 10 memory-intensive processes:"
Get-Process |
    Where-Object { $_.WorkingSet -gt 50MB } |
    Sort-Object -Property WorkingSet -Descending |
    Select-Object -First 10 -Property Name, 
                                      Id, 
                                      @{Name='MemoryMB'; Expression={$_.WorkingSet / 1MB}},
                                      PriorityClass |
    Format-Table


# =============================================================================
# BONUS SOLUTION: Challenge Exercise ⭐⭐⭐⭐
# =============================================================================

Write-Host "`n=== BONUS: Challenge Exercise Solution ===" -ForegroundColor Green

<# CHALLENGE: Create organized folder structure, populate with files, generate report #>

function New-DocumentOrganization {
    param(
        [string]$BasePath = "$HOME\Documents\FileOrganization"
    )
    
    # Step 1: Create folder structure
    Write-Host "Creating folder structure..."
    $currentYear = (Get-Date).Year
    
    New-Item -Path $BasePath -ItemType Directory -Force | Out-Null
    
    $months = @("January", "February", "March", "April", "May", "June", 
                "July", "August", "September", "October", "November", "December")
    
    foreach ($month in $months) {
        $monthPath = Join-Path -Path $BasePath -ChildPath $month
        New-Item -Path $monthPath -ItemType Directory -Force | Out-Null
    }
    
    # Step 2: Create sample files
    Write-Host "Creating sample files..."
    $fileCount = 0
    
    for ($month = 1; $month -le 12; $month++) {
        $monthName = $months[$month - 1]
        $monthPath = Join-Path -Path $BasePath -ChildPath $monthName
        
        for ($file = 1; $file -le 3; $file++) {
            $fileName = "Document_$($month)_$($file).txt"
            $filePath = Join-Path -Path $monthPath -ChildPath $fileName
            
            $content = @"
Document: $fileName
Created: $(Get-Date -Month $month -Day $file)
Content: Sample document for $monthName
"@
            
            $content | Out-File -FilePath $filePath
            $fileCount++
        }
    }
    
    # Step 3: Generate statistics
    Write-Host "Generating statistics..."
    $allFiles = Get-ChildItem -Path $BasePath -Recurse -File
    $totalSize = ($allFiles | Measure-Object -Property Length -Sum).Sum
    
    # Step 4: Create report
    $reportPath = Join-Path -Path $BasePath -ChildPath "Report.txt"
    $report = @"
================================================
DOCUMENT ORGANIZATION REPORT
================================================
Generated: $(Get-Date)
Base Path: $BasePath
Year: $currentYear

SUMMARY
-------
Total Files: $($allFiles.Count)
Total Size: $([math]::Round($totalSize / 1KB, 2)) KB
Folders: $($months.Count)

FILES BY MONTH
--------------
"@
    
    foreach ($month in $months) {
        $monthPath = Join-Path -Path $BasePath -ChildPath $month
        $monthFiles = @(Get-ChildItem -Path $monthPath -File)
        $monthSize = ($monthFiles | Measure-Object -Property Length -Sum).Sum
        
        $report += "`n$($month): $($monthFiles.Count) files ($([math]::Round($monthSize / 1KB, 2)) KB)"
        
        foreach ($f in $monthFiles) {
            $report += "`n  - $($f.Name)"
        }
    }
    
    $report | Out-File -FilePath $reportPath
    
    Write-Host "`n$report"
    Write-Host "`nReport saved to: $reportPath"
}

# Run the challenge solution:
# New-DocumentOrganization


# =============================================================================
# Summary of Key Concepts
# =============================================================================

<#
LESSON SUMMARY:

1. PIPES (|)
   - Connect cmdlets to pass objects from one to the next
   - Left side output becomes right side input
   - Example: Get-Process | Where-Object | Select-Object

2. OBJECTS vs TEXT
   - PowerShell works with objects that have properties and methods
   - This enables powerful filtering and manipulation
   - Select-Object and Where-Object are your best friends

3. FILTERING
   - Where-Object filters based on conditions
   - Syntax: Where-Object { $_ property operator value }

4. SELECTING
   - Select-Object chooses which properties to display
   - Can create calculated/custom properties
   - Limits output with -First, -Last

5. PARAMETERS
   - Modify cmdlet behavior
   - Use Tab completion to discover them
   - Get-Help cmdlet -Full to see all options

6. ERROR HANDLING
   - Try-Catch blocks prevent crashes
   - Test-Path checks if files/folders exist
   - $_ variable gives error details in catch block

Ready for the next module? Check out PS-Objects!
#>

Write-Host "`n=== All Solutions Complete ===" -ForegroundColor Green
Write-Host "Compare with your solutions and see alternative approaches!"
