import '../repository/todos.dart';
import 'delete_todo.dart';

class DeleteTodoUseCaseImpl extends DeleteTodoUseCase {
  DeleteTodoUseCaseImpl(this.todosRepository);
  final TodosRepository todosRepository;

  @override
  Future<void> execute(String id) async {
    await todosRepository.deleteTodo(id);
  }
}
