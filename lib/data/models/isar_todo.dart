
import 'package:isar/isar.dart';
import 'package:todo_with_bloc_cubit/domain/models/todo.dart';

part 'isar_todo.g.dart';

@collection
class TodoIsar{
  Id id = Isar.autoIncrement;
  late String text;
  late bool isCompleted;


  //  isar nesnesini dönüştür - uygulamamızda kullanmak için saf todo nesnesi
  Todo toDomain(){
    return Todo(id: id, text: text, isCompleted: isCompleted);
  }

  //  saf todo nesnesini dönüştür - isar veritabanında saklanacak isar nesnesi
  static TodoIsar fromDomain(Todo todo){
    return TodoIsar()
    ..id = todo.id
    ..text = todo.text
    ..isCompleted = todo.isCompleted;
  }
}