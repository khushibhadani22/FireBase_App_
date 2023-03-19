import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthHelper {
  FirebaseAuthHelper._();
  static final FirebaseAuthHelper firebaseAuthHelper = FirebaseAuthHelper._();

  static final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static final GoogleSignIn googleSignIn = GoogleSignIn();

  //TODO : logInWithAnonymously()

  Future<User?> logInWithAnonymously() async {
    UserCredential userCredential = await firebaseAuth.signInAnonymously();

    User? user = userCredential.user;

    return user;
  }

  //TODO : SignUP()
  Future<User?> signUp(
      {required String email, required String password}) async {
    UserCredential userCredential = await firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);
    User? user = userCredential.user;
    return user;
  }

  //TODO : SignIn()

  Future<User?> signIn(
      {required String email, required String password}) async {
    UserCredential userCredential = await firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);
    User? user = userCredential.user;
    return user;
  }

  // Future<Map<String,dynamic>> signIn(
  //      {required String email, required String password}) async {
  //    Map<String,dynamic> res ={};
  //    try {
  //
  //      UserCredential userCredential = await firebaseAuth
  //          .signInWithEmailAndPassword(email: email, password: password);
  //      User? user = userCredential.user;
  //      res['user'] = user;
  //    } on FirebaseAuthException catch (e){
  //      print ("===================");
  //      print(e.code);
  //      print ("===================");
  //
  //      switch (e.code){
  //        case "wrong-password" :
  //          res['error'] = "password is wrong....";
  //          break;
  //        case "operation-not-allowed" :
  //          res['error'] = "Sign In method is disabled....";
  //          break;
  //          case "user-disabled" :
  //        res['error'] = "You are blocked....";
  //        break;
  //      }
  //    }
  //  }

  //TODO : SignInWithGoogle()

  Future<User?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    UserCredential userCredential =
        await firebaseAuth.signInWithCredential(credential);

    User? user = userCredential.user;
    return user;
  }

  //TODO : logOut()

  Future<void> logOut() async {
    await firebaseAuth.signOut();
    await googleSignIn.signOut();
  }
}
