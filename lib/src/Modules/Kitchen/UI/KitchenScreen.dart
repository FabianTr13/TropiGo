import 'package:TropiGo/src/Modules/Home/UI/HomeMenu.dart';
import 'package:TropiGo/src/Widgets/ButtonRoundBorder.dart';
import 'package:flutter/material.dart';

class KitchenScreen extends StatefulWidget {
  @override
  _KitchenScreen createState() => new _KitchenScreen();
}

class _KitchenScreen extends State<KitchenScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height, child: KitchenPage());
  }

  gotoBack() {
    Navigator.pop(context);
  }

  Widget KitchenPage() {
    return new Scaffold(
      body: Container(
        margin: EdgeInsets.zero,
        decoration: BoxDecoration(
            gradient: new LinearGradient(
                colors: [Colors.yellow, Colors.deepOrange],
                begin: const FractionalOffset(0, 0.9),
                end: const FractionalOffset(0, 0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp)),
        child: new Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: 325,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/logo/kitchen.png'),
                ),
              ),
            ),
            Divider(
              height: 50,
            ),
            Container(
                margin: EdgeInsets.all(10),
                child: Text(
                  "La historia de Honduras, país ubicado en el centro de América Central, se remonta a unos 14 000 años (conforme al consenso de Clovis), en que se estima ocurrieron los primeros asentamientos de pobladores sedentarios. Resalta en la historia geológica de Honduras el hecho de poseer el único reporte de fósiles de dinosaurios de América Central. Antes de la conquista por los españoles en el siglo XVI",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                )),
            ButtonRoundBorder(
              text: "Back Inicio",
              icon: Icons.arrow_back,
              callback: gotoBack,
            ),
            Divider(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
