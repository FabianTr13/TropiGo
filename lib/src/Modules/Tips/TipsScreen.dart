import 'package:TropiGo/src/Modules/Kitchen/Bloc/KitchenBloc.dart';
import 'package:TropiGo/src/Modules/Tips/Bloc/TipsBloc.dart';
import 'package:TropiGo/src/Modules/Tips/Models/Tips.dart';
import 'package:TropiGo/src/Services/TipsService.dart';
import 'package:TropiGo/src/Widgets/ButtonRoundBorder.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class TipsScreen extends StatelessWidget {
  const TipsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TipsServise().getTips();
    return Container(
      margin: EdgeInsets.zero,
      decoration: BoxDecoration(
        gradient: new LinearGradient(
          colors: [Colors.yellow, Colors.deepOrange],
          begin: const FractionalOffset(0, 0.9),
          end: const FractionalOffset(0, 0),
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp,
        ),
      ),
      child: SingleChildScrollView(
        child: StreamBuilder(
          stream: tipsBlocInstance.tips,
          builder: (context, snapshot) => Column(
            children: [
              ImageTips((snapshot.data as Tips).image),
              TextLabel((snapshot.data as Tips).title, 18),
              TextLabel((snapshot.data as Tips).description, 16),
              ButtonRoundBorder(
                text: "Back Inicio",
                icon: Icons.arrow_back,
                callback: () => Navigator.pop(context),
              ),
              Container(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget ImageTips(String image) {
  return StreamBuilder(
    stream: kitchenBlocInstance.recipe,
    builder: (context, snapshot) => CachedNetworkImage(
      imageUrl: image,
      fit: BoxFit.fitWidth,
      height: 300,
    ),
  );
}

Widget TextLabel(String text, double size) {
  return Container(
    margin: EdgeInsets.only(
      top: 25,
    ),
    child: Text(
      text,
      textAlign: TextAlign.justify,
      style: TextStyle(
        color: Colors.white,
        fontSize: size,
        decoration: TextDecoration.none,
      ),
    ),
  );
}
