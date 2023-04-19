import 'dart:convert';
import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/core/enum/sort_field_enum.dart';
import 'package:todo_list/core/enum/sort_type_enum.dart';
import 'package:todo_list/core/enum/todo_status_enum.dart';
import 'package:todo_list/core/services/uuid_service.dart';
import 'package:todo_list/data/params/set_todo_params.dart';

part 'todo_entity.freezed.dart';
part 'todo_entity.g.dart';

@Freezed(toJson: false)
class TodoListEntity with _$TodoListEntity {
  factory TodoListEntity({
    @Default([]) List<TodoEntity> todoList,
  }) = _TodoListEntity;

  TodoListEntity._();

  factory TodoListEntity.fromJson(Map<String, dynamic> json) =>
      _$TodoListEntityFromJson(json);

  List<TodoEntity> search(String text, List<TodoEntity> list) {
    if (text.isEmpty) {
      return list;
    }
    final searchText = text.toLowerCase();
    return List<TodoEntity>.from(list)
        .where((todo) =>
            todo.title.toLowerCase().contains(searchText) ||
            todo.description.toLowerCase().contains(searchText))
        .toList();
  }

  List<TodoEntity> sortByTitle(List<TodoEntity> list,
      {SortType sortType = SortType.newest}) {
    return List<TodoEntity>.from(list)
      ..sort(
        (a, b) {
          final sort = a.title.toLowerCase().compareTo(b.title.toLowerCase());
          return sortType.isNewest ? sort : sort * -1;
        },
      );
  }

  List<TodoEntity> sortByDate(List<TodoEntity> list,
      {SortType sortType = SortType.newest}) {
    return List<TodoEntity>.from(list)
      ..sort(
        (a, b) {
          final sort = a.date.compareTo(b.date);
          return sortType.isNewest ? sort * -1 : sort;
        },
      );
  }

  List<TodoEntity> sortByStatus(List<TodoEntity> list,
      {SortType sortType = SortType.newest}) {
    return List<TodoEntity>.from(list)
      ..sort(
        (a, b) {
          // In progress: 0
          // Completed: 1
          final sort = a.status.compareTo(b.status);
          return sortType.isNewest ? sort : sort * -1;
        },
      );
  }

  List<TodoEntity> sortTodo(
    List<TodoEntity> list, {
    SortField sortField = SortField.status,
    SortType sortType = SortType.newest,
  }) {
    switch (sortField) {
      case SortField.title:
        return sortByTitle(list, sortType: sortType);
      case SortField.date:
        return sortByDate(list, sortType: sortType);
      case SortField.status:
        return sortByStatus(list, sortType: sortType);
      default:
        return [];
    }
  }

  List<TodoEntity> filter({
    String searchText = '',
    SortField sortField = SortField.status,
    SortType sortType = SortType.newest,
  }) {
    final searchList = search(searchText, todoList);
    final filterList =
        sortTodo(searchList, sortField: sortField, sortType: sortType);
    return filterList;
  }
}

@Freezed(toJson: false)
class TodoEntity with _$TodoEntity {
  factory TodoEntity({
    required String id,
    required String title,
    required int status,
    required int date,
    @Default('') String description,
    String? image,
  }) = _TodoEntity;

  TodoEntity._();

  factory TodoEntity.fromJson(Map<String, dynamic> json) =>
      _$TodoEntityFromJson(json);

  factory TodoEntity.empty() => TodoEntity(
        id: UuidService().genId(),
        title: '',
        description: '',
        status: TodoStatus.inProgress.value,
        date: DateTime.now().millisecondsSinceEpoch,
      );

  TodoStatus get statusEnum => TodoStatus.getByValue(status);

  Uint8List? get fileDecode {
    try {
      return image != null && image!.isNotEmpty
          ? const Base64Decoder().convert(image!)
          : null;
    } catch (e) {
      return null;
    }
  }

  DateTime get dateByDateTime => DateTime.fromMillisecondsSinceEpoch(date);
  String get dateString => DateFormat('yyyy-MM-dd').format(dateByDateTime);

  SetTodoParams toParams() => SetTodoParams(
        id: id,
        title: title,
        description: description,
        status: status,
        image: image,
        date: date,
      );
}
