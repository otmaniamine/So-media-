import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_app_firebase/auth/log_or_reg.dart';

class profilePage extends StatelessWidget {
  profilePage({super.key});

  //creat logged in user 
  final User? currentUser = FirebaseAuth.instance.currentUser;
  //future to fetch user details from firebase
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails() async {
    if (currentUser == null) throw Exception("User not logged in");
    
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.uid)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*
      appBar: AppBar(
        title: const Text('Profile Page'),
        backgroundColor: Theme.of(context).colorScheme.background,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              try {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const logORreg()),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error signing out: $e')),
                );
              }
            },
          ),
        ],
      ),
      */
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: getUserDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text('User data not found'));
          }

          final user = snapshot.data!.data()!;
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //profile pic
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color:Theme.of(context).colorScheme.primary ,
                      
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(user['profilePic'] ?? 'https://plus.unsplash.com/premium_photo-1689568126014-06fea9d5d341?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Text('Name: ${user['userName'] ?? 'Not set'}'),
                  const SizedBox(height: 8),
                  Text('Email: ${user['email'] ?? 'Not set'}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}