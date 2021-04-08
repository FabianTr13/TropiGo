import 'package:TropiGo/src/Modules/Auth/UI/ProfileScreen.dart';
import 'package:TropiGo/src/Modules/Contact/UI/ContactScreen.dart';
import 'package:TropiGo/src/Modules/Shop/UI/HomeShop.dart';
import 'package:TropiGo/src/Modules/Kitchen/UI/KitchenScreen.dart';
import 'package:TropiGo/src/Modules/Tips/UI/TipsScreen.dart';
import 'package:TropiGo/src/Multimedia/Images.dart';
import 'package:TropiGo/src/Multimedia/tropi_icons_icons.dart';
import 'package:TropiGo/src/Services/AuthService.dart';
import 'package:TropiGo/src/Utils/BoxGradient.dart';
import 'package:TropiGo/src/Widgets/ButtonRoundBorder.dart';
import 'package:TropiGo/src/Widgets/ImageHeader.dart';
import 'package:flutter/material.dart';

class HomeMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double height = 55;
    final double marginButtons = 0.75;

    gotoMenu(Widget option) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => option,
        ),
      );
    }

    return Container(
      decoration: boxGradient(),
      child: new ListView(
        children: [
          ImageHeader(
            title: "",
            size: 150,
          ),
          ButtonRoundBorder(
            text: "Pide tu cilindro de GAS",
            icon: TropiIcons.corazon,
            callback: () => gotoMenu(HomeShop()),
            widthPorcent: marginButtons,
            height: height,
          ),
          ButtonRoundBorder(
            text: "Mi Perfil",
            icon: TropiIcons.user,
            callback: () => gotoMenu(ProfileScreen()),
            widthPorcent: marginButtons,
            height: height,
          ),
          ButtonRoundBorder(
            text: "Cocina con tropi",
            img: KitchenIconImg,
            callback: () => gotoMenu(KitchenScreen()),
            widthPorcent: marginButtons,
            height: height,
          ),
          ButtonRoundBorder(
            text: "Tropi Tips",
            img: TipsIconImg,
            callback: () => gotoMenu(TipsScreen()),
            widthPorcent: marginButtons,
            height: height,
          ),
          ButtonRoundBorder(
            text: "Sugerencias Tropigas",
            icon: TropiIcons.correo,
            callback: () => gotoMenu(ContactScreen()),
            widthPorcent: marginButtons,
            height: height,
          ),
          ButtonRoundBorder(
            text: "Cerrar Sesión",
            icon: TropiIcons.logout,
            callback: () => AuthService().cerrarSesion(context),
            widthPorcent: marginButtons,
            height: height,
          )
        ],
      ),
    );
  }
}
