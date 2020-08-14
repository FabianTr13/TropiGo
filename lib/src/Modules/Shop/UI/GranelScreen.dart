import 'package:TropiGo/src/Modules/Shop/Bloc/GranelBloc.dart';
import 'package:TropiGo/src/Widgets/ButtonLargeSubmit.dart';
import 'package:TropiGo/src/Widgets/ImageHeader.dart';
import 'package:TropiGo/src/Widgets/InputTextbox.dart';
import 'package:flutter/material.dart';

class GranelScreen extends StatefulWidget {
  @override
  _GranelState createState() => new _GranelState();
}

class _GranelState extends State<GranelScreen> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Granel(),
    );
  }

  registerUser() {}

  Widget Granel() {
    return new Scaffold(
        body: SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: new Column(
          children: [
            ImageHeader(),
            Container(
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Text("No tengo contrato"),
                  ),
                  Switch(
                    value: isSwitched,
                    activeColor: Colors.orange,
                    onChanged: (value) => {
                      setState(() {
                        granelBlocInstance.changeIsContract(value);
                        isSwitched = value;
                      })
                    },
                  )
                ],
              ),
            ),
            Visibility(
              maintainState: true,
              visible: !isSwitched,
              child: InputTextbox(
                title: "Numero de contrato",
                hintText: '',
                keyboardType: TextInputType.number,
                onChange: granelBlocInstance.changeContract,
                stream: granelBlocInstance.contract,
              ),
            ),
            InputTextbox(
              title: "Cantidad de galones",
              hintText: '',
              keyboardType: TextInputType.number,
              onChange: granelBlocInstance.changeCount,
              stream: granelBlocInstance.count,
            ),
            Visibility(
              maintainState: true,
              visible: isSwitched,
              child: Column(
                children: [
                  InputTextbox(
                    title: "Nombre de la empresa",
                    hintText: '',
                    onChange: granelBlocInstance.changeNameBusiness,
                    stream: granelBlocInstance.nameBusiness,
                  ),
                  InputTextbox(
                    title: "Correo",
                    hintText: 'Correo@correo.com',
                    keyboardType: TextInputType.emailAddress,
                    onChange: granelBlocInstance.changeEmail,
                    stream: granelBlocInstance.email,
                  ),
                  InputTextbox(
                    title: "Teléfono",
                    hintText: '99999999',
                    keyboardType: TextInputType.number,
                    onChange: granelBlocInstance.changePhoneNumber,
                    stream: granelBlocInstance.phoneNumber,
                  ),
                  InputTextbox(
                    title: "Nombre del contacto",
                    hintText: '',
                    onChange: granelBlocInstance.changeContact,
                    stream: granelBlocInstance.nameContact,
                  ),
                  Divider(
                    height: 15.0,
                  ),
                ],
              ),
            ),
            ButtonLargeSubmit(
              text: "ENVIAR",
              callback: registerUser,
              stream: granelBlocInstance.submitValidGranel,
            )
          ],
        ),
      ),
    ));
  }
}
