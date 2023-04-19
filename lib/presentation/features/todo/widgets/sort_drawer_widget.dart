
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/core/enum/sort_field_enum.dart';
import 'package:todo_list/core/enum/sort_type_enum.dart';
import 'package:todo_list/core/extensions/extensions.dart';
import 'package:todo_list/injection/injector.dart';
import 'package:todo_list/presentation/bloc/todo_bloc/todo_cubit.dart';
import 'package:todo_list/presentation/common_widgets/primary_button.dart';
import 'package:todo_list/presentation/features/todo/widgets/sort_fields_widget.dart';
import 'package:todo_list/presentation/features/todo/widgets/sort_types_widget.dart';

class SortDrawerWidget extends StatefulWidget {
  const SortDrawerWidget({super.key, required this.onCloseDrawer});

  final Function() onCloseDrawer;

  @override
  State<SortDrawerWidget> createState() => _SortDrawerWidgetState();
}

class _SortDrawerWidgetState extends State<SortDrawerWidget> {
  final TodoCubit _todoCubit = injector.get<TodoCubit>();
  SortField? _sortField;
  SortType? _sortType;

  void _onChangeField(SortField sortField) {
    setState(() {
      _sortField = sortField;
    });
  }

  void _onChangeSortType(SortType sortType) {
    setState(() {
      _sortType = sortType;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoCubit, TodoState>(
      bloc: _todoCubit,
      builder: (_, state) {
        return Drawer(
          width: context.screenWidth,
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text('Sorts'),
              actions: [
                IconButton(
                  onPressed: widget.onCloseDrawer,
                  icon: const Icon(Icons.close_rounded),
                ),
              ],
              automaticallyImplyLeading: false,
            ),
            body: Padding(
              padding: EdgeInsets.only(
                top: context.statusBarHeight,
                right: 16,
                left: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Sort Field
                  SortFieldsWidget(
                    sortFields: SortField.values,
                    currentField: _sortField ?? state.sortField,
                    onChange: _onChangeField,
                  ),
                  const Divider(
                    thickness: 1,
                    height: 24,
                  ),
                  // Sort Type
                  SortTypesWidget(
                    sortTypes: SortType.values,
                    currentType: _sortType ?? state.sortType,
                    currentField: _sortField ?? state.sortField,
                    onChange: _onChangeSortType,
                  ),
                  const Expanded(child: SizedBox()),
                  // Button
                  PrimaryButton(
                    title: 'Done',
                    onPressed: () {
                      _todoCubit.onFilterTodo(_sortField ?? state.sortField,
                          _sortType ?? state.sortType);
                      widget.onCloseDrawer();
                    },
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
