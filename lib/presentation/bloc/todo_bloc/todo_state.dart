part of 'todo_cubit.dart';

@freezed
class TodoState with _$TodoState {
  factory TodoState({
    required AppEntity<TodoListEntity> todoListEntity,
    AppEntity<MessageResponseEntity>? setTodoEntity,
    @Default([]) List<TodoEntity> filteredTodo,
    @Default(SortField.date) SortField sortField,
    @Default(SortType.newest) SortType sortType,
    @Default('') String searchText,
  }) = _TodoState;

  factory TodoState.initial() =>
      TodoState(todoListEntity: AppEntity<TodoListEntity>.loading());
}
