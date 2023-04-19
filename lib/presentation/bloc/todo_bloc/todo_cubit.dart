import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo_list/core/enum/sort_field_enum.dart';
import 'package:todo_list/core/enum/sort_type_enum.dart';
import 'package:todo_list/domain/entities/api_message_response/message_response_entity.dart';
import 'package:todo_list/domain/entities/app_entity.dart';
import 'package:todo_list/domain/entities/todo/todo_entity.dart';
import 'package:todo_list/domain/use_cases/todo_use_cases/get_todo_list_use_case.dart';
import 'package:todo_list/domain/use_cases/todo_use_cases/set_todo_use_case.dart';

part 'todo_state.dart';
part 'todo_cubit.freezed.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit(
    this._getTodoListUseCase,
    this._setTodoUseCase, {
    TodoState? state,
  }) : super(state ?? TodoState.initial());

  final GetTodoListUseCase _getTodoListUseCase;
  final SetTodoUseCase _setTodoUseCase;

  Future<void> getTodoList() async {
    try {
      emit(state.copyWith(todoListEntity: AppEntity.loading()));
      final appEntity = await _getTodoListUseCase();
      emit(state.copyWith(
        todoListEntity: appEntity,
      ));
    } catch (e) {
      emit(state.copyWith(todoListEntity: AppEntity.error(e)));
    }
  }

  Future<void> setTodo(TodoEntity todoEntity) async {
    try {
      emit(state.copyWith(setTodoEntity: AppEntity.loading()));
      final appEntity = await _setTodoUseCase(todoEntity.toParams());
      emit(state.copyWith(setTodoEntity: appEntity));
    } catch (e) {
      emit(state.copyWith(setTodoEntity: AppEntity.error(e)));
    }
  }

  void onSearchTodo(String text) {
    emit(state.copyWith(searchText: text));
  }

  void onFilterTodo(SortField sortField, SortType sortType) {
    emit(state.copyWith(sortField: sortField, sortType: sortType));
  }

  Future<void> deleteTodo() async {}
}
