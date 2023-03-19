import 'package:app/view/screens/LoginPage.dart';
import 'package:app/view/screens/homePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    theme: ThemeData(useMaterial3: true),
    initialRoute: 'login',
    routes: {
      '/': (context) => const HomePage(),
      'login': (context) => const LoginPage(),
    },
  ));
}
