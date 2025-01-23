import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_with_bloc_cubit/data/models/isar_todo.dart';
import 'package:todo_with_bloc_cubit/data/repositoy/isar_todo_repo.dart';
import 'package:todo_with_bloc_cubit/domain/repository/todo_repo.dart';
import 'package:todo_with_bloc_cubit/presentation/todo_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // veri depolamak için dizin yolunu al
  final dir = await getApplicationDocumentsDirectory();

  //  isar veri tabanını aç
  final isar = await Isar.open([TodoIsarSchema], directory: dir.path);

  //  isar veri tabanı ile repoyu başlat
  final isarTodoRepo = IsarTodoRepo(isar);

  runApp(MyApp(
    todorepo: isarTodoRepo,
  ));
}

class MyApp extends StatelessWidget {
  final TodoRepo todorepo;

  const MyApp({super.key, required this.todorepo});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false, home: TodoPage(todorepo: todorepo));
  }
}
