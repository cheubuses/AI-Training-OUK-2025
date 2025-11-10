walker repo_mapper {
has repo_path: str;
has file_list: list = [];
can map_repository with entry {
# Goes through the directory structure, identify code diles and return a s structured file tree
print("Mapping repository structure");
}
}
