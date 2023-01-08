import 'package:freezed_annotation/freezed_annotation.dart';

import 'todo.dart';

part 'todos.freezed.dart';
part 'todos.g.dart';

@freezed
class Todos with _$Todos {
  const factory Todos({
    @Default([]) List<Todo> values,
  }) = _Todos;

  const Todos._();

  List<Todo> get completed {
    return values.where((todo) => todo.completed).toList();
  }

  List<Todo> get active {
    return values.where((todo) => !todo.completed).toList();
  }

  factory Todos.fromJson(Map<String, Object?> json) => _$TodosFromJson(json);
}
