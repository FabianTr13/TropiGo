import 'package:TropiGo/src/Modules/Kitchen/Bloc/KitchenBloc.dart';
import 'package:TropiGo/src/Modules/Kitchen/Models/KitchenRecipe.dart';
import 'package:TropiGo/src/Services/KitchenService.dart';
import 'package:TropiGo/src/Widgets/ButtonRoundBorder.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class KitchenScreen extends StatelessWidget {
  const KitchenScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    KitchenServise().getRecipes();
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
          stream: kitchenBlocInstance.recipe,
          builder: (context, snapshot) => Column(
            children: [
              ImageRecipe((snapshot.data as KitchenRecipe).image),
              TextLabel((snapshot.data as KitchenRecipe).title, 18),
              TextLabel((snapshot.data as KitchenRecipe).recipe, 18),
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

Widget ImageRecipe(String image) {
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
