import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:idlix/screen/login.dart';
import 'package:idlix/style/style.dart';

class Setting extends StatelessWidget {
  Setting({super.key});
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              navy,
              dark,
            ])),
        child: SafeArea(
            child: Column(
          children: [
            InkWell(
                onTap: () {
                  auth.signOut();
                  Navigator.pushReplacement(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => Login(),
                      ));
                },
                child: const Text("Logout", style: TextStyle(color: white),))
          ],
        )),
      ),
    );
  }
}
