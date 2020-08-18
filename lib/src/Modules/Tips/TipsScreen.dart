import 'package:TropiGo/src/Modules/Tips/Bloc/TipsBloc.dart';
import 'package:TropiGo/src/Modules/Tips/Models/Tips.dart';
import 'package:TropiGo/src/Multimedia/Images.dart';
import 'package:TropiGo/src/Services/TipsService.dart';
import 'package:TropiGo/src/Widgets/ButtonRoundBorder.dart';
import 'package:TropiGo/src/Widgets/Paragraph.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class TipsScreen extends StatefulWidget {
  TipsScreen({Key key}) : super(key: key);

  @override
  _TipsScreenState createState() => _TipsScreenState();
}

class _TipsScreenState extends State<TipsScreen> {
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    TipsServise().getTips().then((value) {
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
        decoration: BoxDecoration(
          gradient: new LinearGradient(
            colors: [Colors.yellow, Colors.deepOrange],
            begin: const FractionalOffset(0, 0.9),
            end: const FractionalOffset(0, 0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          ),
        ),
        child: SafeArea(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: StreamBuilder(
                  stream: tipsBlocInstance.tips,
                  builder: (context, snapshot) => Column(
                    children: [
                      Image.asset(
                        (snapshot.data as Tips)?.image ?? LogoImg,
                        height: 300,
                      ),
                      Paragraph((snapshot.data as Tips)?.title ?? "", 18),
                      Paragraph((snapshot.data as Tips)?.description ?? "", 16),
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
                    icon: Icons.arrow_back,
                    callback: () => Navigator.pop(context),
                    marginRound: 0.2,
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
