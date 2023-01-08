import 'package:flutter_todo_app/domain/model/todos.dart';

import '../repository/todos.dart';
import 'get_todos.dart';

class GetTodosUseCaseImpl extends GetTodosUseCase {
  GetTodosUseCaseImpl(this.todosRepository);
  final TodosRepository todosRepository;

  @override
  Future<Todos> execute() => todosRepository.loadTodos();
}
