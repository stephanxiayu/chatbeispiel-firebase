import 'package:chat_lernapp/screens/chat_screen.dart';
import 'package:chat_lernapp/screens/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Start extends StatefulWidget {
  const Start({Key? key}) : super(key: key);
  static String id = 'start';

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.amber,
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.active) {
            return const ChatScreen();
          } else if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          }

          return const WelcomeScreen();
        });
  }
}
