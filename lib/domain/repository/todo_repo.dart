/*

  uygulamanın işlevselliğinin atandığı yerdir, her türlü işlem burada gerçekleşecek

*/


import 'package:todo_with_bloc_cubit/domain/models/todo.dart';

abstract class TodoRepo {

  //  liste gösterme işlemi
  Future<List<Todo>> getTodos();

  //  todo ekleme
  Future<void> addTodo(Todo newTodo);

  //  todo güncelleme
  Future<void> updateTodo(Todo todo);

  //  todo silme
  Future<void> deleteTodo(Todo todo); 
}