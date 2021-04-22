import 'package:TropiGo/src/Modules/Tips/Bloc/TipsBloc.dart';
import 'package:TropiGo/src/Modules/Tips/Widget/CarouselText.dart';
import 'package:TropiGo/src/Multimedia/Images.dart';
import 'package:TropiGo/src/Services/TipsService.dart';
import 'package:TropiGo/src/Services/UtilsService.dart';
import 'package:TropiGo/src/Utils/BoxGradient.dart';
import 'package:TropiGo/src/Widgets/ButtonIconCircle.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class TipsScreen extends StatefulWidget {
  const TipsScreen({Key key}) : super(key: key);

  @override
  _TipsScreenState createState() => _TipsScreenState();
}

class _TipsScreenState extends State<TipsScreen> {
  bool _isLoading = true;
  String imageTop = "";

  @override
  void initState() {
    super.initState();
    TipsServise().getTips().then((value) {
      setState(() {
        _isLoading = false;
      });
    });

    UtilsService().getImageStore(TipsImg).then((value) {
      setState(() {
        imageTop = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) => ModalProgressHUD(
      inAsyncCall: _isLoading,
      progressIndicator: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.orange)),
      child: Container(
          margin: EdgeInsets.zero,
          decoration: boxGradient(),
          child: SafeArea(
              child: SingleChildScrollView(
                  child: Column(children: [
            CachedNetworkImage(
                imageUrl: imageTop,
                width: MediaQuery.of(context).size.width * 0.95,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error)),
            CarouselText(stream: tipsBlocInstance.tips),
            Container(
                alignment: Alignment.bottomCenter,
                margin: EdgeInsets.only(bottom: 15),
                child: ButtonIconCircle(
                    callback: () => Navigator.pop(context),
                    backgroundColor: Colors.red,
                    icon: Icons.arrow_back))
          ])))));
}
