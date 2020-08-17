import 'package:TropiGo/src/Modules/Auth/Bloc/AuthBloc.dart';
import 'package:TropiGo/src/Modules/Auth/Models/AuthRequest.dart';
import 'package:TropiGo/src/Modules/Auth/UI/SignupScreen.dart';
import 'package:TropiGo/src/Modules/Home/UI/HomeMenu.dart';
import 'package:TropiGo/src/Services/AuthService.dart';
import 'package:TropiGo/src/Widgets/ButtonLargeSubmit.dart';
import 'package:TropiGo/src/Widgets/ErrorMessage.dart';
import 'package:TropiGo/src/Widgets/ImageHeader.dart';
import 'package:TropiGo/src/Widgets/InputTextbox.dart';
import 'package:TropiGo/src/Widgets/buttonLarge.dart';
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

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: _Login(),
    );
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

    AuthService().resignApp().then(
      (value) {
        setState(() {
          isLoading = false;
        });

        if (value.success) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeMenu()),
          );
        }
      },
    );
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
        context,
        MaterialPageRoute(builder: (context) => HomeMenu()),
      );
    } else {
      showToast(
        request.errorMessage,
        backgroundColor: Colors.red,
      );
    }
  }

  _gotoSignup() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignupScreen()),
    );
    FocusScope.of(context).requestFocus(_focusNode);
  }

  Widget _Login() {
    return new Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        opacity: 0.5,
        color: Colors.orangeAccent,
        child: SingleChildScrollView(
          child: Container(
            child: Form(
              child: new Column(
                children: [
                  ImageHeader(title: "Iniciar Sesión"),
                  InputTextbox(
                    title: "Correo",
                    hintText: 'Correo@Correo.com',
                    keyboardType: TextInputType.emailAddress,
                    focusNode: _focusNode,
                    onChange: authBlocInstance.changeEmail,
                    stream: authBlocInstance.email,
                  ),
                  InputTextbox(
                    title: "Contraseña",
                    hintText: '**********',
                    obscureText: true,
                    onChange: authBlocInstance.changePassword,
                    stream: authBlocInstance.password,
                  ),
                  ButtonLarge(
                    text: "Aun no tienes cuenta?",
                    callback: _gotoSignup,
                    color: Colors.grey,
                    backgroundColor: Colors.transparent,
                  ),
                  ButtonLargeSubmit(
                    text: "INGRESAR",
                    nullText: "Rellena los campos",
                    callback: _doLogin,
                    stream: authBlocInstance.submitValidLogin,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
