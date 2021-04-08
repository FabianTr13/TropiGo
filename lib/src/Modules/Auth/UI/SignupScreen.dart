import 'package:TropiGo/src/Modules/Auth/Bloc/SignupBloc.dart';
import 'package:TropiGo/src/Modules/Home/UI/HomeMenu.dart';
import 'package:TropiGo/src/Multimedia/Images.dart';
import 'package:TropiGo/src/Multimedia/TropiColors.dart';
import 'package:TropiGo/src/Services/AuthService.dart';
import 'package:TropiGo/src/Utils/BoxGradient.dart';
import 'package:TropiGo/src/Utils/CalendarPicker.dart';
import 'package:TropiGo/src/Widgets/ButtonIconCircleSubmit.dart';
import 'package:TropiGo/src/Widgets/ImageHeader.dart';
import 'package:TropiGo/src/Widgets/InputTextbox.dart';
import 'package:TropiGo/src/Widgets/RadialButton.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<SignupScreen> {
  bool isLoading = false;
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _phoneFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _repasswordFocusNode = FocusNode();
  TextEditingController dateCtl = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailFocusNode.dispose();
    _nameFocusNode.dispose();
    _phoneFocusNode.dispose();
    _passwordFocusNode.dispose();
    _repasswordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height, child: signup());
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

  _changeSex(String value) {
    signupBlocInstance.changeSexo(value);
  }

  _changeBirthDay() async {
    var date = await CalendarPicker().showPicker(context);
    if (date != null) {
      dateCtl.text = formatDate(date, [dd, ' ', MM, ' ', yyyy]);
      signupBlocInstance.changeBirthDate(dateCtl.text);
      FocusScope.of(context).requestFocus(_passwordFocusNode);
    }
  }

  Widget signup() {
    return new Scaffold(
        body: ModalProgressHUD(
            inAsyncCall: isLoading,
            child: Container(
                decoration: boxGradient(),
                child: new ListView(children: [
                  ImageHeader(
                      image: ProfileImg,
                      title: "Crear cuenta",
                      underLine: true,
                      size: 80),
                  InputTextbox(
                      title: "Correo",
                      hintText: '',
                      keyboardType: TextInputType.emailAddress,
                      stream: signupBlocInstance.email,
                      onChange: signupBlocInstance.changeEmail,
                      focusNode: _emailFocusNode,
                      nextFocus: _nameFocusNode,
                      colorLines: Colors.white),
                  InputTextbox(
                      title: "Nombre",
                      hintText: '',
                      stream: signupBlocInstance.name,
                      onChange: signupBlocInstance.changeName,
                      focusNode: _nameFocusNode,
                      nextFocus: _phoneFocusNode,
                      colorLines: Colors.white),
                  InputTextbox(
                      title: "Teléfono",
                      hintText: '',
                      keyboardType: TextInputType.number,
                      stream: signupBlocInstance.phoneNumber,
                      onChange: signupBlocInstance.changePhoneNumber,
                      focusNode: _phoneFocusNode,
                      nextFocus: _passwordFocusNode,
                      colorLines: Colors.white),
                  Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Text("sexo",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: TropiColors.white))),
                  RadialButton(
                      stream: signupBlocInstance.sexo,
                      title: "Masculino",
                      value: "m",
                      callback: _changeSex),
                  RadialButton(
                      stream: signupBlocInstance.sexo,
                      title: "Femenino",
                      value: "f",
                      callback: _changeSex),
                  InputTextbox(
                      controller: dateCtl,
                      title: "Fecha de nacimiento",
                      hintText: '',
                      stream: signupBlocInstance.birthDay,
                      onChange: signupBlocInstance.changeBirthDate,
                      colorLines: Colors.white,
                      onTap: _changeBirthDay,
                      allowEdit: true),
                  InputTextbox(
                      title: "Contraseña",
                      hintText: '',
                      obscureText: true,
                      stream: signupBlocInstance.password,
                      onChange: signupBlocInstance.changePassword,
                      focusNode: _passwordFocusNode,
                      nextFocus: _repasswordFocusNode,
                      colorLines: Colors.white),
                  InputTextbox(
                      title: "Confirmar Contraseña",
                      hintText: '',
                      obscureText: true,
                      stream: signupBlocInstance.rePassword,
                      onChange: signupBlocInstance.changeRePassword,
                      focusNode: _repasswordFocusNode,
                      colorLines: Colors.white),
                  Container(height: 25),
                  Center(
                      child: ButtonIconCircleSubmit(
                          nullText: "Rellene todos los campos",
                          callback: registerUser,
                          stream: signupBlocInstance.submitValidSignup))
                ]))));
  }
}
