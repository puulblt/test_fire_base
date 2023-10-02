import 'package:flutter/material.dart';
import 'package:test_fire_base/Pages/loginPage.dart';
import 'package:test_fire_base/Pages/acceuilPage.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';
import 'package:permission_handler/permission_handler.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const MaterialApp(
            home: AcceuilPage(),
          );
        } else {
          return const MaterialApp(
            home: loginPage(),
          );
        }
      },
    );
  }
}