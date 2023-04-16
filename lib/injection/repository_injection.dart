import 'package:todo_list/data/repositories/todo_repositories_impl.dart';
import 'package:todo_list/data/sources/network/firebase/todo_firestore.dart';
import 'package:todo_list/domain/repositories/todo_repositories.dart';
import 'package:todo_list/injection/injector.dart';

class RepositoryInjection {
  static void inject() {
    injector.registerLazySingleton<TodoRepositories>(
      () => TodoRepositoriesImpl(
        injector.get<TodoFirestore>(),
      ),
    );
  }
}
