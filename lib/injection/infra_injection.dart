import 'package:todo_list/core/router/app_router.dart';
import 'package:todo_list/data/sources/network/firebase/todo_firestore.dart';
import 'package:todo_list/injection/injector.dart';

class InfraInjection {
  static void inject() {
    injector.registerLazySingleton<TodoFirestore>(() => TodoFirestore());
    // Router
    injector.registerLazySingleton<AppRouter>(() => AppRouter());
  }
}
