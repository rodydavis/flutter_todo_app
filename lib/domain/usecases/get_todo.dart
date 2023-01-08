import '../model/todo.dart';

abstract class GetTodoUseCase {
  Future<Todo?> execute(String id);
}
