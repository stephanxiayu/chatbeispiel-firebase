import 'package:chat_lernapp/Button/button.dart';
import 'package:chat_lernapp/screens/chat_screen.dart';
import 'package:chat_lernapp/Button/customer_textfield.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';

  const LoginScreen({Key? key}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Hero(
              tag: 'logo',
              child: Container(
                height: 200.0,
                child: Image.asset('images/log1.png'),
              ),
            ),
            const SizedBox(
              height: 48.0,
            ),
            CustomerTextField(
              onChanged: (value) {},
              hintText: '.....Enter your email',
            ),
            const SizedBox(
              height: 8.0,
            ),
            CustomerTextField(
              onChanged: (value) {},
              hintText: '......passwort',
            ),
            const SizedBox(
              height: 24.0,
            ),
            RoundedButton(
                title: "Login",
                color: Colors.amber,
                onPressed: () {
                  Navigator.pushNamed(context, ChatScreen.id);
                }),
          ],
        ),
      ),
    );
  }
}
