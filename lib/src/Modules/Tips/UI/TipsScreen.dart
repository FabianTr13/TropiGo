import 'package:TropiGo/src/Modules/Tips/Bloc/TipsBloc.dart';
import 'package:TropiGo/src/Modules/Tips/Widget/CarouselText.dart';
import 'package:TropiGo/src/Multimedia/Images.dart';
import 'package:TropiGo/src/Services/TipsService.dart';
import 'package:TropiGo/src/Services/UtilsService.dart';
import 'package:TropiGo/src/Utils/BoxGradient.dart';
import 'package:TropiGo/src/Widgets/ButtonIconCircle.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class TipsScreen extends StatefulWidget {
  const TipsScreen({Key key}) : super(key: key);

  @override
  _TipsScreenState createState() => _TipsScreenState();
}

class _TipsScreenState extends State<TipsScreen> {
  String imageTop = "";
  @override
  void initState() {
    super.initState();
    TipsServise().getTips().then((value) {});

    UtilsService().getImageStore(TipsImg).then((value) {
      setState(() {
        imageTop = value;
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
                    Expanded(
                        child: Column(children: [
                      CachedNetworkImage(
                          imageUrl: imageTop,
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error)),
                      Expanded(
                          child: CarouselText(
                              stream: tipsBlocInstance.tips,
                              height: MediaQuery.of(context).size.height))
                    ])),
                    Container(
                        alignment: Alignment.bottomCenter,
                        margin: EdgeInsets.only(bottom: 15),
                        child: ButtonIconCircle(
                            callback: () => Navigator.pop(context),
                            backgroundColor: Colors.red,
                            icon: Icons.arrow_back))
                  ])))));
}
