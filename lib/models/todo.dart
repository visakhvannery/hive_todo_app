import 'package:hive/hive.dart';

part 'todo.g.dart'; // This file will be generated

@HiveType(typeId: 0) // Unique ID for this type adapter
class Todo extends HiveObject {
  @HiveField(0)
  late String title;

  @HiveField(1)
  late bool isCompleted;

  Todo({required this.title, this.isCompleted = false});
}