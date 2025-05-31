import 'package:flutter/material.dart';
import '../services/firestore_service.dart';
import '../models/todo_model.dart';
import 'create_todo_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatelessWidget {
  final _firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My To-Dos'),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProfileScreen())),
          ),
        ],
      ),
      body: StreamBuilder<List<Todo>>(
        stream: _firestoreService.getTodos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());

          final todos = snapshot.data ?? [];
          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (_, i) {
              return ListTile(
                title: Text(todos[i].title),
                subtitle: Text(todos[i].description),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => CreateTodoScreen())),
      ),
    );
  }
}
