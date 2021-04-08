import 'package:TropiGo/src/Modules/Auth/Bloc/AuthBloc.dart';
import 'package:TropiGo/src/Multimedia/Images.dart';
import 'package:TropiGo/src/Multimedia/tropi_icons_icons.dart';
import 'package:TropiGo/src/Services/AuthService.dart';
import 'package:TropiGo/src/Widgets/AppBar/SideMenuItem.dart';
import 'package:flutter/material.dart';

Drawer sideMenu(BuildContext context) {
  return Drawer(
      child: ListView(children: <Widget>[
    DrawerHeader(
        child: _headerSide(), decoration: BoxDecoration(color: Colors.grey)),
    SideMenuItem(
        title: "Cerrar sesión",
        icon: TropiIcons.logout,
        callback: () => AuthService().cerrarSesion(context))
  ]));
}

Widget _headerSide() {
  return Container(
      child: Column(children: [
    Image.asset(LogoImg, height: 120, width: 120),
    StreamBuilder(
        stream: authBlocInstance.email,
        builder: (context, snapshot) => Text(snapshot.data))
  ]));
}
