import 'dart:convert';

import 'package:collection/collection.dart';

import '../../domain/model/todo.dart';
import '../../domain/model/todos.dart';
import '../../domain/repository/todos.dart';
import '../source/files.dart';

class TodosRepositoryImpl extends TodosRepository {
  TodosRepositoryImpl(this.files);
  final Files files;
  late final String path = 'todos.json';

  @override
  Future<void> deleteAllTodos() async {
    // Delete files by path
    await files.delete(path);
  }

  @override
  Future<void> deleteTodo(String id) async {
    final todos = await loadTodos();

    // Remove the todo from the list
    final newTodos = todos.values.where((t) => t.id != id).toList();

    // Save the new list
    await files.write(path, jsonEncode(Todos(values: newTodos).toJson()));
  }

  @override
  Future<Todos> loadTodos() async {
    // Load the todos from path
    final content = await files.read(path);
    if (content == null) return const Todos(values: []);

    // Transform it to json and then the todos list
    return Todos.fromJson(jsonDecode(content));
  }

  @override
  Future<Todo?> getTodoById(String id) async {
    final todos = await loadTodos();

    // Search the todo by id
    return todos.values.firstWhereOrNull((todo) => todo.id == id);
  }

  @override
  Future<void> saveTodo(Todo todo) async {
    final todos = await loadTodos();

    // Edit the todo if it exists
    final existing = todos.values.firstWhereOrNull((t) => t.id == todo.id);
    if (existing != null) {
      final newTodo = existing.copyWith(
        title: todo.title,
        description: todo.description,
        completed: todo.completed,
      );
      final newTodos = todos.values.map((t) {
        return t.id == todo.id ? newTodo : t;
      }).toList();
      await files.write(path, jsonEncode(Todos(values: newTodos).toJson()));
      return;
    } else {
      // Add the todo if it doesn't exist
      final newTodos = [...todos.values, todo];
      await files.write(path, jsonEncode(Todos(values: newTodos).toJson()));
    }
  }
}
