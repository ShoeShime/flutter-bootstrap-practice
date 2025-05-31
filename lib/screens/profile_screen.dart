import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class ProfileScreen extends StatelessWidget {
  final _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Profile')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await _auth.signOut();
            Navigator.pop(context);
          },
          child: Text('Sign Out'),
        ),
      ),
    );
  }
}
