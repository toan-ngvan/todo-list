import 'package:todo_list/domain/entities/app_entity.dart';
import 'package:todo_list/domain/entities/todo/todo_entity.dart';
import 'package:todo_list/domain/repositories/todo_repositories.dart';
import 'package:todo_list/domain/use_cases/use_case_base.dart';

class GetTodoListUseCase
    implements FutureNoParamsUseCase<AppEntity<TodoListEntity>> {
  GetTodoListUseCase(this._todoRepositories);
  final TodoRepositories _todoRepositories;
  @override
  Future<AppEntity<TodoListEntity>> call() async {
    return AppEntity.success(await _todoRepositories.getTodoList());
  }
}
