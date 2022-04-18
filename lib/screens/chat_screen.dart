import 'package:chat_lernapp/constants.dart';
import 'package:chat_lernapp/screens/start.dart';
import 'package:chat_lernapp/screens/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  static String id = 'chat_screen';

  const ChatScreen({Key? key}) : super(key: key);
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  void getCurrentUser() async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print(user.email);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    print(getCurrentUser);
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance
        .signOut()
        .then((value) => Navigator.pushNamed(context, Start.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.exit_to_app_outlined),
              onPressed: () async {
                await FirebaseAuth.instance.signOut().then((value) =>
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const Start())));
              }),
        ],
        title: const Text('⚡️Chat'),
        backgroundColor: Colors.grey.shade900,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        //Do something with the user input.
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      //Implement send functionality.
                    },
                    child: const Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
