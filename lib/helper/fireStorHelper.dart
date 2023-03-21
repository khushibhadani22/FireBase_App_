import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreHelper {
  FireStoreHelper._();
  static final FireStoreHelper fireStoreHelper = FireStoreHelper._();

  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  CollectionReference? collectionReference;

  connectCollection() {
    collectionReference = fireStore.collection('user');
  }

  Future<void> addUser(
      {required String name,
      required String email,
      required int contact}) async {
    connectCollection();

    await collectionReference!
        .add({
          'name': name,
          'email': email,
          'contact': contact,
        })
        .then(
          (value) => print("user is add...."),
        )
        .catchError((error) => print("$error"));
  }

//TODO : getAllUser
  Stream<QuerySnapshot<Object?>> getUser() {
    connectCollection();

    return collectionReference!.snapshots();
  }

  //TODO : removeUser
  //TODO : editUser
  editUser({required String id, required String name}) async {}
}
