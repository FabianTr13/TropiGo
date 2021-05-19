import 'package:TropiGo/src/Modules/Auth/Bloc/AuthBloc.dart';
import 'package:TropiGo/src/Modules/Auth/Bloc/SignupBloc.dart';
import 'package:TropiGo/src/Modules/Auth/Models/AuthRequest.dart';
import 'package:TropiGo/src/Modules/Auth/Models/Login.dart';
import 'package:TropiGo/src/Modules/Auth/Models/Signup.dart';
import 'package:TropiGo/src/Modules/Auth/Models/UserProfile.dart';
import 'package:TropiGo/src/Services/OrderService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  final databaseReference = FirebaseDatabase.instance.reference();

  Future<AuthRequest> createUser() async {
    AuthRequest authRequest = AuthRequest();

    final String cityId = await orderBloc.getCityId();
    final String cityName = await orderBloc.getCityName();

    Signup signupData = signupBlocInstance.getSignup(cityId, cityName);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      var user = await _auth.createUserWithEmailAndPassword(
        email: signupData.email,
        password: signupData.password,
      );

      if (user.user != null) {
        databaseReference
            .child("Users")
            .child(user.user.uid)
            .set(signupData.singUptoJson());
        await prefs.setString('email', signupData.email);
        await prefs.setString('password', signupData.password);
        authRequest.success = true;
      }
    } catch (e) {
      _mapErrorMessage(authRequest, e.code);
    }
    return authRequest;
  }

  Future<UserProfile> getCurrentUser() async {
    UserProfile userProfile;
    try {
      var user = _auth.currentUser;

      if (user != null) {
        var userStore =
            await databaseReference.child('Users').child(user.uid).once();

        if (userStore.value != null) {
          userProfile = UserProfile(
            uid: userStore.key,
            email: user.email,
            name: userStore.value['name'],
            cityId: userStore.value['cityId'],
            cityName: userStore.value['cityName'],
            colony: userStore.value['colony'],
            phoneNumber: userStore.value['phone'].toString(),
            sexo: userStore.value['sexo'].toString(),
            birthDate: userStore.value['fechaNacimiento'].toString(),
            provider: userStore.value['provider'],
            userInDelivering: userStore.value['userInDelivering'],
          );
        }
      }
    } catch (e) {}
    return userProfile;
  }

  void updateUser() async {
    final String cityId = await orderBloc.getCityId();
    final String cityName = await orderBloc.getCityName();

    Signup userUpdate = signupBlocInstance.getSignup(cityId, cityName);
    databaseReference
        .child("Users")
        .child(userUpdate.uID)
        .set(userUpdate.upDatetoJson());
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

  Future<String> sendRestartEmail() async {
    final String email = authBlocInstance.getRestartEmail();
    try {
      var restartRequest =
          await _auth.sendPasswordResetEmail(email: email).then((value) {});
      print(restartRequest);
      return "Se envio un correo para restablecer tu contraseña";
    } catch (e) {
      return "Correo no valido";
    }
  }

  cerrarSesion(BuildContext context) {
    AuthService().singOut().then((value) => Navigator.of(context).popUntil(
          (route) => route.isFirst,
        ));
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
    print(code);
    switch (code) {
      case 'user-not-found':
        authRequest.errorMessage = "Usuario no encontrado";
        break;
      case 'wrong-password':
        authRequest.errorMessage = "Contraseña invalida";
        break;
      case 'ERROR_NETWORK_REQUEST_FAILED':
        authRequest.errorMessage = "Error de conexion";
        break;
      case 'email-already-in-use':
        authRequest.errorMessage = "El usuario ya esta registrado";
        break;
      case 'invalid-email':
        authRequest.errorMessage = "Correo invalido";
        break;
      case 'too-many-requests':
        authRequest.errorMessage = "Muchas intentos";
        break;
      default:
        authRequest.errorMessage = code;
    }
    authRequest.showErrorMessage = true;
  }
}
