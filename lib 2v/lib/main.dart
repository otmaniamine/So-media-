import 'package:flutter/material.dart';
import 'package:login_app_firebase/auth/auth.dart';
import 'package:login_app_firebase/auth/log_or_reg.dart';
import 'package:login_app_firebase/firebase_options.dart';
import 'package:login_app_firebase/pages/home_page.dart';
import 'package:login_app_firebase/pages/login_page.dart';
import 'package:login_app_firebase/pages/profile_page.dart';
import 'package:login_app_firebase/pages/registerpage.dart';
import 'package:login_app_firebase/pages/users_page.dart';
import 'package:login_app_firebase/theme/light_mode.dart';
import 'package:login_app_firebase/theme/dark_mode.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options:DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    //  title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: lightMode,darkTheme: darkMode,
      themeMode: ThemeMode.system,
      home: authPage(),
      routes: {
        
        '/home': (context) =>  homePage(),
        '/users': (context) => const usersPage(),
        '/profile': (context) => profilePage(),
        '/logORreg': (context) => const logORreg(),

      },
    );
  } 
  
    }
      
//dart pub global activate flutterfire_cli
//flutterfire configure 
//flutter pub add firebase_core
//flutter pub add firebase_auth

//firestore
// flutter pub add cloud_firestore