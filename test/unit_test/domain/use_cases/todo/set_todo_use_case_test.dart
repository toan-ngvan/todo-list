import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_list/core/services/uuid_service.dart';
import 'package:todo_list/data/params/set_todo_params.dart';
import 'package:todo_list/domain/entities/api_message_response/message_response_entity.dart';
import 'package:todo_list/domain/entities/app_entity.dart';
import 'package:todo_list/domain/repositories/todo_repositories.dart';
import 'package:todo_list/domain/use_cases/todo_use_cases/set_todo_use_case.dart';

import 'set_todo_use_case_test.mocks.dart';

@GenerateMocks([TodoRepositories])
void main() {
  late MockTodoRepositories mockTodoRepositories;
  late SetTodoUseCase setTodoUseCase;

  setUp(() {
    mockTodoRepositories = MockTodoRepositories();
    setTodoUseCase = SetTodoUseCase(mockTodoRepositories);
  });

  test('Should set Todo from repository', () async {
    final SetTodoParams params = SetTodoParams(
      id: UuidService().genId(),
      date: DateTime.now().millisecondsSinceEpoch,
      status: 0,
      title: 'Test',
    );
    when(mockTodoRepositories.setTodo(params))
        .thenAnswer((_) async => MessageResponseEntity.success());

    final AppEntity appEntity = await setTodoUseCase(params);

    expect(appEntity, AppEntity.success(MessageResponseEntity.success()));
  });
}
