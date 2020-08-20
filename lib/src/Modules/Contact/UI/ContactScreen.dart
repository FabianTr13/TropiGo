import 'package:TropiGo/src/Modules/Contact/Models/Contact.dart';
import 'package:TropiGo/src/Multimedia/Images.dart';
import 'package:TropiGo/src/Multimedia/tropi_icons_icons.dart';
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
            icon: TropiIcons.phone,
            callback: () => _launchURL(contact.tel),
            width: 3,
            radius: 100,
            fontSize: 22,
          ),
          ButtonRoundBorder(
            text: "Email",
            icon: TropiIcons.correo,
            callback: () => _launchURL(contact.email),
            width: 3,
            radius: 100,
            fontSize: 22,
          ),
          ButtonRoundBorder(
            text: "Chat",
            icon: TropiIcons.chat,
            callback: () => _launchURL(contact.chat),
            width: 3,
            radius: 100,
            fontSize: 22,
          ),
          ButtonRoundBorder(
            text: "Back Inicio",
            callback: () => Navigator.pop(context),
            backgroundColor: Colors.red,
            width: 3,
            fontSize: 22,
          )
        ],
      ),
    );
  }
}
