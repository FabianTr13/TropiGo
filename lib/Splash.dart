import 'package:TropiGo/src/Modules/Auth/UI/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

class Splash extends StatefulWidget {
  @override
  _Splash createState() => new _Splash();
}

class _Splash extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
        seconds: 2,
        navigateAfterSeconds: new LoginScreen(),
        title: new Text(
          'La llama que rinde mas',
          style: new TextStyle(
              fontWeight: FontWeight.bold, fontSize: 26.0, color: Colors.white),
        ),
        image: new Image.asset('assets/logo/logo.png'),
        gradientBackground:
            LinearGradient(colors: [Colors.orangeAccent, Colors.orange]),
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 100.0,
        onClick: () => print("Flutter Egypt"),
        loaderColor: Colors.red);
  }
}
