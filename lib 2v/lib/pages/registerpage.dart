import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:login_app_firebase/Helper/helperFunction.dart';
import 'package:login_app_firebase/components/mybutton.dart';
import 'package:login_app_firebase/components/mytextfield.dart';

class registerPage extends StatefulWidget {
  //finctions
  final void Function()? onTape;

  registerPage({super.key, required this.onTape});

  @override
  State<registerPage> createState() => _registerPageState();
}

class _registerPageState extends State<registerPage> {
  //text controler
  TextEditingController emailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  //register  methode
  Future<void> registerUser() async {
    //show loading circle
    showDialog(
        context: context,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));

    // make sure passwords match
    if (passwordController.text != confirmPasswordController.text) {
      Navigator.pop(context);
      displayMessageToUser('password dont match', context);
    }
    //try creating a user
    else {
      try {
        //create user
        UserCredential? userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);
        //create user document in the database
        createUserDocument(userCredential);
        //Navigator.pop(context);
        if (context.mounted) {
          Navigator.pop(context);
        }
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);
        displayMessageToUser(e.toString(), context);
      }
    }
  }

  //creat a user document and collect theme in firebase
  Future<void> createUserDocument(UserCredential? userCredential) async {
    //get the current user : User? user = FirebaseAuth.instance.currentUser;
    //create a user document in the database
    if (userCredential != null && userCredential.user != null) {
      await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid)
      .set({
        'userName': userNameController.text,
        'email': emailController.text,
        'password': passwordController.text,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person,
                size: 100, color: Theme.of(context).colorScheme.inversePrimary),
            SizedBox(height: 20),
            //app name
            Text(
              'Register',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            //user  textfeild
            myTextField(
                hintText: "User Name",
                obscureText: false,
                controller: userNameController),

            SizedBox(height: 12),
            myTextField(
                hintText: "E-mail",
                obscureText: false,
                controller: emailController),

            SizedBox(height: 12),
            //password textfeild
            myTextField(
                hintText: "Password",
                obscureText: true,
                controller: passwordController),
            SizedBox(height: 12),
            myTextField(
                hintText: "Confirme Password",
                obscureText: true,
                controller: confirmPasswordController),
            SizedBox(height: 12),

            SizedBox(height: 20),
            //signup button
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Forget Password ?',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.secondary),
                ),
                SizedBox(width: 10),
              ],
            ),

            //login button
            myButton(text: 'Register ', onTap: registerUser),
            SizedBox(height: 12),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                'Alredy have an account ?',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary),
              ),
              GestureDetector(
                  onTap: widget.onTape,
                  child: Text("Login Here",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ))),
            ]),
          ],
        ),
      ),
    );
  }
}
