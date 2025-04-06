import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_app_firebase/auth/log_or_reg.dart';
import 'package:login_app_firebase/firebase_options.dart';
import 'package:login_app_firebase/pages/home_page.dart';
import 'package:login_app_firebase/pages/login_page.dart';
class authPage extends StatelessWidget {
  const authPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return homePage();
          } else {
            return logORreg();
          }
        },
      ),
    );
  }
}