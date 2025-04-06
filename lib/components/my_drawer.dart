import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_app_firebase/auth/log_or_reg.dart';
import 'package:login_app_firebase/firebase_options.dart';
import 'package:login_app_firebase/pages/login_page.dart';
import 'package:login_app_firebase/theme/light_mode.dart';
import 'package:login_app_firebase/theme/dark_mode.dart';
class myDrawer extends StatelessWidget {
  const myDrawer({super.key});
  void logout(){
    FirebaseAuth.instance.signOut();}

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        
        children: [
          Column(children: [
            DrawerHeader(child: Icon(Icons.account_circle, size: 100, color: Theme.of(context).colorScheme.inversePrimary)),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: ListTile(
              leading: Icon(Icons.home,color: Theme.of(context).colorScheme.inversePrimary,),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: ListTile(
              leading: Icon(Icons.person_2,color: Theme.of(context).colorScheme.inversePrimary,),
              title: Text('Profile'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                //navigate to profile page
                Navigator.pushNamed(context, '/profile');
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: ListTile(
              leading: Icon(Icons.group,color: Theme.of(context).colorScheme.inversePrimary,),
              title: Text('Users'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                //navigate to users page
                Navigator.pushNamed(context, '/users');
              },
            ),
          ),

          ],
          ),

          Padding(
            padding: const EdgeInsets.only(left: 16.0,bottom: 25.0),
            child: ListTile(
              leading: Icon(Icons.logout,color: Theme.of(context).colorScheme.inversePrimary,),
              title: Text('LogOut'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                // Sign out the user
                logout(); //FirebaseAuth.instance.signOut();
              },
            ),
          ),
        ],
      )
    );
  }
}