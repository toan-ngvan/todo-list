import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_list/domain/entities/todo/todo_entity.dart';

class TodoFirestore {
  final todoCollection = FirebaseFirestore.instance.collection('todos');

  Future<TodoListEntity> getTodoList() async {
    final QuerySnapshot<Map<String, dynamic>> snapshot =
        await todoCollection.get();
    final List<Map<String, dynamic>> docs =
        snapshot.docs.map((doc) => doc.data()).toList();
    return TodoListEntity.fromJson({'todoList': docs});
  }
}
