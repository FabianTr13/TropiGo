import 'package:TropiGo/src/Modules/Auth/UI/SignupScreen.dart';
import 'package:TropiGo/src/Modules/Home/UI/HomeMenu.dart';
import 'package:TropiGo/src/Widgets/InputTextbox.dart';
import 'package:TropiGo/src/Widgets/buttonLarge.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreen createState() => new _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height, child: LoginPage());
  }

  gotoSignup() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignupScreen()),
    );
  }

  gotoHome() => {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeMenu()),
        )
      };

  Widget LoginPage() {
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
            Divider(
              height: 15.0,
            ),
            InputTextFiel(
              title: "Contraseña",
              hintText: '**********',
              obscureText: true,
            ),
            Divider(
              height: 15.0,
            ),
            ButtonLarge(
              text: "Aun no tienes cuenta?",
              callback: gotoSignup,
              color: Colors.redAccent,
              backgroundColor: Colors.transparent,
            ),
            ButtonLarge(
              text: "INGRESAR",
              callback: gotoHome,
            )
          ],
        ),
      ),
    ));
  }
}
