import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  addUser() {
    FirebaseFirestore.instance.collection('users').add({
      'name': 'User',
      'contact': '123354446',
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
