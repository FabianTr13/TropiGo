import 'package:TropiGo/src/Multimedia/Images.dart';
import 'package:TropiGo/src/Services/AuthService.dart';
import 'package:flutter/material.dart';

AppBar NavBar() {
  return AppBar(
    iconTheme: IconThemeData(color: Colors.grey),
    backgroundColor: Colors.white,
    title: Center(
      child: Image.asset(
        LogoImg,
        height: 50,
        width: 50,
      ),
    ),
    actions: [
      Container(
        child: PopupMenuButton(
          itemBuilder: (BuildContext context) => [
            PopupMenuItem(
              value: "1",
              child: FlatButton(
                child: Text("Cerrar Sesión"),
                onPressed: () => AuthService().cerrarSesion(context),
              ),
            )
          ],
        ),
      ),
    ],
  );
}
