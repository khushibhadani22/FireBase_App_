import 'package:flutter/material.dart';

import '../../helper/firebase_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              leading: Container(),
              title: const Text("HOME PAGE"),
              centerTitle: true,
              actions: [
                IconButton(
                    onPressed: () async {
                      await FirebaseAuthHelper.firebaseAuthHelper.logOut();
                      Navigator.of(context)
                          .pushNamedAndRemoveUntil('login', (route) => false);
                    },
                    icon: const Icon(Icons.power_settings_new))
              ],
            ),
            body: Container()));
  }
}