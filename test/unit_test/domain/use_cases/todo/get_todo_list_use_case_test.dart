import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_list/domain/entities/app_entity.dart';
import 'package:todo_list/domain/entities/todo/todo_entity.dart';
import 'package:todo_list/domain/repositories/todo_repositories.dart';
import 'package:todo_list/domain/use_cases/todo_use_cases/get_todo_list_use_case.dart';

import 'get_todo_list_use_case_test.mocks.dart';

@GenerateMocks([TodoRepositories])
void main() {
  late MockTodoRepositories mockTodoRepositories;
  late GetTodoListUseCase getTodoListUseCase;

  setUp(() {
    mockTodoRepositories = MockTodoRepositories();
    getTodoListUseCase = GetTodoListUseCase(mockTodoRepositories);
  });

  test('Should get Todo from repository', () async {
    when(mockTodoRepositories.getTodoList())
        .thenAnswer((_) async => TodoListEntity());
    final AppEntity appEntity = await getTodoListUseCase();
    expect(appEntity, AppEntity.success(TodoListEntity()));
  });
}
