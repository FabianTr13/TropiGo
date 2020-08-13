import 'package:TropiGo/src/Modules/Auth/UI/LoginScreen.dart';
import 'package:TropiGo/src/Services/AuthService.dart';
import 'package:flutter/material.dart';

class PopupMenuShop extends StatelessWidget {
  const PopupMenuShop({Key key}) : super(key: key);

  _cerrarSesion(BuildContext context) {
    AuthService().singOut().then(
          (value) => Navigator.of(context).popUntil((route) => route.isFirst),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PopupMenuButton(
        itemBuilder: (BuildContext context) => [
          PopupMenuItem(
            value: "1",
            child: FlatButton(
              child: Text("Cerrar Sesión"),
              onPressed: () => _cerrarSesion(context),
            ),
          )
        ],
      ),
    );
  }
}
