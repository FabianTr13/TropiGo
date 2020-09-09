import 'package:TropiGo/src/Widgets/Paragraph.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarouselText extends StatefulWidget {
  final Stream stream;
  Widget widgetItem;
  CarouselText({
    this.stream,
    this.widgetItem,
  });
  @override
  _CarouselTextState createState() => _CarouselTextState();
}

class _CarouselTextState extends State<CarouselText> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.stream,
      builder: (context, snapshot) => CarouselSlider(
        options: CarouselOptions(
          enableInfiniteScroll: false,
          viewportFraction: 1,
          disableCenter: true,
        ),
        items: snapshot.data?.map<Widget>((item) {
          return Builder(
            builder: (BuildContext context) {
              return CustomScrollView(slivers: [
                SliverToBoxAdapter(
                  child: Item(
                    item,
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: snapshot.data.map<Widget>(
                  //     (dot) {
                  //       return Container(
                  //         width: 8.0,
                  //         height: 8.0,
                  //         margin: EdgeInsets.symmetric(
                  //             vertical: 10.0, horizontal: 2.0),
                  //         decoration: BoxDecoration(
                  //           shape: BoxShape.circle,
                  //           color: identical(dot, item)
                  //               ? Color.fromRGBO(0, 0, 0, 0.9)
                  //               : Color.fromRGBO(0, 0, 0, 0.4),
                  //         ),
                  //       );
                  //     },
                  //   ).toList(),
                  // ),
                ),
              ]);
            },
          );
        })?.toList(),
      ),
    );
  }

  Widget Item(item) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Container(
        child: Column(
          children: [
            Paragraph(item.title, 16),
            Paragraph(item.description, 14),
          ],
        ),
      ),
    );
  }
}
