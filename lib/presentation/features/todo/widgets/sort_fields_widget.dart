import 'package:flutter/material.dart';
import 'package:todo_list/core/enum/sort_field_enum.dart';
import 'package:todo_list/core/constants/app_text_styles.dart';

class SortFieldsWidget extends StatelessWidget {
  const SortFieldsWidget({
    required this.sortFields,
    required this.currentField,
    required this.onChange,
    super.key,
  });

  final List<SortField> sortFields;
  final SortField currentField;
  final Function(SortField) onChange;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Fields',
          style: AppTextStyles.grey700Medium20Text,
        ),
        const SizedBox(height: 10),
        for (SortField field in sortFields)
          InkWell(
            onTap: () => onChange(field),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                children: [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: Radio<SortField>(
                      value: field,
                      groupValue: currentField,
                      onChanged: (_) => onChange(field),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(field.name),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
