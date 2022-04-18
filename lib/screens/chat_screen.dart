import 'package:chat_lernapp/constants.dart';

import 'package:chat_lernapp/screens/welcome_screen.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  static String id = 'chat_screen';

  const ChatScreen({Key? key}) : super(key: key);
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String? messagesText;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? user = FirebaseAuth.instance.currentUser;
  String? loggedIn;

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

    messagesStream();
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance
        .signOut()
        .then((value) => Navigator.pushNamed(context, WelcomeScreen.id));
  }

  void messagesStream() async {
    await for (var snapshot in _firestore.collection('messages').snapshots()) {
      for (var message in snapshot.docs) {}
    }
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
                        builder: (context) => const WelcomeScreen())));
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
            StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('messages').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final messages = snapshot.data!.docs;
                    List<Text> messageWidgets = [];
                    for (var message in messages) {
                      final messageSenderText = message['text'];
                      final messageSender = message['sender'];
                      final messageWidget =
                          Text('$messageSender from: $messageSenderText');

                      messageWidgets.add(messageWidget);
                    }
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: messageWidgets.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(messageWidgets[index].data!),
                          );
                        });
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        messagesText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _firestore.collection('messages').add({
                        'text': messagesText,
                        'sender': user!.email,
                      });
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
