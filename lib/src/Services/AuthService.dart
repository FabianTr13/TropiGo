import 'package:TropiGo/src/Modules/Auth/Bloc/AuthBloc.dart';
import 'package:TropiGo/src/Modules/Auth/Bloc/ModelsBloc.dart/Login.dart';
import 'package:TropiGo/src/Modules/Auth/Bloc/ModelsBloc.dart/Signup.dart';
import 'package:TropiGo/src/Modules/Auth/Bloc/SignupBloc.dart';
import 'package:TropiGo/src/Modules/Auth/Models/AuthRequest.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  Future<AuthRequest> createUser() async {
    AuthRequest authRequest = AuthRequest();
    Signup signupData = signupBlocInstance.getSignup();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      var user = await _auth
          .createUserWithEmailAndPassword(
            email: signupData.email,
            password: signupData.password,
          )
          .then((value) => value.user);

      authRequest.success = user != null;
      await prefs.setString('email', signupData.email);
      await prefs.setString('password', signupData.password);
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

  Future<AuthRequest> loginUser() async {
    AuthRequest authRequest = AuthRequest();
    Login loginData = authBlocInstance.getLogin();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await singOut();
    try {
      var user = await _auth
          .signInWithEmailAndPassword(
            email: loginData.email,
            password: loginData.password,
          )
          .then(
            (value) => value.user,
          );

      authRequest.success = user != null;

      await prefs.setString('email', loginData.email);
      await prefs.setString('password', loginData.password);
    } catch (e) {
      _mapErrorMessage(authRequest, e.code);
    }

    return authRequest;
  }

  Future<void> singOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      await _auth.signOut();
      await prefs.clear();
    } catch (e) {
      print(e);
    }
  }

  Future<AuthRequest> resignApp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    AuthRequest authRequest = AuthRequest();

    //GetFrom local storage
    String email = (prefs.getString('email') ?? null);
    String password = (prefs.getString('password') ?? null);

    if (email != null && password != null) {
      authBlocInstance.changeEmail(email);
      authBlocInstance.changePassword(password);
      authRequest = await AuthService().loginUser();
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
