import 'package:TropiGo/src/Modules/Auth/Bloc/AuthBloc.dart';
import 'package:TropiGo/src/Modules/Auth/UI/RestoreScreen.dart';
import 'package:TropiGo/src/Modules/Auth/UI/SignupScreen.dart';
import 'package:TropiGo/src/Modules/Home/UI/HomeMenu.dart';
import 'package:TropiGo/src/Services/AuthService.dart';
import 'package:TropiGo/src/Utils/BoxGradient.dart';
import 'package:TropiGo/src/Widgets/ButtonIconCircleSubmit.dart';
import 'package:TropiGo/src/Widgets/ButtonLarge.dart';
import 'package:TropiGo/src/Widgets/ImageHeader.dart';
import 'package:TropiGo/src/Widgets/InputTextbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginState createState() => new _LoginState();
}

class _LoginState extends State<LoginScreen> {
  bool showErrorMessage = false;
  bool isLoading = false;
  FocusNode _focusNode;
  FocusNode _focusPassNode;

  @override
  Widget build(BuildContext context) {
    return Container(child: _login());
  }

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _doRedirect();
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
  }

  _doRedirect() {
    setState(() {
      isLoading = true;
    });

    AuthService().resignApp().then((value) {
      setState(() {
        isLoading = false;
      });

      if (value.success) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeMenu()));
      }
    });
  }

  _doLogin() async {
    setState(() {
      isLoading = true;
    });

    var request = await AuthService().loginUser();

    setState(() {
      isLoading = false;
    });

    if (request.success) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeMenu()));
    } else {
      showToast(request.errorMessage, backgroundColor: Colors.red);
    }
  }

  _gotoSignup() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SignupScreen()));
    FocusScope.of(context).requestFocus(_focusNode);
  }

  _gotoRestore() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => RestoreScreen()));
    FocusScope.of(context).requestFocus(_focusNode);
  }

  Widget _login() => Scaffold(
      body: ModalProgressHUD(
          inAsyncCall: isLoading,
          opacity: 0.5,
          color: Colors.orangeAccent,
          progressIndicator: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.orange)),
          child: Container(
              decoration: boxGradient(),
              child: Form(
                  child: ListView(children: [
                ImageHeader(title: "Bienvenido a TropiGo"),
                InputTextbox(
                    title: "Correo",
                    hintText: '',
                    keyboardType: TextInputType.emailAddress,
                    focusNode: _focusNode,
                    onChange: authBlocInstance.changeEmail,
                    stream: authBlocInstance.email,
                    nextFocus: _focusPassNode,
                    colorLines: Colors.white),
                InputTextbox(
                    title: "Contraseña",
                    hintText: '',
                    obscureText: true,
                    onChange: authBlocInstance.changePassword,
                    stream: authBlocInstance.password,
                    focusNode: _focusPassNode,
                    colorLines: Colors.white),
                SizedBox(height: 10),
                Center(
                    child: ButtonIconCircleSubmit(
                        nullText: "Rellene todos los campos",
                        callback: _doLogin,
                        stream: authBlocInstance.submitValidLogin)),
                ButtonLarge(
                    text: "Aun no tienes cuenta?",
                    callback: _gotoSignup,
                    color: Colors.white,
                    backgroundColor: Colors.transparent),
                ButtonLarge(
                    text: "Olvide mi contraseña",
                    callback: _gotoRestore,
                    color: Colors.white,
                    backgroundColor: Colors.transparent)
              ])))));
}
