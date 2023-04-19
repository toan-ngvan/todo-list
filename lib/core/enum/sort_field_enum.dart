enum SortField {
  title(oldestName: 'Z-A', newestName: 'A-Z', name: 'Title'),
  date(oldestName: 'Oldest', newestName: 'Newest', name: 'Date'),
  status(oldestName: 'Completed', newestName: 'In Progress', name: 'Status');

  const SortField({
    required this.oldestName,
    required this.newestName,
    required this.name,
  });

  final String oldestName;
  final String newestName;
  final String name;
}
