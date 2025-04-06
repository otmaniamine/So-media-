import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:login_app_firebase/Helper/helperFunction.dart';
import 'package:login_app_firebase/components/mybutton.dart';
import 'package:login_app_firebase/components/mytextfield.dart';
class loginPage extends StatefulWidget {
  final void Function()? onTape;
  loginPage({super.key,required this.onTape});

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  //text controler 
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  //login methode 
  void login()async{
    //show loading circle
    showDialog(context: context, builder:(context)=>  Center(child:CircularProgressIndicator()));
    //try to login user  
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      //pop loading circle 
      if(context.mounted) Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      displayMessageToUser(e.toString(), context);
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
            Icon(Icons.person, size: 100, color: Theme.of(context).colorScheme.inversePrimary),
            SizedBox(height: 20),
            //app name 
            Text(
              'Login - P A G E',style: TextStyle(fontSize: 20),),
            SizedBox(height: 20),
            //email textfeild
            myTextField(hintText: "E-mail", obscureText: false, controller: emailController),
    
            SizedBox(height: 20),
            //password textfeild
            myTextField(hintText: "Password", obscureText: true, controller: passwordController),
            SizedBox(height: 20),
          
            SizedBox(height: 20),
            //signup button
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('Forget Password ?',style: TextStyle(color: Theme.of(context).colorScheme.secondary),),
                SizedBox(width: 10),  
              ],
            ),
    
            //login button
            myButton(text: 'Login', onTap: login),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Dont have an account ?',style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),),
    
                GestureDetector(
                  onTap: widget.onTape,
                  child: Text("Register Here",style: TextStyle(fontWeight: FontWeight.bold,))),]
            ),
    
            
    
            
          ],
        ),
      ),
      );


  }
}