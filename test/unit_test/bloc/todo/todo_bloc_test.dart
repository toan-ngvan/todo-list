import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:todo_list/core/services/uuid_service.dart';
import 'package:todo_list/data/params/set_todo_params.dart';
import 'package:todo_list/data/repositories/todo_repositories_impl.dart';
import 'package:todo_list/data/sources/network/firebase/todo_firestore.dart';
import 'package:todo_list/domain/entities/api_message_response/message_response_entity.dart';
import 'package:todo_list/domain/entities/app_entity.dart';
import 'package:todo_list/domain/entities/todo/todo_entity.dart';
import 'package:todo_list/domain/repositories/todo_repositories.dart';
import 'package:todo_list/domain/use_cases/todo_use_cases/get_todo_list_use_case.dart';
import 'package:todo_list/domain/use_cases/todo_use_cases/set_todo_use_case.dart';
import 'package:todo_list/presentation/bloc/todo_bloc/todo_cubit.dart';

import 'todo_bloc_test.mocks.dart';

@GenerateMocks([GetTodoListUseCase, SetTodoUseCase, TodoEntity, SetTodoParams])
// @GenerateNiceMocks([MockSpec<SetTodoUseCase>()])
void main() {
  late MockGetTodoListUseCase mockGetTodoListUseCase;
  late MockSetTodoUseCase mockSetTodoUseCase;
  late MockTodoEntity mockTodoEntity;
  late TodoCubit todoCubit;

  setUp(() {
    mockGetTodoListUseCase = MockGetTodoListUseCase();
    mockSetTodoUseCase = MockSetTodoUseCase();
    mockTodoEntity = MockTodoEntity();
    todoCubit = TodoCubit(mockGetTodoListUseCase, mockSetTodoUseCase);
  });

  blocTest<TodoCubit, TodoState>(
    'emits [todoListEntity] when getting todo successful.',
    build: () => todoCubit,
    act: (bloc) {
      when(mockGetTodoListUseCase())
          .thenAnswer((_) async => AppEntity.success(TodoListEntity()));
      todoCubit.getTodoList();
    },
    expect: () => <TodoState>[
      todoCubit.state.copyWith(todoListEntity: AppEntity.loading()),
      todoCubit.state
          .copyWith(todoListEntity: AppEntity.success(TodoListEntity())),
    ],
  );

  blocTest<TodoCubit, TodoState>(
    'emits [todoListEntity] when getting todo failed.',
    build: () => todoCubit,
    act: (bloc) {
      when(mockGetTodoListUseCase()).thenAnswer((_) async => throw 'Error');
      todoCubit.getTodoList();
    },
    expect: () => <TodoState>[
      todoCubit.state.copyWith(todoListEntity: AppEntity.loading()),
      todoCubit.state.copyWith(todoListEntity: AppEntity.error('Error')),
    ],
  );

  blocTest<TodoCubit, TodoState>(
    'emits [setTodoEntity] when setting todo successful.',
    build: () => todoCubit,
    act: (bloc) {
      final TodoEntity entity = TodoEntity(
        id: UuidService().genId(),
        date: DateTime.now().millisecondsSinceEpoch,
        status: 0,
        title: 'Test',
      );

      when(mockSetTodoUseCase.call(any))
          .thenAnswer((_) async => AppEntity.success(MessageResponseEntity()));
      todoCubit.setTodo(entity);
    },
    expect: () => <TodoState>[
      todoCubit.state.copyWith(setTodoEntity: AppEntity.loading()),
      todoCubit.state
          .copyWith(setTodoEntity: AppEntity.success(MessageResponseEntity())),
    ],
  );

  blocTest<TodoCubit, TodoState>(
    'emits [setTodoEntity] when setting todo failed.',
    build: () => todoCubit,
    act: (bloc) {
      final TodoEntity entity = TodoEntity(
        id: UuidService().genId(),
        date: DateTime.now().millisecondsSinceEpoch,
        status: 0,
        title: 'Test',
      );

      when(mockSetTodoUseCase.call(any))
          .thenAnswer((_) async => throw 'Can not update');
      todoCubit.setTodo(entity);
    },
    expect: () => <TodoState>[
      todoCubit.state.copyWith(setTodoEntity: AppEntity.loading()),
      todoCubit.state
          .copyWith(setTodoEntity: AppEntity.error('Can not update')),
    ],
  );
}
