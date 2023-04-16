import 'package:todo_list/data/sources/network/firebase/todo_firestore.dart';
import 'package:todo_list/injection/injector.dart';

class InfraInjection {
  static void inject() {
    injector.registerLazySingleton<TodoFirestore>(() => TodoFirestore());
  }
}
