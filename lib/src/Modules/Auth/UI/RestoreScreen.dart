import 'package:TropiGo/src/Modules/Auth/Bloc/AuthBloc.dart';
import 'package:TropiGo/src/Multimedia/Images.dart';
import 'package:TropiGo/src/Services/AuthService.dart';
import 'package:TropiGo/src/Utils/BoxGradient.dart';
import 'package:TropiGo/src/Widgets/ButtonIconCircle.dart';
import 'package:TropiGo/src/Widgets/ImageHeader.dart';
import 'package:TropiGo/src/Widgets/InputTextbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RestoreScreen extends StatefulWidget {
  @override
  _RestoreScreen createState() => new _RestoreScreen();
}

class _RestoreScreen extends State<RestoreScreen> {
  bool isLoading = false;
  final FocusNode _emailFocusNode = new FocusNode();

  @override
  void dispose() {
    super.dispose();
    _emailFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height, child: restorePassword());
  }

  _sendEMail() async {
    var result = await AuthService().sendRestartEmail();
    showToast(result);
  }

  Widget restorePassword() {
    return Scaffold(
        body: ModalProgressHUD(
            inAsyncCall: isLoading,
            child: Container(
                decoration: boxGradient(),
                child: ListView(children: [
                  ImageHeader(
                      image: ProfileImg,
                      title: "Crear cuenta",
                      underLine: true,
                      size: 80),
                  InputTextbox(
                      title: "Correo",
                      hintText: '',
                      keyboardType: TextInputType.emailAddress,
                      stream: authBlocInstance.emailRestore,
                      onChange: authBlocInstance.changeEmailRestore,
                      focusNode: _emailFocusNode,
                      colorLines: Colors.white),
                  Container(height: 25),
                  Center(
                      child: ButtonIconCircle(
                          nullText: "Rellene todos los campos",
                          callback: _sendEMail))
                ]))));
  }
}
