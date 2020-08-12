import 'package:TropiGo/src/Widgets/ButtonRoundBorder.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactScreen extends StatelessWidget {
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          gradient: new LinearGradient(
              colors: [Colors.yellow, Colors.deepOrange],
              begin: const FractionalOffset(0, 0.9),
              end: const FractionalOffset(0, 0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp)),
      child: new Column(
        children: [
          Container(
            child: Center(
                child: Image.asset(
              'assets/logo/contact.jpg',
              fit: BoxFit.fitHeight,
            )),
          ),
          ButtonRoundBorder(
            text: "Llama *Tropi",
            icon: Icons.call,
            callback: () => _launchURL('tel:+1 555 010 999'),
          ),
          ButtonRoundBorder(
            text: "Email",
            icon: Icons.email,
            callback: () => _launchURL(
                'mailto:smith@example.org?subject=News&body=New%20plugin'),
          ),
          ButtonRoundBorder(
            text: "Chat",
            icon: Icons.chat_bubble,
            callback: () => _launchURL('https://wa.me/99999999'),
          ),
          ButtonRoundBorder(
            text: "Back Inicio",
            icon: Icons.arrow_back,
            callback: () => Navigator.pop(context),
          )
        ],
      ),
    );
  }
}
