import 'package:uuid/uuid.dart';

class UuidService {
  static final UuidService _singleton = UuidService._internal();

  factory UuidService() {
    return _singleton;
  }

  UuidService._internal();

  final uuid = const Uuid();

  String genId() => uuid.v4();
}
