import 'package:cloud_firestore/cloud_firestore.dart';
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
        backgroundColor:Theme.of(context).colorScheme.inversePrimary ,
        elevation:0,
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
      backgroundColor:Theme.of(context).colorScheme.background ,
      body: StreamBuilder(
        // Replace with your stream of user data
        stream: FirebaseFirestore.instance.collection("users").snapshots(), // Replace with your stream of user data
        builder: (context, snapshot){
          //any errors
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          //show loading circle 
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if(snapshot.data==null){
            return const Center(child: Text('No users found'));
          }
          //get all users
          final users = snapshot.data!.docs;
          //show all users in a list view
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index].data() as Map<String, dynamic>;
              return ListTile(
                title: Text(user['userName'] ?? 'No name'),
                subtitle: Text(user['email'] ?? 'No email'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    // Delete user logic here
                    FirebaseFirestore.instance.collection("users").doc(users[index].id).delete();
                  },
                ),
              );
            },
          );

        }
      ),
    );
  }
}