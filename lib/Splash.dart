import 'package:TropiGo/src/Modules/Auth/UI/LoginScreen.dart';
import 'package:TropiGo/src/Modules/Home/UI/HomeMenu.dart';
import 'package:TropiGo/src/Services/AuthService.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => new _SplashState();
}

class _SplashState extends State<Splash> {
  bool isLogin = false;
  @override
  void initState() {
    super.initState();

    AuthService().resignApp().then(
          (value) => {
            setState(() {
              isLogin = value.success;
            })
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 2,
      navigateAfterSeconds: isLogin ? HomeMenu() : LoginScreen(),
      title: new Text(
        'La llama que rinde mas!',
        style: new TextStyle(
          fontSize: 26.0,
          color: Colors.white,
        ),
      ),
      image: new Image.asset('assets/logo/logo.png'),
      gradientBackground: LinearGradient(
        colors: [Colors.orangeAccent, Colors.orange],
      ),
      photoSize: 200.0,
      loaderColor: Colors.red,
    );
  }
}
