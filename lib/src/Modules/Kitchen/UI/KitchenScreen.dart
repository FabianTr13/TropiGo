import 'package:TropiGo/src/Modules/Kitchen/Bloc/KitchenBloc.dart';
import 'package:TropiGo/src/Modules/Tips/Widget/CarouselText.dart';
import 'package:TropiGo/src/Multimedia/Images.dart';
import 'package:TropiGo/src/Services/KitchenService.dart';
import 'package:TropiGo/src/Services/UtilsService.dart';
import 'package:TropiGo/src/Utils/BoxGradient.dart';
import 'package:TropiGo/src/Widgets/ButtonIconCircle.dart';
import 'package:TropiGo/src/Widgets/ButtonRoundBorder.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class KitchenScreen extends StatefulWidget {
  KitchenScreen({Key key}) : super(key: key);

  @override
  _KitchenScreenState createState() => _KitchenScreenState();
}

class _KitchenScreenState extends State<KitchenScreen> {
  bool _isLoading = true;
  String _imageTop = "";

  @override
  void initState() {
    super.initState();

    KitchenServise().getRecipes().then((value) {
      setState(() {
        _isLoading = false;
      });
    });

    UtilsService().getImageStore(CocinaImg).then((value) {
      setState(() {
        _imageTop = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _isLoading,
      progressIndicator: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(Colors.orange),
      ),
      child: Container(
        margin: EdgeInsets.zero,
        decoration: BoxGradient(),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: StreamBuilder(
                  stream: kitchenBlocInstance.recipes,
                  builder: (context, snapshot) => Column(
                    children: [
                      CachedNetworkImage(
                        imageUrl: _imageTop,
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                      CarouselText(
                        stream: kitchenBlocInstance.recipes,
                      ),
                    ],
                  ),
                ),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  margin: EdgeInsets.only(bottom: 15),
                  child: ButtonIconCircle(
                    callback: () => Navigator.pop(context),
                    backgroundColor: Colors.red,
                    icon: Icons.arrow_back,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
