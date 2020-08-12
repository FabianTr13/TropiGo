import 'package:TropiGo/src/Widgets/InputTextbox.dart';
import 'package:TropiGo/src/Widgets/buttonLarge.dart';
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
            Divider(height: 30),
            Container(
              child: Center(
                  child: Image.asset(
                'assets/logo/logo.png',
                width: 200,
                height: 200,
              )),
            ),
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
                        isSwitched = value;
                      })
                    },
                  )
                ],
              ),
            ),
            Visibility(
              visible: !isSwitched,
              child: InputTextbox(
                title: "Numero de contrato",
                hintText: '',
                keyboardType: TextInputType.number,
              ),
            ),
            InputTextbox(
              title: "Cantidad de galones",
              hintText: '',
              keyboardType: TextInputType.number,
            ),
            Visibility(
              visible: isSwitched,
              child: Column(
                children: [
                  InputTextbox(
                    title: "Nombre de la empresa",
                    hintText: '',
                  ),
                  InputTextbox(
                    title: "Correo",
                    hintText: 'Correo@correo.com',
                  ),
                  InputTextbox(
                    title: "Teléfono",
                    hintText: '99999999',
                  ),
                  InputTextbox(title: "Nombre del contacto", hintText: ''),
                  Divider(
                    height: 15.0,
                  ),
                ],
              ),
            ),
            ButtonLarge(
              text: "ENVIAR",
              callback: registerUser,
            )
          ],
        ),
      ),
    ));
  }
}
