# PSLearningACO Content Repository

This repository contains all learning materials, exercises, quizzes, and solutions for the PSLearningACO training platform.

## Structure

Each module has its own directory with:
- **lesson.md** - Comprehensive lesson material with explanations and code examples
- **exercises.ps1** - Hands-on exercises for practice
- **quiz.json** - Multiple choice assessment questions
- **solutions.ps1** - Answer key with explanations

## Modules

### Beginner Level
- **PS-Basics** - PowerShell Fundamentals
- **PS-Objects** - Working with PowerShell Objects
- **PS-Pipeline** - Mastering the PowerShell Pipeline
- **PS-API** - REST APIs and Web Services
- **PS-CrossPlatform** - Cross-Platform PowerShell Development

### Intermediate Level
- **PS-Functions** - PowerShell Functions and Scripts
- **PS-ErrorHandling** - Error Handling and Debugging
- **PS-Security** - PowerShell Security Best Practices
- **PS-Testing** - Testing PowerShell Code with Pester

### Advanced Level
- **PS-Modules** - PowerShell Modules Development
- **PS-Classes** - PowerShell Classes and OOP
- **PS-Remoting** - PowerShell Remoting and Sessions
- **PS-Advanced** - Advanced PowerShell Concepts
- **PS-Performance** - PowerShell Performance Optimization
- **PS-Automation** - PowerShell Automation and Orchestration

## How to Use

### From PSLearningACO Module
```powershell
# Get content for a specific module
Get-ModuleContent -ModuleId "PS-Basics" -ContentType "lesson"

# Run exercises
Get-ModuleContent -ModuleId "PS-Basics" -ContentType "exercises"

# Take a quiz
Get-ModuleContent -ModuleId "PS-Basics" -ContentType "quiz"

# View solutions
Get-ModuleContent -ModuleId "PS-Basics" -ContentType "solutions"
```

### Directly from This Repository
```bash
# Clone the content repository
git clone https://github.com/sup3r7-fabio/ps-learning-aco-content.git
cd ps-learning-aco-content

# View lesson material
cat PS-Basics/lesson.md

# View exercises
cat PS-Basics/exercises.ps1

# Run quiz
pwsh -File PS-Basics/quiz.json
```

## File Formats

### lesson.md
Markdown file with:
- Learning objectives overview
- Concept explanations
- Code examples with inline comments
- Key takeaways
- Links to official documentation

### exercises.ps1
PowerShell script with:
- Numbered practice problems
- Hints and starting code
- Instructions for each exercise
- Difficulty levels (⭐ to ⭐⭐⭐)

### quiz.json
JSON file containing:
- Multiple choice questions (10-15 per module)
- 4 answer options each
- Correct answer indicator
- Explanations for each answer
- Difficulty scoring

### solutions.ps1
PowerShell script with:
- Complete working solutions
- Detailed explanations
- Alternative approaches
- Best practices commentary

## Contributing

To add or improve content:

1. Create a new branch: `git checkout -b content/module-name`
2. Add/modify files in the module directory
3. Test exercises and quiz questions
4. Create a pull request with description

## Integration with PSLearningACO

This repository is designed to work seamlessly with the PSLearningACO module:

1. The main module provides learning path recommendations
2. This content repo provides the actual learning material
3. The `Get-ModuleContent` cmdlet bridges them together
4. Learners follow recommended paths and access content as needed

## Setup

### Clone Both Repositories
```bash
# Clone the main module
git clone https://github.com/sup3r7-fabio/ps-learning-aco.git

# Clone the content
git clone https://github.com/sup3r7-fabio/ps-learning-aco-content.git ps-learning-aco/PSLearningACO/Content
```

### Configure Content Path
```powershell
# In your PowerShell profile
$env:PSLearningACOContentPath = "$PSScriptRoot\ps-learning-aco-content"
```

## Quick Start: Your Learning Journey

1. **Initialize the colony**
   ```powershell
   $colony = Start-LearningColony
   ```

2. **Track your progress**
   ```powershell
   Add-LearnerProgress -LearnerId "YourName" -ModuleId "PS-Basics" -Score 85 -CompletionTime 45
   ```

3. **Get recommended path**
   ```powershell
   Get-OptimalPath -LearnerId "YourName" -TargetModule "PS-Advanced"
   ```

4. **Access next module's content**
   ```powershell
   Get-ModuleContent -ModuleId "PS-Objects" -ContentType "lesson"
   ```

5. **Complete exercises**
   ```powershell
   Get-ModuleContent -ModuleId "PS-Objects" -ContentType "exercises"
   ```

6. **Take assessment**
   ```powershell
   Get-ModuleContent -ModuleId "PS-Objects" -ContentType "quiz"
   ```

## License

MIT License - See LICENSE file

## Support

- Issues: https://github.com/sup3r7-fabio/ps-learning-aco-content/issues
- Main Module: https://github.com/sup3r7-fabio/ps-learning-aco
- Email: fabio.ostind@sup3r7.onmicrosoft.com

---

**Happy Learning! 📚**
