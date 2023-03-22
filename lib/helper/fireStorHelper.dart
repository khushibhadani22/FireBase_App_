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
          'Name': name,
          'Email': email,
          'Contact': contact,
        })
        .then(
          (value) => print("user is add...."),
        )
        .catchError((error) => print("$error"));
  }

  Stream<QuerySnapshot<Object?>> getUser() {
    connectCollection();

    return collectionReference!.snapshots();
  }

  removeUser({required String id}) {
    connectCollection();

    collectionReference!
        .doc(id)
        .delete()
        .then((value) => print("user delete.."))
        .catchError((error) {
      print(error);
    });
  }

  editUser({required String id, required Map<Object, Object> data}) {
    connectCollection();

    collectionReference!
        .doc(id)
        .update(data)
        .then((value) => print("User Edit..."))
        .catchError((error) => print(error));
  }
}
