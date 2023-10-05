import 'package:flutter/material.dart';

import '../../Models/myFirebase.dart';
import '../Home/home.dart';
import '../SignUp/Signup.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  late AnimationController _controller;
  late Animation<Alignment> _topAlignmentAnimation;
  late Animation<Alignment> _bottomAlignmentAnimation;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 10));
    _topAlignmentAnimation = TweenSequence<Alignment>(
      [
        TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(
              begin: Alignment.topLeft, end: Alignment.topRight),
          weight: 1,
        ),
        TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(
              begin: Alignment.topRight, end: Alignment.bottomRight),
          weight: 1,
        ),
        TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(
              begin: Alignment.bottomRight, end: Alignment.bottomLeft),
          weight: 1,
        ),
        TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(
              begin: Alignment.bottomLeft, end: Alignment.topLeft),
          weight: 1,
        ),
      ],
    ).animate(_controller);
    _bottomAlignmentAnimation = TweenSequence<Alignment>(
      [
        TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(
              begin: Alignment.bottomLeft, end: Alignment.bottomRight),
          weight: 1,
        ),
        TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(
              begin: Alignment.bottomRight, end: Alignment.topRight),
          weight: 1,
        ),
        TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(
              begin: Alignment.topRight, end: Alignment.topLeft),
          weight: 1,
        ),
        TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(
              begin: Alignment.topLeft, end: Alignment.bottomLeft),
          weight: 1,
        ),
      ],
    ).animate(_controller);

    _controller.repeat();
  }

  @override
  dispose() {
    _controller.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            return Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: const [
                    Colors.purple,
                    Colors.blue,
                  ],
                  begin: _topAlignmentAnimation.value,
                  end: _bottomAlignmentAnimation.value,
                ),
              ),
              child: Column(
                children: [
                  Container(
                    height: 230,
                  ),
                  Container(
                    padding: EdgeInsets.all(50),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(90, 49, 49, 49),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 28,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 40.0),
                          child: Container(
                            width: 200,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, left: 8.0),
                              child: TextField(
                                controller: emailController,
                                decoration: InputDecoration(hintText: "E-mail"),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Container(
                            width: 200,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, left: 8.0),
                              child: TextField(
                                controller: passwordController,
                                decoration:
                                    InputDecoration(hintText: "Password"),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: FloatingActionButton.extended(
                            onPressed: () => {
                              showDialog(
                                  context: context,
                                  builder: ((context) => AlertDialog(
                                        content: FutureBuilder(
                                          future: MyFirebase().signIn(
                                              emailController.text,
                                              passwordController.text),
                                          builder: (context, snapshot) {
                                            if (snapshot.data ==
                                                "Sign-In Succesful") {
                                              Future.delayed(Duration.zero, () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const Home()));
                                                return Text(
                                                    "Signed in succesfully!");
                                              });
                                            } else if (snapshot.data ==
                                                "No user found for that email.") {
                                              Future.delayed(Duration.zero, () {
                                                return Text(
                                                    "No user found for that email.");
                                              });
                                            } else if (snapshot.data ==
                                                "Wrong password provided for that user.") {
                                              Future.delayed(Duration.zero, () {
                                                return Text(
                                                    "Wrong password provided for that user.");
                                              });
                                            } else {
                                              Future.delayed(Duration.zero, () {
                                                return Text("${snapshot.data}");
                                              });
                                            }
                                            return Text("${snapshot}");
                                          },
                                        ),
                                      )))
                            },
                            label: Text(
                              "Login",
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: ((context) => const Signup()),
                                ),
                              );
                            },
                            child: Text(
                              "Don't have an account? Sign-Up!",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
