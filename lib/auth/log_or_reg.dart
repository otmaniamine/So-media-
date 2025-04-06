import 'package:flutter/material.dart';
import 'package:login_app_firebase/pages/login_page.dart';
import 'package:login_app_firebase/pages/registerpage.dart';
class logORreg extends StatefulWidget {
  const logORreg({super.key});

  @override
  State<logORreg> createState() => _logORregState();
}

class _logORregState extends State<logORreg> {
  //initially show page 
  bool showLoginPage=true;
  //toggle 
  void togglePage() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(showLoginPage) {
      return loginPage(onTape: togglePage);
    } else {
      return registerPage(onTape: togglePage);
    }
  }
}
