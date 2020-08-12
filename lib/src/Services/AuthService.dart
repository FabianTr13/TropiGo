import 'package:TropiGo/src/Modules/Auth/Models/AuthRequest.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  Future<AuthRequest> createUser({String email, String password}) async {
    AuthRequest authRequest = AuthRequest();
    try {
      var user = await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => value.user);

      authRequest.success = user != null;
      await loginUser(email: email, password: password);
    } catch (e) {
      _mapErrorMessage(authRequest, e.code);
    }
    return authRequest;
  }

  Future<FirebaseUser> getCurrentUser() async {
    try {
      return await _auth.currentUser();
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<AuthRequest> loginUser({String email, String password}) async {
    AuthRequest authRequest = AuthRequest();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await singOut();
    try {
      var user = await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) => value.user);

      authRequest.success = user != null;
      await prefs.setString('email', user.email);
      await prefs.setString('password', password);
    } catch (e) {
      _mapErrorMessage(authRequest, e.code);
    }
    return authRequest;
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

  Future<AuthRequest> resignApp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    AuthRequest authRequest = AuthRequest();

    // await prefs.setString("email", "pruebas@prueba.com");
    // await prefs.setString("password", "patitro");
    String email = (prefs.getString('email') ?? null);
    String password = (prefs.getString('password') ?? null);

    if (email != null && password != null) {
      authRequest =
          await AuthService().loginUser(email: email, password: password);
    }
    return authRequest;
  }

  void _mapErrorMessage(AuthRequest authRequest, String code) {
    switch (code) {
      case 'ERROR_USER_NOT_FOUND':
        authRequest.errorMessage = "Usuario no encontrado";
        break;
      case 'ERROR_WRONG_PASSWORD':
        authRequest.errorMessage = "Contraseña invalida";
        break;
      case 'ERROR_NETWORK_REQUEST_FAILED':
        authRequest.errorMessage = "Error de conexion";
        break;
      case 'ERROR_EMAIL_ALREADY_IN_USE':
        authRequest.errorMessage = "El usuario ya esta registrado";
        break;
      case 'ERROR_INVALID_EMAIL':
        authRequest.errorMessage = "Correo invalido";
        break;
      default:
        authRequest.errorMessage = code;
    }
    authRequest.showErrorMessage = true;
  }
}
