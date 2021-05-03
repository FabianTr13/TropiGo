import 'package:TropiGo/src/Modules/Auth/UI/LoginScreen.dart';
import 'package:flare_splash_screen/flare_splash_screen.dart';
import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) => SplashScreen.navigate(
      name: 'assets/Animations/Splash.flr',
      next: (context) => LoginScreen(),
      until: () => Future.delayed(Duration(milliseconds: 1000)),
      startAnimation: 'Start',
      backgroundColor: Colors.white);
}
