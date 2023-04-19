import 'package:collection/collection.dart';

enum TodoStatus {
  inProgress(value: 0, text: 'IN_PROGRESS'),
  completed(value: 1, text: 'COMPLETED'),
  unknown(value: -1, text: '');

  const TodoStatus({
    required this.value,
    required this.text,
  });

  final int value;
  final String text;

  bool get isInProgress => value == 0;
  bool get isCompleted => value == 1;

  static TodoStatus getByValue(int value) =>
      TodoStatus.values.firstWhereOrNull((t) => t.value == value) ??
      TodoStatus.unknown;
}
