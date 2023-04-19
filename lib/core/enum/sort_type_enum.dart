import 'package:todo_list/core/enum/sort_field_enum.dart';

enum SortType {
  // Title: A-Z,
  // Status: In progress -> Completed
  // Date: Newest
  newest,
  oldest;

  bool get isNewest => this == SortType.newest;
  bool get isOldest => this == SortType.oldest;

  String getNameByField(SortField sortField) {
    switch (this) {
      case SortType.oldest:
        return sortField.oldestName;
      case SortType.newest:
        return sortField.newestName;
      default:
        return '';
    }
  }
}
