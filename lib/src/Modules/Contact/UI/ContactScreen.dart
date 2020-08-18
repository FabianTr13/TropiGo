import 'package:TropiGo/src/Modules/Contact/Models/Contact.dart';
import 'package:TropiGo/src/Multimedia/Images.dart';
import 'package:TropiGo/src/Services/ContactService.dart';
import 'package:TropiGo/src/Widgets/ButtonRoundBorder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactScreen extends StatefulWidget {
  ContactScreen({Key key}) : super(key: key);

  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  Contact contact = Contact();

  @override
  void initState() {
    super.initState();
    ContactService().getSetting().then((Contact value) {
      setState(() {
        contact = value;
      });
    });
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      showToast("No se pudo contactar al proveedor");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          gradient: new LinearGradient(
              colors: [Colors.yellow, Colors.deepOrange],
              begin: const FractionalOffset(0, 1.3),
              end: const FractionalOffset(0, 0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp)),
      child: new Column(
        children: [
          Image.asset(
            ContactImg,
            fit: BoxFit.fitHeight,
          ),
          Divider(
            height: 50,
          ),
          ButtonRoundBorder(
            text: "Llama *Tropi",
            icon: Icons.call,
            callback: () => _launchURL(contact.tel),
            marginRound: 0.2,
          ),
          ButtonRoundBorder(
            text: "Email",
            icon: Icons.email,
            callback: () => _launchURL(contact.email),
            marginRound: 0.2,
          ),
          ButtonRoundBorder(
            text: "Chat",
            icon: Icons.chat_bubble,
            callback: () => _launchURL(contact.chat),
            marginRound: 0.2,
          ),
          ButtonRoundBorder(
            text: "Back Inicio",
            icon: Icons.arrow_back,
            callback: () => Navigator.pop(context),
            marginRound: 0.2,
          )
        ],
      ),
    );
  }
}
