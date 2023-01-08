import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repository/module.dart';
import 'delete_todo.dart';
import 'delete_todo_impl.dart';
import 'get_todo.dart';
import 'get_todo_impl.dart';
import 'get_todos.dart';
import 'get_todos_impl.dart';
import 'save_todo.dart';
import 'save_todo_impl.dart';

final getTodosProvider = Provider<GetTodosUseCase>((ref) {
  return GetTodosUseCaseImpl(ref.read(todosProvider));
});

final getTodoProvider = Provider<GetTodoUseCase>((ref) {
  return GetTodoUseCaseImpl(ref.read(todosProvider));
});

final saveTodoProvider = Provider<SaveTodoUseCase>((ref) {
  return SaveTodoUseCaseImpl(ref.read(todosProvider));
});

final deleteTodoProvider = Provider<DeleteTodoUseCase>((ref) {
  return DeleteTodoUseCaseImpl(ref.read(todosProvider));
});
