import 'package:TropiGo/Splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  return runApp(StyledToast(
      locale: const Locale('es', 'HN'),
      toastPositions: StyledToastPosition.center,
      toastAnimation: StyledToastAnimation.slideFromTop,
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(fontFamily: 'Monserrat'),
          home: Splash())));
}
