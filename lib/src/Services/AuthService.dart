import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  Future<FirebaseUser> createUser({String email, String password}) async {
    try {
      var user = await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => value.user);
      await loginUser(email: email, password: password);
      return user;
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<FirebaseUser> getCurrentUser() async {
    try {
      return await _auth.currentUser();
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<FirebaseUser> loginUser({String email, String password}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await singOut();
    try {
      var user = await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) => value.user);

      await prefs.setString('email', user.email);
      await prefs.setString('password', password);
      return user;
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<void> singOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final user = await _auth.signOut();
      await prefs.clear();
      return user;
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future resignApp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = (prefs.getString('email') ?? null);
    String password = (prefs.getString('password') ?? null);

    if (email != null && password != null) {
      var user =
          await AuthService().loginUser(email: email, password: password);

      return user != null ? "OK" : "Denied";
    }
  }
}
