import 'package:TropiGo/src/Widgets/InputTextbox.dart';
import 'package:TropiGo/src/Widgets/buttonLarge.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreen createState() => new _SignupScreen();
}

class _SignupScreen extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height, child: Signup());
  }

  registerUser() {}

  Widget Signup() {
    return new Scaffold(
        body: SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            colorFilter: new ColorFilter.mode(
                Colors.black.withOpacity(0.05), BlendMode.dstATop),
            image: AssetImage('assets/logo/logo.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: new Column(
          children: <Widget>[
            Divider(height: 30),
            Container(
              child: Center(
                  child: Image.asset(
                'assets/logo/logo.png',
                width: 200,
                height: 200,
              )),
            ),
            InputTextFiel(
              title: "Correo",
              hintText: 'Correo@Correo.com',
              keyboardType: TextInputType.emailAddress,
            ),
            InputTextFiel(title: "Nombre", hintText: 'John Smith'),
            InputTextFiel(title: "Teléfono", hintText: '99999999'),
            InputTextFiel(
              title: "Contraseña",
              hintText: '**********',
              obscureText: true,
            ),
            InputTextFiel(
              title: "Confirmar Contraseña",
              hintText: '**********',
              obscureText: true,
            ),
            Divider(
              height: 15.0,
            ),
            ButtonLarge(
              text: "REGISTRARSE",
              callback: registerUser,
            )
          ],
        ),
      ),
    ));
  }
}
