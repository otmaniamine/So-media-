import 'package:flutter/material.dart';
import 'package:login_app_firebase/auth/log_or_reg.dart';
import 'package:login_app_firebase/firebase_options.dart';
import 'package:login_app_firebase/pages/login_page.dart';
class usersPage extends StatelessWidget {
  const usersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users Page'),
        backgroundColor: Colors.purple,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Sign out the user
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => logORreg()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Text('Welcome to the Users Page!'),
      ),
    );
  }
}