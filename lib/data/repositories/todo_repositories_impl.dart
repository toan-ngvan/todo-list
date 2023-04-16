import 'package:todo_list/data/sources/network/firebase/todo_firestore.dart';
import 'package:todo_list/domain/entities/todo/todo_entity.dart';
import 'package:todo_list/domain/repositories/todo_repositories.dart';

class TodoRepositoriesImpl extends TodoRepositories {
  TodoRepositoriesImpl(this._todoFirestore);

  final TodoFirestore _todoFirestore;
  @override
  Future<TodoListEntity> getTodoList() {
    return _todoFirestore.getTodoList();
  }
}
