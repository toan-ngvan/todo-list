import 'package:flutter/material.dart';
import 'package:todo_list/core/enum/sort_field_enum.dart';
import 'package:todo_list/core/enum/sort_type_enum.dart';
import 'package:todo_list/core/constants/app_text_styles.dart';
import 'package:todo_list/core/constants/app_text_styles.dart';

class SortTypesWidget extends StatelessWidget {
  const SortTypesWidget({
    required this.sortTypes,
    required this.currentType,
    required this.currentField,
    required this.onChange,
    super.key,
  });

  final List<SortType> sortTypes;
  final SortType currentType;
  final SortField currentField;
  final Function(SortType) onChange;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Types',
          style: AppTextStyles.grey700Medium20Text,
        ),
        const SizedBox(height: 10),
        for (SortType type in sortTypes)
          InkWell(
            onTap: () => onChange(type),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                children: [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: Radio<SortType>(
                      value: type,
                      groupValue: currentType,
                      onChanged: (value) {},
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    type.getNameByField(currentField),
                    style: AppTextStyles.normalText,
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
