import 'package:TropiGo/src/Multimedia/Images.dart';
import 'package:TropiGo/src/Services/AuthService.dart';
import 'package:flutter/material.dart';

AppBar NavBar({
  bool withActions = true,
  bool automaticallyImplyLeading = true,
  String logo = LogoImg,
  double sizeLogo = 50,
}) {
  return AppBar(
    automaticallyImplyLeading: automaticallyImplyLeading,
    iconTheme: IconThemeData(color: Colors.grey),
    backgroundColor: Colors.white,
    title: Center(
      child: Image.asset(
        logo,
        height: sizeLogo,
        width: sizeLogo,
      ),
    ),
    actions: withActions ? actionsShop : null,
  );
}

List<Widget> actionsShop = [
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
];
