import 'package:flutter/material.dart';

class TodoProvider with ChangeNotifier {
  final List<Map<String, dynamic>> _todos = [];

  List<Map<String, dynamic>> get todos => _todos;

  void addTodo(String task) {
    if (task.trim().isEmpty) return;
    _todos.add({"task": task.trim(), "done": false});
    notifyListeners();
  }

  void toggleDone(int index) {
    _todos[index]["done"] = !_todos[index]["done"];
    notifyListeners();
  }
}
