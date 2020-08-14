import 'package:TropiGo/src/Modules/Auth/Bloc/AuthBloc.dart';
import 'package:TropiGo/src/Modules/Shop/UI/GasStoresScreen.dart';
import 'package:TropiGo/src/Modules/Shop/UI/HomeShop.dart';
import 'package:TropiGo/src/Modules/Shop/Widget/AppBar/SideMenuItem.dart';
import 'package:flutter/material.dart';

Drawer SideMenu() {
  return Drawer(
    child: ListView(
      children: <Widget>[
        DrawerHeader(
          child: _HeaderSide(),
          decoration: BoxDecoration(
            color: Colors.grey,
          ),
        ),
        SideMenuItem(
          title: "Ordenar",
          icon: Icons.camera,
          routerPage: HomeShop(),
        ),
        SideMenuItem(
          title: "Tus pedidos",
          icon: Icons.camera,
          routerPage: HomeShop(),
        ),
        SideMenuItem(
          title: "Nuestras Tiendas",
          icon: Icons.camera,
          routerPage: GasStoresScreen(),
        ),
      ],
    ),
  );
}

Widget _HeaderSide() {
  return Container(
    child: Column(
      children: [
        Image.asset(
          'assets/logo/logo.png',
          height: 120,
          width: 120,
        ),
        StreamBuilder(
          stream: authBlocInstance.email,
          builder: (context, snapshot) => Text(snapshot.data),
        )
      ],
    ),
  );
}
