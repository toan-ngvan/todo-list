import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_list/core/services/uuid_service.dart';
import 'package:todo_list/data/params/set_todo_params.dart';
import 'package:todo_list/data/repositories/todo_repositories_impl.dart';
import 'package:todo_list/data/sources/network/firebase/todo_firestore.dart';
import 'package:todo_list/domain/entities/api_message_response/message_response_entity.dart';
import 'package:todo_list/domain/entities/todo/todo_entity.dart';
import 'package:todo_list/domain/repositories/todo_repositories.dart';

import 'todo_repositories_test.mocks.dart';

@GenerateMocks([TodoFirestore])
void main() {
  late MockTodoFirestore mockTodoFirestore;
  late TodoRepositories todoRepositories;

  setUp(() {
    mockTodoFirestore = MockTodoFirestore();
    todoRepositories = TodoRepositoriesImpl(mockTodoFirestore);
  });

  test('Should get todo success', () async {
    when(mockTodoFirestore.getTodoList())
        .thenAnswer((_) async => TodoListEntity());

    final response = await todoRepositories.getTodoList();

    expect(response, TodoListEntity());
  });

  test('Should set todo success', () async {
    final SetTodoParams params = SetTodoParams(
      id: UuidService().genId(),
      date: DateTime.now().millisecondsSinceEpoch,
      status: 0,
      title: 'Test',
    );
    when(mockTodoFirestore.setTodo(params))
        .thenAnswer((_) async => MessageResponseEntity.success());

    final response = await todoRepositories.setTodo(params);

    expect(response, MessageResponseEntity.success());
  });
}
