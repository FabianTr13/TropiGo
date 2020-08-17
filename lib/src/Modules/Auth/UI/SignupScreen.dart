import 'package:TropiGo/src/Modules/Auth/Bloc/SignupBloc.dart';
import 'package:TropiGo/src/Modules/Auth/Models/AuthRequest.dart';
import 'package:TropiGo/src/Modules/Home/UI/HomeMenu.dart';
import 'package:TropiGo/src/Services/AuthService.dart';
import 'package:TropiGo/src/Widgets/ButtonLargeSubmit.dart';
import 'package:TropiGo/src/Widgets/ErrorMessage.dart';
import 'package:TropiGo/src/Widgets/ImageHeader.dart';
import 'package:TropiGo/src/Widgets/InputTextbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupState createState() => new _SignupState();
}

class _SignupState extends State<SignupScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height, child: Signup());
  }

  Future<void> registerUser() async {
    setState(() {
      isLoading = true;
    });

    var authRequestDo = await AuthService().createUser();

    setState(() {
      isLoading = false;
    });

    if (authRequestDo.success) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeMenu()),
      );
    } else {
      showToast(authRequestDo.errorMessage, backgroundColor: Colors.red);
    }
  }

  Widget Signup() {
    return new Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: SingleChildScrollView(
          child: Container(
            child: new Column(
              children: [
                ImageHeader(),
                InputTextbox(
                  title: "Correo",
                  hintText: 'Correo@correo.com',
                  keyboardType: TextInputType.emailAddress,
                  stream: signupBlocInstance.email,
                  onChange: signupBlocInstance.changeEmail,
                ),
                InputTextbox(
                  title: "Nombre",
                  hintText: 'John Smith',
                  stream: signupBlocInstance.name,
                  onChange: signupBlocInstance.changeName,
                ),
                InputTextbox(
                  title: "Teléfono",
                  hintText: '99999999',
                  keyboardType: TextInputType.number,
                  stream: signupBlocInstance.phoneNumber,
                  onChange: signupBlocInstance.changePhoneNumber,
                ),
                InputTextbox(
                  title: "Contraseña",
                  hintText: '**********',
                  obscureText: true,
                  stream: signupBlocInstance.password,
                  onChange: signupBlocInstance.changePassword,
                ),
                InputTextbox(
                  title: "Confirmar Contraseña",
                  hintText: '**********',
                  obscureText: true,
                  stream: signupBlocInstance.rePassword,
                  onChange: signupBlocInstance.changeRePassword,
                ),
                ButtonLargeSubmit(
                  text: "REGISTRARSE",
                  nullText: "Rellene todos los campos",
                  callback: registerUser,
                  stream: signupBlocInstance.submitValidSignup,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
