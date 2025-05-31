import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/todo_model.dart';

class FirestoreService {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  Stream<List<Todo>> getTodos() {
    final userId = _auth.currentUser?.uid;
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('todos')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => Todo.fromMap(doc.data(), doc.id))
        .toList());
  }

  Future<void> addTodo(Todo todo) async {
    final userId = _auth.currentUser?.uid;
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('todos')
        .add({
      'title': todo.title,
      'description': todo.description,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}
