import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo_list/core/enum/todo_status_enum.dart';

part 'todo_entity.freezed.dart';
part 'todo_entity.g.dart';

@Freezed(toJson: false)
class TodoListEntity with _$TodoListEntity {
  factory TodoListEntity({
    @Default([]) List<TodoEntity> todoList,
  }) = _TodoListEntity;

  TodoListEntity._();

  factory TodoListEntity.fromJson(Map<String, dynamic> json) =>
      _$TodoListEntityFromJson(json);

  List<TodoEntity> get byNewestDate => todoList
    ..sort((a, b) => b.date.compareTo(a.date))
    ..toList();
  List<TodoEntity> get inProgressList =>
      byNewestDate.where((todo) => todo.statusEnum.isInProgress).toList();
  List<TodoEntity> get completedList =>
      byNewestDate.where((todo) => todo.statusEnum.isCompleted).toList();
}

@Freezed(toJson: true)
class TodoEntity with _$TodoEntity {
  factory TodoEntity({
    required String id,
    required String title,
    required int status,
    required int date,
    @Default('') String description,
    String? image,
  }) = _TodoEntity;

  TodoEntity._();

  factory TodoEntity.fromJson(Map<String, dynamic> json) =>
      _$TodoEntityFromJson(json);

  TodoStatus get statusEnum => TodoStatus.getByValue(status);
}
