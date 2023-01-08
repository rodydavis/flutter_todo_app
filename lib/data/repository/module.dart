import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/repository/todos.dart';
import '../source/module.dart';
import 'todos_impl.dart';

final todosProvider = Provider<TodosRepository>((ref) {
  return TodosRepositoryImpl(ref.read(filesProvider));
});
