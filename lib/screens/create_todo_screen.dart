import 'package:flutter/material.dart';
import '../services/firestore_service.dart';
import '../models/todo_model.dart';

class CreateTodoScreen extends StatefulWidget {
  @override
  _CreateTodoScreenState createState() => _CreateTodoScreenState();
}

class _CreateTodoScreenState extends State<CreateTodoScreen> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _firestoreService = FirestoreService();

  void _saveTodo() async {
    final newTodo = Todo(
      id: '',
      title: _titleController.text,
      description: _descController.text,
    );
    await _firestoreService.addTodo(newTodo);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add To-Do')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: _titleController, decoration: InputDecoration(labelText: 'Title')),
            TextField(controller: _descController, decoration: InputDecoration(labelText: 'Description')),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _saveTodo, child: Text('Save')),
          ],
        ),
      ),
    );
  }
}
