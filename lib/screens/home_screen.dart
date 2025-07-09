import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/todo.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Box<Todo> todoBox;
  final TextEditingController _taskController = TextEditingController();

  @override
  void initState() {
    super.initState();
    todoBox = Hive.box<Todo>('todos'); // Get the opened box
  }

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }

  void _addTodo() {
    if (_taskController.text.isNotEmpty) {
      final newTodo = Todo(title: _taskController.text);
      todoBox.add(newTodo); // Add the new todo to the box
      _taskController.clear();
    }
  }

  void _toggleTodoStatus(int index, Todo todo) {
    todo.isCompleted = !todo.isCompleted;
    todo.save(); // Save the changes to the Hive object
  }

  void _deleteTodo(int index) {
    todoBox.deleteAt(index); // Delete the todo at the specified index
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List', style: GoogleFonts.poppins(fontWeight: FontWeight.w500),),
        centerTitle: true, actions: [
        // --- NEW WIDGET: Dotted Menu (PopupMenuButton) ---
        PopupMenuButton<String>(
          icon: const Icon(Icons.more_vert), // The dotted menu icon
          onSelected: (String result) {
            if (result == 'clear_all') {
              todoBox.clear(); // Clear all entries from the box
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('All tasks cleared!')),
                );
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            PopupMenuItem<String>(
              value: 'clear_all',
              child: Row(
                children: [
                  const Icon(Icons.delete_forever, color: Colors.red),
                  const SizedBox(width: 8),
                  Text('Clear All Tasks', style: GoogleFonts.poppins()), // Apply font here too
                ],
              ),
            ),
            // You can add more menu items here if needed in the future
          ],
        ),
      ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _taskController,
              decoration: InputDecoration(
                labelText: 'New Task',
                hintStyle:GoogleFonts.poppins(fontWeight: FontWeight.w400),
                suffixStyle: GoogleFonts.poppins(fontWeight: FontWeight.w400),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _addTodo,
                ),
                border: const OutlineInputBorder(),
              ),
              onSubmitted: (_) => _addTodo(),
            ),
          ),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: todoBox.listenable(), // Listen for changes in the box
              builder: (context, Box<Todo> box, _) {
                if (box.isEmpty) {
                  return  Center(
                    child: Text('No tasks yet! Add one.',style:GoogleFonts.poppins(fontWeight: FontWeight.w300),),
                  );
                }
                return ListView.builder(
                  itemCount: box.length,
                  itemBuilder: (context, index) {
                    final todo = box.getAt(index)!; // Get todo by index
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                      elevation: 2.0,
                      child: ListTile(
                        title: Text(
                          todo.title,
                          style: TextStyle(
                            decoration: todo.isCompleted
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                            color: todo.isCompleted ? Colors.grey : Colors.black,
                          ),
                        ),
                        leading: Checkbox(
                          value: todo.isCompleted,
                          onChanged: (bool? value) {
                            _toggleTodoStatus(index, todo);
                          },
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_outline, color: Colors.grey),
                          onPressed: () => _deleteTodo(index),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}