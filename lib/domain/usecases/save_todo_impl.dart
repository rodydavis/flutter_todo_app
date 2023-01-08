import '../model/todo.dart';
import '../repository/todos.dart';
import 'save_todo.dart';

class SaveTodoUseCaseImpl extends SaveTodoUseCase {
  SaveTodoUseCaseImpl(this.todosRepository);
  final TodosRepository todosRepository;

  @override
  Future<void> execute(Todo todo) async {
    await todosRepository.saveTodo(todo);
  }
}
