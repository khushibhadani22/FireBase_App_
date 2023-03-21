import 'package:flutter/material.dart';

import '../../helper/firebase_helper.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? email;
  String? password;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        padding: const EdgeInsets.all(15),
        alignment: Alignment.center,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              Color(0xff263961),
              Color(0xff3b4c70),
              Color(0xff516080),
            ])),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Image.asset(
                'assets/image/logo.png',
                color: Colors.white,
                width: 200,
              ),
              const SizedBox(
                height: 30,
              ),
              Form(
                key: signUpFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter your email first......";
                        }
                        return null;
                      },
                      onSaved: (val) {
                        setState(() {
                          email = emailController.text;
                        });
                      },
                      style: const TextStyle(color: Colors.white),
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Email",
                          labelText: "Email",
                          hintStyle: TextStyle(color: Colors.grey),
                          labelStyle: TextStyle(color: Colors.grey)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter your password first......";
                        }
                        return null;
                      },
                      onSaved: (val) {
                        setState(() {
                          password = passwordController.text;
                        });
                      },
                      style: const TextStyle(color: Colors.white),
                      obscureText: true,
                      controller: passwordController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(
                            Icons.remove_red_eye_rounded,
                            color: Colors.grey,
                          ),
                          hintText: "Password",
                          labelText: "Password",
                          hintStyle: TextStyle(color: Colors.grey),
                          labelStyle: TextStyle(color: Colors.grey)),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 145, vertical: 10)),
                  onPressed: () async {
                    if (signUpFormKey.currentState!.validate()) {
                      signUpFormKey.currentState!.save();

                      Map<String, dynamic> res = await FirebaseAuthHelper
                          .firebaseAuthHelper
                          .signUp(email: email!, password: password!);

                      if (res['user'] != null) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Sign Up Successful....."),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Color(0xff263961),
                        ));
                      } else if (res['error'] != null) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(res['error']),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Color(0xff263961),
                        ));
                      } else {
                        Navigator.of(context).pop();

                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Sign Up Failed....."),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Color(0xff263961),
                        ));
                      }
                      Navigator.of(context).pop();
                    }
                    setState(() {
                      emailController.clear();
                      passwordController.clear();
                      email = null;
                      password = null;
                    });
                  },
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  )),
            ],
          ),
        ),
      ),
    ));
  }
}
