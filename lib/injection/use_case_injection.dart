import 'package:todo_list/domain/repositories/todo_repositories.dart';
import 'package:todo_list/domain/use_cases/todo_use_cases/get_todo_list_use_case.dart';
import 'package:todo_list/domain/use_cases/todo_use_cases/set_todo_use_case.dart';
import 'package:todo_list/injection/injector.dart';

class UseCaseInjection {
  static void inject() {
    injector.registerLazySingleton<GetTodoListUseCase>(
      () => GetTodoListUseCase(
        injector.get<TodoRepositories>(),
      ),
    );
    injector.registerLazySingleton<SetTodoUseCase>(
      () => SetTodoUseCase(
        injector.get<TodoRepositories>(),
      ),
    );
  }
}
