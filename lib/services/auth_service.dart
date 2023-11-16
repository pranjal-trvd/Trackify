import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trackify/screens/dashboard.dart';
import 'package:trackify/services/db.dart';

class AuthService {
  var db = Db();
  createUser(data, context) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: data['email'],
        password: data['password'],
      );
      await db.addUser(data, context);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Dashboard()),
        (Route<dynamic> route) => false,
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Signup Failed"),
            content: Text(e.toString()),
          );
        },
      );
    }
  }

  userLogin(data, context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: data['email'],
        password: data['password'],
      );
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Dashboard()),
        (Route<dynamic> route) => false,
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Login Failed"),
            content: Text(e.toString()),
          );
        },
      );
    }
  }
}
