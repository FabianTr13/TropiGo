import 'package:TropiGo/src/Modules/Auth/UI/Profile.dart';
import 'package:TropiGo/src/Modules/Contact/UI/ContactScreen.dart';
import 'package:TropiGo/src/Modules/Shop/UI/HomeShop.dart';
import 'package:TropiGo/src/Modules/Kitchen/UI/KitchenScreen.dart';
import 'package:TropiGo/src/Modules/Tips/TipsScreen.dart';
import 'package:TropiGo/src/Multimedia/Images.dart';
import 'package:TropiGo/src/Multimedia/tropi_icons_icons.dart';
import 'package:TropiGo/src/Services/AuthService.dart';
import 'package:TropiGo/src/Utils/BoxGradient.dart';
import 'package:TropiGo/src/Widgets/ButtonRoundBorder.dart';
import 'package:TropiGo/src/Widgets/HeaderIcon.dart';
import 'package:TropiGo/src/Widgets/ImageHeader.dart';
import 'package:flutter/material.dart';

class HomeMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    gotoMenu(Widget option) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => option,
        ),
      );
    }

    return Container(
      decoration: BoxGradient(),
      child: new Column(
        children: [
          ImageHeader(
            title: "",
            size: 150,
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            width: MediaQuery.of(context).size.width * 0.85,
            decoration: BoxDecoration(
                border: Border(
              top: BorderSide(
                width: 1,
                color: Colors.white,
              ),
            )),
          ),
          ButtonRoundBorder(
            text: "Pide tu cilindro de GAS",
            icon: TropiIcons.corazon,
            callback: () => gotoMenu(HomeShop()),
          ),
          ButtonRoundBorder(
            text: "Mi Perfil",
            icon: TropiIcons.user,
            callback: () => gotoMenu(ProfileScreen()),
          ),
          ButtonRoundBorder(
            text: "Cocina con tropi",
            icon: TropiIcons.cocina,
            callback: () => gotoMenu(KitchenScreen()),
          ),
          ButtonRoundBorder(
            text: "Tropi Tips",
            icon: TropiIcons.idea,
            callback: () => gotoMenu(TipsScreen()),
          ),
          ButtonRoundBorder(
            text: "Sugerencias Tropigas",
            icon: TropiIcons.correo,
            callback: () => gotoMenu(ContactScreen()),
          ),
          ButtonRoundBorder(
            text: "Cerrar Sesión",
            icon: TropiIcons.logout,
            callback: () => AuthService().cerrarSesion(context),
          )
        ],
      ),
    );
  }
}
