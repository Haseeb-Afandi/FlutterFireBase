import 'package:flutter/material.dart';

// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyFirebase {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<String> addUser(String name, String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then(((value) => {
                FirebaseFirestore.instance
                    .collection('users')
                    .doc(value.user!.uid)
                    .set({
                  "email": email,
                  "name": name,
                  "password": password,
                })
              }));

      return "User added";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      } else {
        return "Returns an Exception $e";
      }
    }
  }

  Future<String> signIn(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      return "Sign-In Succesful";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      } else {
        return "There was an Exception: \n $e";
      }
    }
  }

  Future<String> fetchUsers() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance.collection("users").get();
    final data = querySnapshot.docs.toList().toString();

    return data;
  }
}
