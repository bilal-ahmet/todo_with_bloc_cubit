import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_with_bloc_cubit/domain/models/todo.dart';
import 'package:todo_with_bloc_cubit/domain/repository/todo_repo.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<List<Todo>> {
  final TodoRepo todoRepo;

  TodoCubit(this.todoRepo) : super([]){
    loadTodos();
  }

  //  todoları getirme
  Future<void> loadTodos() async{
    final todoList = await todoRepo.getTodos();
    emit(todoList);
  }

  //  todo ekleme
  Future<void> addTodo(String text) async{
    //  yeni ve benzersiz bir id ile todo ekleme
    final newTodo = Todo(id: DateTime.now().millisecond, text: text);

    //  eklenen yeni todoyu repoya kaydetme
    await todoRepo.addTodo(newTodo);

    // todoları tekrar yükleme
    loadTodos();
  }

  Future<void> deleteTodos(Todo todo) async{

    //  repodan getirilen todoların silinmesi
    await todoRepo.deleteTodo(todo);

    //  todoları tekrar yükleme
    loadTodos();
  }

  //  tamamlanmaları değiştirme
  Future<void> toggleCompletion(Todo todo) async{

    //  todoların tamamlanma durumunu değiştirme
    final updatedTodo = await todo.toggleCompliton();

    //  repoda todoları yeni durumları ile güncelleme güncelleme
    await todoRepo.updateTodo(updatedTodo);

    //  todoları tekrar yükleme
    loadTodos();
  }
}
