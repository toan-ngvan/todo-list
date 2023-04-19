import 'package:todo_list/domain/use_cases/todo_use_cases/get_todo_list_use_case.dart';
import 'package:todo_list/domain/use_cases/todo_use_cases/set_todo_use_case.dart';
import 'package:todo_list/injection/injector.dart';
import 'package:todo_list/presentation/bloc/todo_bloc/todo_cubit.dart';

class BlocInjection {
  static void inject() {
    injector.registerLazySingleton<TodoCubit>(
      () => TodoCubit(
        injector.get<GetTodoListUseCase>(),
        injector.get<SetTodoUseCase>(),
      ),
    );
  }
}
