import 'package:TropiGo/src/Modules/Kitchen/Bloc/KitchenBloc.dart';
import 'package:TropiGo/src/Modules/Tips/Widget/CarouselText.dart';
import 'package:TropiGo/src/Multimedia/Images.dart';
import 'package:TropiGo/src/Services/KitchenService.dart';
import 'package:TropiGo/src/Services/UtilsService.dart';
import 'package:TropiGo/src/Utils/BoxGradient.dart';
import 'package:TropiGo/src/Widgets/ButtonIconCircle.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class KitchenScreen extends StatefulWidget {
  KitchenScreen({Key key}) : super(key: key);

  @override
  _KitchenScreenState createState() => _KitchenScreenState();
}

class _KitchenScreenState extends State<KitchenScreen> {
  String _imageTop = "";

  @override
  void initState() {
    super.initState();

    KitchenServise().getRecipes().then((value) {});

    UtilsService().getImageStore(CocinaImg).then((value) {
      setState(() {
        _imageTop = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      body: SafeArea(
          child: Container(
              padding: EdgeInsets.only(top: 20),
              decoration: boxGradient(),
              child: SafeArea(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                    StreamBuilder(
                        stream: kitchenBlocInstance.recipes,
                        builder: (context, snapshot) => Expanded(
                                child: Column(children: [
                              CachedNetworkImage(
                                  imageUrl: _imageTop,
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error)),
                              Expanded(
                                  child: CarouselText(
                                      stream: kitchenBlocInstance.recipes,
                                      height:
                                          MediaQuery.of(context).size.height))
                            ]))),
                    Container(
                        alignment: Alignment.bottomCenter,
                        margin: EdgeInsets.only(bottom: 15),
                        child: ButtonIconCircle(
                            callback: () => Navigator.pop(context),
                            backgroundColor: Colors.red,
                            icon: Icons.arrow_back))
                  ])))));
}
