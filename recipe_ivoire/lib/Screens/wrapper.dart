import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_recipee_app/Screens/HomePage.dart';
import 'package:flutter_recipee_app/welcome.dart';
import 'package:provider/src/provider.dart';

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    if (firebaseUser != null) {
      if (firebaseUser.emailVerified) {
        return MyHomePage();
      }
    }
    return LoginScreen();
  }
}
