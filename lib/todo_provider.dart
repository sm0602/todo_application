// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Todo {
  final String id;
  final String title;
  bool isCompleted;

  Todo({
    required this.id,
    required this.title,
    this.isCompleted = false,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'isCompleted': isCompleted,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'] as String,
      title: map['title'] as String,
      isCompleted: map['isCompleted'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Todo.fromJson(String source) =>
      Todo.fromMap(json.decode(source) as Map<String, dynamic>);
}

class TodoProvider extends ChangeNotifier {
  final List<Todo> _tasks = [];
  final TextEditingController _newTaskTitle = TextEditingController();

  List<Todo> get tasks => _tasks;
  TextEditingController get newTaskTitle => _newTaskTitle;

  void addTodo(String title) {
    final newTodo =
        Todo(id: DateTime.now().toString(), title: title, isCompleted: false);
    _tasks.add(newTodo);
    notifyListeners();
  }

  void isTaskCompleted(String id) {
    final task = _tasks.firstWhere((task) => task.id == id);
    task.isCompleted = !task.isCompleted;
    notifyListeners();
  }

  void deleteTodo(String id) {
    _tasks.removeWhere((todo) => todo.id == id);
    notifyListeners();
  }

  Future<void> _saveTask() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonStringList =
        _tasks.map((todo) => jsonEncode(todo.toJson())).toList();
    await prefs.setStringList('todo_item', jsonStringList);
  }

  Future<void> _loadTodo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final toDoString = prefs.getString('todo_items');
    if (toDoString != null) {
      final jsonTodo = jsonDecode(toDoString);
    }
  }
}
