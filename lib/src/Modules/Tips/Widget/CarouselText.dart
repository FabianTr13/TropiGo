import 'package:TropiGo/src/Widgets/Paragraph.dart';
import 'package:flutter/material.dart';

class CarouselText extends StatelessWidget {
  final Stream stream;
  final Widget widgetItem;
  const CarouselText({Key key, this.stream, this.widgetItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: stream,
        builder: (context, snapshot) {
          final List info = snapshot.data;
          List<Widget> items =
              info.map((item) => buildItem(context, item)).toList();
          return Container(child: Column(children: items));
        });
  }

  Widget buildItem(BuildContext context, item) => Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: 10),
      child: Container(
          child: Column(children: [
        paragraph(item.title, 16),
        paragraph(item.description, 14)
      ])));
}
