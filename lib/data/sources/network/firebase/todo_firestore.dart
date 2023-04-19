import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_list/data/params/set_todo_params.dart';
import 'package:todo_list/domain/entities/api_message_response/message_response_entity.dart';
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

  Future<MessageResponseEntity> setTodo(SetTodoParams todo) async {
    await todoCollection.doc(todo.id).set(todo.toJson());
    return MessageResponseEntity.success();
  }
}
