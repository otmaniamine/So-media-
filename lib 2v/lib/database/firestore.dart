/*
this DB store that users have published in the app 
it is stored in a collection called 'posts'in firebase 
each post contain :
-a message 
-email of users 
-timestamp
 */
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class FirestoreDatabase{
  //current user
  final User? user = FirebaseAuth.instance.currentUser;
  //get collection of posts from firestore
  final CollectionReference posts = FirebaseFirestore.instance.collection('posts');
  //post a message 
  Future<void> addPost(String message) {
    
    //create a new post
    return posts.add({
      'postMessage': message,
      'email': user!.email,
      'timestamp': Timestamp.now(),
    });
  }
  //read posts from database
  Stream<QuerySnapshot> getPostsStream() {
    final postStream = FirebaseFirestore.instance.collection('posts').orderBy('timestamp',descending: true).snapshots();
    return postStream;
  }
}