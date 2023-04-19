import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/injection/injector.dart';
import 'package:todo_list/presentation/bloc/todo_bloc/todo_cubit.dart';
import 'package:todo_list/presentation/common_widgets/primary_button.dart';
import 'package:todo_list/presentation/features/todo/widgets/todo_item_widget.dart';

class TodoListWidget extends StatelessWidget {
  TodoListWidget({super.key});

  final TodoCubit _todoCubit = injector.get<TodoCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoCubit, TodoState>(
      bloc: _todoCubit,
      builder: (_, state) {
        if (state.todoListEntity.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state.todoListEntity.isFailure) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Center(
              child: PrimaryButton(
                title: 'Some thing went wrong.Please try again!',
                onPressed: _todoCubit.getTodoList,
              ),
            ),
          );
        }

        final todoList = state.todoListEntity.entity!.filter(
          searchText: state.searchText,
          sortField: state.sortField,
          sortType: state.sortType,
        );
        return RefreshIndicator(
          onRefresh: _todoCubit.getTodoList,
          child: ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
            itemCount: todoList.length,
            itemBuilder: (_, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: TodoItemWidget(todoList[index]),
              );
            },
          ),
        );
      },
    );
  }
}
