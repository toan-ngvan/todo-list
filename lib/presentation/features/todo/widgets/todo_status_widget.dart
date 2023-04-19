import 'package:flutter/material.dart';
import 'package:todo_list/core/enum/todo_status_enum.dart';

class TodoStatusWidget extends StatelessWidget {
  const TodoStatusWidget({
    required this.statuses,
    required this.currentStatus,
    required this.onChange,
    super.key,
  });

  final List<TodoStatus> statuses;
  final TodoStatus currentStatus;
  final Function(TodoStatus) onChange;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (TodoStatus status in statuses)
          InkWell(
            onTap: () => onChange(status),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                children: [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: Radio<TodoStatus>(
                      value: status,
                      groupValue: currentStatus,
                      onChanged: (_) => onChange(status),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(status.text),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
