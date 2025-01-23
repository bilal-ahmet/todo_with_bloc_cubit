import 'package:isar/isar.dart';
import 'package:todo_with_bloc_cubit/data/models/isar_todo.dart';
import 'package:todo_with_bloc_cubit/domain/models/todo.dart';
import 'package:todo_with_bloc_cubit/domain/repository/todo_repo.dart';

class IsarTodoRepo implements TodoRepo {
  final Isar db;
  IsarTodoRepo(this.db);

  @override
  Future<void> addTodo(Todo newTodo) async{
    //  todo'ları isar todo'ya çevirme
    final todoIsar = TodoIsar.fromDomain(newTodo);

    //  böylece bunu isar veritabanımızda saklayabiliriz
    return db.writeTxn(() => db.todoIsars.put(todoIsar));
  }

  @override
  Future<void> deleteTodo(Todo todo) async{
    await db.writeTxn(() => db.todoIsars.delete(todo.id),);
  }

  @override
  Future<List<Todo>> getTodos() async {
    //  database'den veri yakalama
    final todos = await db.todoIsars.where().findAll();

    //  yapılacaklar listesi olarak geri dön ve etki alanı(domain) katmanına ver
    return todos.map((todoIsar) => todoIsar.toDomain()).toList();
  }

  @override
  Future<void> updateTodo(Todo todo) {
    //  todo'ları isar todo'ya çevirme
    final todoIsar = TodoIsar.fromDomain(todo);

    //  böylece bunu isar veritabanımızda saklayabiliriz
    return db.writeTxn(() => db.todoIsars.put(todoIsar));
  }
}
