import 'package:todo_list/domain/entities/todo/todo_entity.dart';

abstract class TodoRepositories {
  Future<TodoListEntity> getTodoList();
}
