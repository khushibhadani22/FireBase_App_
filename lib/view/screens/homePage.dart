import 'package:firebase_auth/firebase_auth.dart';
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
    User user = ModalRoute.of(context)!.settings.arguments as User;

    return SafeArea(
        child: Scaffold(
            drawer: Drawer(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    (user.photoURL != null)
                        ? CircleAvatar(
                            radius: 80,
                            foregroundImage: (user.photoURL != null)
                                ? NetworkImage(user.photoURL as String)
                                : null)
                        : const CircleAvatar(
                            backgroundColor: Colors.grey,
                            radius: 80,
                            child: Icon(
                              Icons.person,
                              size: 130,
                              color: Colors.white,
                            ),
                          ),
                    const SizedBox(
                      height: 20,
                    ),
                    (user.isAnonymous)
                        ? const Text(
                            "GUEST MODE",
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          )
                        : (user.displayName == null)
                            ? Container()
                            : Text("Name : ${user.displayName}"),
                    (user.isAnonymous)
                        ? Container()
                        : Text("Email : ${user.email}"),
                  ],
                ),
              ),
            ),
            appBar: AppBar(
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
