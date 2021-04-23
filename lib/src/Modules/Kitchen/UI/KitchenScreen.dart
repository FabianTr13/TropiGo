import 'package:TropiGo/src/Modules/Kitchen/Bloc/KitchenBloc.dart';
import 'package:TropiGo/src/Modules/Tips/Widget/CarouselText.dart';
import 'package:TropiGo/src/Multimedia/Images.dart';
import 'package:TropiGo/src/Services/UtilsService.dart';
import 'package:TropiGo/src/Utils/BoxGradient.dart';
import 'package:TropiGo/src/Widgets/ButtonIconCircle.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class KitchenScreen extends StatefulWidget {
  const KitchenScreen({Key key}) : super(key: key);

  @override
  _KitchenScreenState createState() => _KitchenScreenState();
}

class _KitchenScreenState extends State<KitchenScreen> {
  String _imageTop = "";

  @override
  void initState() {
    super.initState();

    UtilsService().getImageStore(CocinaImg).then((value) {
      setState(() {
        _imageTop = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) => Container(
      margin: EdgeInsets.zero,
      height: MediaQuery.of(context).size.height,
      decoration: boxGradient(),
      child: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.only(bottom: 15),
              height: MediaQuery.of(context).size.height,
              child: SafeArea(
                  child: Column(children: [
                StreamBuilder(
                    stream: kitchenBlocInstance.recipes,
                    builder: (context, snapshot) => Column(children: [
                          CachedNetworkImage(
                              imageUrl: _imageTop,
                              width: MediaQuery.of(context).size.width * 0.95,
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error)),
                          CarouselText(stream: kitchenBlocInstance.recipes)
                        ])),
                Expanded(
                    child: Container(
                        alignment: Alignment.bottomCenter,
                        child: ButtonIconCircle(
                            callback: () => Navigator.pop(context),
                            backgroundColor: Colors.red,
                            icon: Icons.arrow_back)))
              ])))));
}
