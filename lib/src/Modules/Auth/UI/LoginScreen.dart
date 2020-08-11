import 'package:TropiGo/src/Modules/Auth/UI/SignupScreen.dart';
import 'package:TropiGo/src/Modules/Home/UI/HomeMenu.dart';
import 'package:TropiGo/src/Widgets/InputTextbox.dart';
import 'package:TropiGo/src/Widgets/buttonLarge.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginState createState() => new _LoginState();
}

class _LoginState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  FocusNode _focusNode;

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

  _gotoSignup() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignupScreen()),
    );
    _cleanFocus();
  }

  _gotoHome() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeMenu()),
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
        body: SingleChildScrollView(
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
            ),
            InputTextbox(
              title: "Contraseña",
              hintText: '**********',
              obscureText: true,
              controller: _passwordController,
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
            ButtonLarge(
              text: "INGRESAR",
              callback: _gotoHome,
            )
          ],
        ),
      ),
    ));
  }
}
