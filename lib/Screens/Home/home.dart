import 'package:flutter/material.dart';

import '../../Models/myFirebase.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        FutureBuilder(
          future: MyFirebase().fetchUsers(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            return Text("$snapshot");
          },
        ),
      ],
    ));
  }
}
