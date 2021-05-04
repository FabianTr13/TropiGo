import 'package:TropiGo/src/Widgets/Paragraph.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarouselText extends StatefulWidget {
  final Stream stream;
  final Widget widgetItem;
  final double height;
  const CarouselText({Key key, this.stream, this.widgetItem, this.height})
      : super(key: key);
  _CarouselTextState createState() => _CarouselTextState();
}

class _CarouselTextState extends State<CarouselText> {
  @override
  Widget build(BuildContext context) => StreamBuilder(
      stream: widget.stream,
      builder: (context, snapshot) => Container(
          height: widget.height,
          child: CarouselSlider(
              options: CarouselOptions(
                  enableInfiniteScroll: false,
                  viewportFraction: 1,
                  disableCenter: true),
              items: snapshot.data?.map<Widget>((item) {
                return Builder(builder: (BuildContext context) {
                  return CustomScrollView(
                      slivers: [SliverToBoxAdapter(child: buildItem(item))]);
                });
              })?.toList())));

  Widget buildItem(item) => Container(
      width: MediaQuery.of(context).size.width,
      child: Container(
          child: Column(children: [
        paragraph(item.title, 16),
        paragraph(item.description, 14)
      ])));
}
