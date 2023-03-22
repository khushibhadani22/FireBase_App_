import 'package:app/helper/fireStorHelper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../helper/firebase_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  String? name;
  String? email;
  int? contact;

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
                      : Column(
                          children: [
                            Text(
                              "Name : ${user.displayName}",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
              (user.isAnonymous)
                  ? Container()
                  : Text(
                      "Email : ${user.email}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color(0xff516080)),
        title: const Text(
          "HOME PAGE",
          style:
              TextStyle(color: Color(0xff516080), fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              color: const Color(0xff516080),
              onPressed: () async {
                await FirebaseAuthHelper.firebaseAuthHelper.logOut();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('login', (route) => false);
              },
              icon: const Icon(Icons.power_settings_new))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: StreamBuilder(
          stream: FireStoreHelper.fireStoreHelper.getUser(),
          builder: (context, snapShot) {
            if (snapShot.hasError) {
              return Center(
                child: Text(
                  "ERROR :- ${snapShot.error}",
                  style: const TextStyle(color: Color(0xff516080)),
                ),
              );
            } else if (snapShot.hasData) {
              List data = snapShot.data!.docs;

              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    print(
                      data[index]['Name'],
                    );
                    return ExpansionTile(
                      title: Text(
                        data[index]['Name'],
                      ),
                      subtitle: Text(
                          "Email :- ${data[index]['Email']}\nContact:- ${data[index]['Contact']}"),
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xff516080)),
                              onPressed: () {},
                              label: const Text(
                                "Edit",
                                style: TextStyle(color: Colors.white),
                              ),
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                            ),
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xff516080)),
                              onPressed: () {
                                FireStoreHelper.fireStoreHelper
                                    .removeUser(id: data[index]['id']);
                              },
                              label: const Text(
                                "Delete",
                                style: TextStyle(color: Colors.white),
                              ),
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  });
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff516080),
        onPressed: () async {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Center(
                    child: Text(
                      "Add User",
                      style: TextStyle(
                          color: Color(0xff516080),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  content: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Enter Your Name.....";
                            }
                            return null;
                          },
                          onSaved: (val) {
                            name = val;
                          },
                          keyboardType: TextInputType.text,
                          style: const TextStyle(color: Color(0xff516080)),
                          decoration: const InputDecoration(
                              hintText: "Enter Your Name",
                              labelText: "Name",
                              hintStyle: TextStyle(color: Colors.grey),
                              labelStyle: TextStyle(color: Colors.grey),
                              border: OutlineInputBorder()),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Enter Your Email.....";
                            }
                            return null;
                          },
                          onSaved: (val) {
                            email = val;
                          },
                          keyboardType: TextInputType.emailAddress,
                          style: const TextStyle(color: Color(0xff516080)),
                          decoration: const InputDecoration(
                              hintText: "Enter Your Email",
                              labelText: "Email",
                              hintStyle: TextStyle(color: Colors.grey),
                              labelStyle: TextStyle(color: Colors.grey),
                              border: OutlineInputBorder()),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Enter Your contact number.....";
                            }
                            return null;
                          },
                          onSaved: (val) {
                            contact = int.parse(val!);
                          },
                          keyboardType: TextInputType.number,
                          style: const TextStyle(color: Color(0xff516080)),
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (val) async {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();

                              await FireStoreHelper.fireStoreHelper.addUser(
                                name: name!,
                                email: email!,
                                contact: contact!,
                              );
                              Navigator.of(context).pop();
                              nameController.clear();
                              emailController.clear();
                              contactController.clear();

                              setState(() {
                                name = null;
                                email = null;
                                contact = null;
                              });
                            }
                          },
                          decoration: const InputDecoration(
                              hintText: "Enter Your contact number",
                              labelText: "Contact",
                              hintStyle: TextStyle(color: Colors.grey),
                              labelStyle: TextStyle(color: Colors.grey),
                              border: OutlineInputBorder()),
                        ),
                      ],
                    ),
                  ),
                );
              });
        },
        child: const Icon(Icons.add),
      ),
    ));
  }
}
