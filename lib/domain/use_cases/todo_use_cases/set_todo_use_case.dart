import 'package:todo_list/data/params/set_todo_params.dart';
import 'package:todo_list/domain/entities/api_message_response/message_response_entity.dart';
import 'package:todo_list/domain/entities/app_entity.dart';
import 'package:todo_list/domain/repositories/todo_repositories.dart';
import 'package:todo_list/domain/use_cases/use_case_base.dart';

class SetTodoUseCase
    implements
        NormalFutureUseCase<SetTodoParams, AppEntity<MessageResponseEntity>> {
  SetTodoUseCase(this._todoRepositories);
  final TodoRepositories _todoRepositories;
  @override
  Future<AppEntity<MessageResponseEntity>> call(SetTodoParams todo) async {
    return AppEntity.success(await _todoRepositories.setTodo(todo));
  }
}
