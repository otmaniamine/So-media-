import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:login_app_firebase/auth/log_or_reg.dart';
import 'package:login_app_firebase/components/my_drawer.dart';
import 'package:login_app_firebase/components/mypostbutton.dart';
import 'package:login_app_firebase/components/mytextfield.dart';
import 'package:login_app_firebase/database/firestore.dart';


class homePage extends StatelessWidget {
  homePage({super.key});
  //fire store access
  final FirestoreDatabase database = FirestoreDatabase();

  //post message
  void postMessage() {
    //only post messGE IF THERE   is something in the textfield
    if (newcontroller.text.isNotEmpty) {
      String message = newcontroller.text;
      database.addPost(message);
      //clear the text field
      newcontroller.clear();
    }
  }

  //controller for text field
  final TextEditingController newcontroller = TextEditingController();
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
        title: const Text('H O M E'),
        backgroundColor: Colors.transparent,
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
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                    child: myTextField(
                        hintText: "say somthing ",
                        obscureText: false,
                        controller: newcontroller)),
                const SizedBox(
                  width: 10,
                ),
                //post button
                postButton(onTap: postMessage)
              ],
            ),
          ),
          //show all posts in a list view
          Expanded(
            child: StreamBuilder(
              stream: database.getPostsStream(),
              builder: (context, snapshot) {
                //show loading circle
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } 

                //get all posts 
                final posts = snapshot.data!.docs;
                //no data
                if (snapshot.data==null || posts.isEmpty) {
                  return const Center(child: Text('No posts found'));
                }
                //return as a list
                return Expanded(
                  child: ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      // get aecj individua; post 
                      final post = posts[index];
                      //get data from each post 
                      String message = post['postMessage'] ?? 'No message';
                      String email = post['email'] ?? 'No email';
                      Timestamp timestamp = post['timestamp'] ?? Timestamp.now();

                      return ListTile(
                        title: Text(message),
                        subtitle: Text(email),
                        );
                    },
                  ),
                );

              },
            ),
          )
        ],
      )),
    );
  }
}
