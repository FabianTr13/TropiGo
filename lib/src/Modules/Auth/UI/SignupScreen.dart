import 'dart:ffi';

import 'package:TropiGo/src/Modules/Auth/Bloc/AuthBloc.dart';
import 'package:TropiGo/src/Modules/Auth/Models/AuthRequest.dart';
import 'package:TropiGo/src/Modules/Home/UI/HomeMenu.dart';
import 'package:TropiGo/src/Services/AuthService.dart';
import 'package:TropiGo/src/Widgets/InputTextbox.dart';
import 'package:TropiGo/src/Widgets/buttonLarge.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupState createState() => new _SignupState();
}

class _SignupState extends State<SignupScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height, child: Signup());
  }

  Future<void> registerUser() async {
    AuthRequest authRequest = await AuthService().createUser(
      email: _emailController.text,
      password: _passwordController.text,
    );

    if (authRequest.success) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeMenu()),
      );
    }
  }

  Widget Signup() {
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
              InputTextbox(
                title: "Correo",
                hintText: 'Correo@correo.com',
                keyboardType: TextInputType.emailAddress,
                stream: authBlocInstance.email,
                onChange: authBlocInstance.changeEmail,
              ),
              InputTextbox(
                title: "Nombre",
                hintText: 'John Smith',
                stream: authBlocInstance.name,
                onChange: authBlocInstance.changeName,
              ),
              InputTextbox(
                title: "Teléfono",
                hintText: '99999999',
                keyboardType: TextInputType.number,
                stream: authBlocInstance.phoneNumber,
                onChange: authBlocInstance.changePhoneNumber,
              ),
              InputTextbox(
                title: "Contraseña",
                hintText: '**********',
                obscureText: true,
                stream: authBlocInstance.passwordSignup,
                onChange: authBlocInstance.changePasswordSignup,
              ),
              InputTextbox(
                title: "Confirmar Contraseña",
                hintText: '**********',
                obscureText: true,
                stream: authBlocInstance.rePasswordSignup,
                onChange: authBlocInstance.changeRePasswordSignup,
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
      ),
    );
  }
}
