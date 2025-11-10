touch CodeAnalyzer.jac
touch DocGenie.jac
REMEMBER: Capitalization matters! RepoMapper.jac ≠ repomapper.jac
1. RepoMapper.jac
Purpose: Maps the repository structure and identifies files
walker RepoMapper {
has repo_path: str;
has file_list: list = [];
can map_repository with entry {
# Logic to traverse directory structure
# Identifies all code files
# Returns structured file tree
print("Mapping repository structure...");
}
}
What it does:
Scans your project directory
Creates a hierarchical map of all files
Identifies file types (Python, JavaScript, etc.)
Returns a structured list for analysis
2. CodeAnalyzer.jac
Purpose: Analyzes code quality, complexity, and patterns
walker code_analyzer {
has file_path: str;
has analysis_results: dict = {};
can analyze_code with entry {
# Reads file content
# Performs static code analysis
# Identifies functions, classes, imports
# Calculates complexity metrics
print("Analyzing code structure...");
}
}