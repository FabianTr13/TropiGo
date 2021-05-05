import 'package:TropiGo/src/Modules/Shop/Bloc/GranelBloc.dart';
import 'package:TropiGo/src/Multimedia/Images.dart';
import 'package:TropiGo/src/Services/GranelService.dart';
import 'package:TropiGo/src/Widgets/AppBar/NavBar.dart';
import 'package:TropiGo/src/Widgets/ButtonLargeSubmit.dart';
import 'package:TropiGo/src/Widgets/ImageHeader.dart';
import 'package:TropiGo/src/Widgets/InputTextbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

class GranelScreen extends StatefulWidget {
  @override
  _GranelState createState() => _GranelState();
}

class _GranelState extends State<GranelScreen> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) =>
      Container(height: MediaQuery.of(context).size.height, child: granel());

  registerUser() async {
    await GranelService().sendEmail();
    showToast("Pedido ha sido enviado");
    Navigator.pop(context);
  }

  Widget granel() => Scaffold(
      appBar: navBar(
          withActions: false,
          automaticallyImplyLeading: false,
          logo: GranelImg,
          sizeLogo: 80),
      body: SingleChildScrollView(
          child: Container(
              decoration: BoxDecoration(color: Colors.white),
              child: Column(children: [
                ImageHeader(),
                Container(
                    child: Row(children: [
                  Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Text("No tengo contrato")),
                  Switch(
                      value: isSwitched,
                      activeColor: Colors.orange,
                      onChanged: (value) => {
                            setState(() {
                              granelBlocInstance.changeIsContract(value);
                              isSwitched = value;
                            })
                          })
                ])),
                Visibility(
                    maintainState: true,
                    visible: !isSwitched,
                    child: InputTextbox(
                        title: "Numero de contrato",
                        hintText: '',
                        keyboardType: TextInputType.number,
                        onChange: granelBlocInstance.changeContract,
                        stream: granelBlocInstance.contract,
                        colorLines: Colors.grey)),
                InputTextbox(
                    title: "Cantidad de galones",
                    hintText: '',
                    keyboardType: TextInputType.number,
                    onChange: granelBlocInstance.changeCount,
                    stream: granelBlocInstance.count,
                    colorLines: Colors.grey),
                Visibility(
                    maintainState: true,
                    visible: isSwitched,
                    child: Column(children: [
                      InputTextbox(
                          title: "Nombre de la empresa",
                          hintText: '',
                          onChange: granelBlocInstance.changeNameBusiness,
                          stream: granelBlocInstance.nameBusiness,
                          colorLines: Colors.grey),
                      InputTextbox(
                          title: "Correo",
                          hintText: 'Correo@correo.com',
                          keyboardType: TextInputType.emailAddress,
                          onChange: granelBlocInstance.changeEmail,
                          stream: granelBlocInstance.email,
                          colorLines: Colors.grey),
                      InputTextbox(
                          title: "Teléfono",
                          hintText: '99999999',
                          keyboardType: TextInputType.number,
                          onChange: granelBlocInstance.changePhoneNumber,
                          stream: granelBlocInstance.phoneNumber,
                          colorLines: Colors.grey),
                      InputTextbox(
                          title: "Nombre del contacto",
                          hintText: '',
                          onChange: granelBlocInstance.changeContact,
                          stream: granelBlocInstance.nameContact,
                          colorLines: Colors.grey)
                    ])),
                SizedBox(height: 15.0),
                ButtonLargeSubmit(
                    text: "ENVIAR",
                    nullText: "Rellene los compos",
                    callback: registerUser,
                    stream: granelBlocInstance.submitValidGranel)
              ]))));
}
