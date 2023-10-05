import 'package:flutter/material.dart';

// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyFirebase {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<String> addUser(String name, String email, String password) async {
    try {
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
      } catch (e) {
        return "Returns an Exception $e";
      }
      users.add({
        'name': name,
        'email': email,
        'password': password,
      });

      return "User added";
    } catch (e) {
      return "Returns an Exception $e";
    }
  }
}
