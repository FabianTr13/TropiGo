import 'package:TropiGo/src/Modules/Tips/Bloc/TipsBloc.dart';
import 'package:TropiGo/src/Modules/Tips/Widget/CarouselText.dart';
import 'package:TropiGo/src/Multimedia/Images.dart';
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

    UtilsService().getImageStore(TipsImg).then((value) {
      setState(() {
        imageTop = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) => Container(
      margin: EdgeInsets.zero,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
          child: Container(
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.only(bottom: 15),
              decoration: boxGradient(),
              child: Column(children: [
                CachedNetworkImage(
                    imageUrl: imageTop,
                    width: MediaQuery.of(context).size.width * 0.95,
                    placeholder: (context, url) => Container(
                        height: 400,
                        child: Center(child: CircularProgressIndicator())),
                    errorWidget: (context, url, error) => Icon(Icons.error)),
                CarouselText(stream: tipsBlocInstance.tips),
                Expanded(
                    child: Container(
                        alignment: Alignment.bottomCenter,
                        child: ButtonIconCircle(
                            callback: () => Navigator.pop(context),
                            backgroundColor: Colors.red,
                            icon: Icons.arrow_back)))
              ]))));
}
