import 'package:todo_list/injection/injector.dart';

class BlocInjection {
  static void inject() {
    // injector.registerLazySingleton<TodoRepositories>(
    //   () => TodoRepositoriesImpl(
    //     injector.get<TodoFirestore>(),
    //   ),
    // );
  }
}
