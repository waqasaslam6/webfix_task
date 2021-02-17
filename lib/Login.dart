import 'package:flutter/material.dart';
import 'package:webfix_task/Authentication.dart';
import 'package:provider/provider.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WebFix Task"),
      ),
      body: Center(
        child: MaterialButton(
          shape: StadiumBorder(),
          color: Color(0xff1198f6),
          textColor: Colors.white,
          child: Text("login with facebook".toUpperCase()),
          onPressed: context.read<AuthenticationProvider>().signInWithFacebook
        ),
      ),
    );
  }
}

