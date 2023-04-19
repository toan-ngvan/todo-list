import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_response_entity.freezed.dart';
part 'message_response_entity.g.dart';

@Freezed(toJson: false)
class MessageResponseEntity with _$MessageResponseEntity {
  factory MessageResponseEntity({
    String? message,
    int? statusCode,
  }) = _MessageResponseEntity;

  MessageResponseEntity._();

  factory MessageResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$MessageResponseEntityFromJson(json);

  factory MessageResponseEntity.success() =>
      MessageResponseEntity(message: 'Success', statusCode: 200);
}
