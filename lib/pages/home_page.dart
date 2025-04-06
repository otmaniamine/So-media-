import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_app_firebase/auth/log_or_reg.dart';
import 'package:login_app_firebase/components/my_drawer.dart';
import 'package:login_app_firebase/firebase_options.dart';
import 'package:login_app_firebase/pages/login_page.dart';

class homePage extends StatelessWidget {
  const homePage({super.key});
  //logout function
  void logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      print('User signed out successfully');
    } catch (e) {
      print('Error signing out: $e');
    }
  }
  // Function to check if the user is logged in or not
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        backgroundColor: Colors.purple,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Sign out the user
              logout(); //FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => logORreg()),
              );
            },
          ),
        ],
      ),
      drawer: myDrawer(),
      body: Center(
        child: Text('Welcome to the Home Page!'),
      ),
    );
  }
}
