import 'package:todo_list/data/params/set_todo_params.dart';
import 'package:todo_list/domain/entities/api_message_response/message_response_entity.dart';
import 'package:todo_list/domain/entities/todo/todo_entity.dart';

abstract class TodoRepositories {
  Future<TodoListEntity> getTodoList();
  Future<MessageResponseEntity> setTodo(SetTodoParams todo);
}
