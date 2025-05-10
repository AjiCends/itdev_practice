import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_2/models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user object based on firebase user
  UserModel? _userFromFirebaseUser(User? user) {
    return user != null ? UserModel(uid: user.uid) : null;
  }

  // auth change users stream
  Stream<UserModel?> get user {
    return _auth.authStateChanges()
    // .map((User? user) => _userFromFirebaseUser(user));
    // kode di bawah sama dengan kode diatas
    .map(_userFromFirebaseUser);
  }

  // sign in anonimous
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? result_user = result.user;

      return _userFromFirebaseUser(result_user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email and password
  Future signInWithEmail(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? result_user = result.user;
      return _userFromFirebaseUser(result_user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // register with email and password
  Future registerWithEmail(dynamic data) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: data['email'],
        password: data['password'],
      );

      User? result_user = result.user;

      // await UserService(uid: result_user!.uid).updateUserData(data['name']);

      return _userFromFirebaseUser(result_user);
    } catch (e) {
      print('Error .....');
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
