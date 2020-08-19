import 'package:TropiGo/src/Modules/Kitchen/Bloc/KitchenBloc.dart';
import 'package:TropiGo/src/Modules/Kitchen/Models/KitchenRecipe.dart';
import 'package:TropiGo/src/Multimedia/Images.dart';
import 'package:TropiGo/src/Services/KitchenService.dart';
import 'package:TropiGo/src/Utils/BoxGradient.dart';
import 'package:TropiGo/src/Widgets/ButtonRoundBorder.dart';
import 'package:TropiGo/src/Widgets/Paragraph.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class KitchenScreen extends StatefulWidget {
  KitchenScreen({Key key}) : super(key: key);

  @override
  _KitchenScreenState createState() => _KitchenScreenState();
}

class _KitchenScreenState extends State<KitchenScreen> {
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    KitchenServise().getRecipes().then((value) {
      setState(() {
        _isLoading = false;
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
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: StreamBuilder(
                  stream: kitchenBlocInstance.recipe,
                  builder: (context, snapshot) => Column(
                    children: [
                      Image.asset(
                        (snapshot.data as KitchenRecipe)?.image ?? LogoImg,
                        height: 300,
                      ),
                      Paragraph(
                        (snapshot.data as KitchenRecipe)?.title ?? "",
                        18,
                      ),
                      Paragraph(
                        (snapshot.data as KitchenRecipe)?.recipe ?? "",
                        16,
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
                  child: ButtonRoundBorder(
                    text: "Back Inicio",
                    // icon: Icons.arrow_back,
                    callback: () => Navigator.pop(context),
                    backgroundColor: Colors.red,
                    width: 2,
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
