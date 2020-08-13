import 'package:TropiGo/src/Modules/Auth/Bloc/AuthBloc.dart';
import 'package:TropiGo/src/Modules/Shop/UI/GasStoresScreen.dart';
import 'package:TropiGo/src/Modules/Shop/UI/HomeShop.dart';
import 'package:TropiGo/src/Modules/Shop/Widget/SideMenuItem.dart';
import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {
  SideMenu({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          child: Container(
            child: Column(
              children: [
                Image.asset(
                  'assets/logo/logo.png',
                  height: 120,
                  width: 120,
                ),
                Text(authBlocInstance.getLogin().email)
              ],
            ),
          ),
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
    );
  }
}
