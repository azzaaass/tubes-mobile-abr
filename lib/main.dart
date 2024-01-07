import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:idlix/firebase_options.dart';
import 'package:idlix/screen/home.dart';
import 'package:idlix/screen/login.dart';
import 'package:idlix/screen/register.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp((MaterialApp(
    home: Login(),
  )));
}
