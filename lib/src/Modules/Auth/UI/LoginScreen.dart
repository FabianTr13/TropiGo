import 'package:TropiGo/src/Modules/Auth/Bloc/AuthBloc.dart';
import 'package:TropiGo/src/Modules/Auth/Models/AuthRequest.dart';
import 'package:TropiGo/src/Modules/Auth/UI/SignupScreen.dart';
import 'package:TropiGo/src/Modules/Home/UI/HomeMenu.dart';
import 'package:TropiGo/src/Services/AuthService.dart';
import 'package:TropiGo/src/Widgets/ButtonLargeSubmit.dart';
import 'package:TropiGo/src/Widgets/ErrorMessage.dart';
import 'package:TropiGo/src/Widgets/InputTextbox.dart';
import 'package:TropiGo/src/Widgets/buttonLarge.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginState createState() => new _LoginState();
}

class _LoginState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool showErrorMessage = false;
  bool isLoading = false;
  FocusNode _focusNode;
  AuthRequest authRequest = AuthRequest();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height, child: _Login());
  }

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  _doLogin() async {
    setState(() {
      isLoading = true;
    });
    var request = await AuthService().loginUser(
        email: _emailController.text, password: _passwordController.text);

    setState(() {
      authRequest = request;
      isLoading = false;
    });

    if (authRequest.success) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeMenu()),
      );
    } else {
      Future.delayed(
        const Duration(milliseconds: 5000),
        () => {
          setState(() {
            authRequest.showErrorMessage = false;
          })
        },
      );
    }
  }

  _gotoSignup() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignupScreen()),
    );
    _cleanFocus();
  }

  _cleanFocus() {
    _emailController.text = "";
    _passwordController.text = "";
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
          decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              colorFilter: new ColorFilter.mode(
                Colors.black.withOpacity(0.05),
                BlendMode.dstATop,
              ),
              image: AssetImage('assets/logo/logo.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Form(
            key: _formKey,
            child: new Column(
              children: [
                Divider(height: 30),
                Container(
                  child: Center(
                      child: Image.asset(
                    'assets/logo/logo.png',
                    width: 200,
                    height: 200,
                  )),
                ),
                Center(
                  child: Text(
                    "Iniciar Sesión",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                      fontSize: 24,
                    ),
                  ),
                ),
                InputTextbox(
                  title: "Correo",
                  hintText: 'Correo@Correo.com',
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  focusNode: _focusNode,
                  onChange: authBlocInstance.changeEmail,
                  stream: authBlocInstance.email,
                ),
                InputTextbox(
                  title: "Contraseña",
                  hintText: '**********',
                  obscureText: true,
                  controller: _passwordController,
                  onChange: authBlocInstance.changePassword,
                  stream: authBlocInstance.password,
                ),
                Visibility(
                  visible: authRequest.showErrorMessage,
                  child: ErrorMessage(errorMessage: authRequest.errorMessage),
                ),
                Divider(
                  height: 15.0,
                ),
                ButtonLarge(
                  text: "Aun no tienes cuenta?",
                  callback: _gotoSignup,
                  color: Colors.redAccent,
                  backgroundColor: Colors.transparent,
                ),
                ButtonLargeSubmit(
                  text: "INGRESAR",
                  callback: _doLogin,
                  stream: authBlocInstance.submitValidLogin,
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
