import 'package:freezed_annotation/freezed_annotation.dart';

part 'set_todo_params.g.dart';

@JsonSerializable(createFactory: false)
class SetTodoParams {
  const SetTodoParams({
    required this.id,
    required this.title,
    required this.status,
    required this.date,
    this.description = '',
    this.image = '',
  });

  final String id;
  final String title;
  final int status;
  final int date;
  final String? description;
  final String? image;

  Map<String, dynamic> toJson() => _$SetTodoParamsToJson(this);
}
