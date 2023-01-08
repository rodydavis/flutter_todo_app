import '../model/todos.dart';

abstract class GetTodosUseCase {
  Future<Todos> execute();
}
