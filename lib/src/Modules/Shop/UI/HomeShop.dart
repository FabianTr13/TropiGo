import 'package:TropiGo/src/Modules/Shop/UI/GasStoresScreen.dart';
import 'package:TropiGo/src/Modules/Shop/UI/GranelScreen.dart';
import 'package:TropiGo/src/Modules/Shop/UI/ShopCilinderScreen.dart';
import 'package:TropiGo/src/Modules/Shop/Widget/CardMenuItem.dart';
import "package:flutter/material.dart";
import 'dart:math';

const CURVE_HEIGHT = 300.0;
const AVATAR_RADIUS = CURVE_HEIGHT * 0.28;
const AVATAR_DIAMETER = AVATAR_RADIUS * 2;

class HomeShop extends StatefulWidget {
  HomeShop({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomeShop createState() => new _HomeShop();
}

class _HomeShop extends State<HomeShop> {
  gotoMenu(Widget option) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => option,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Stack(
        children: [
          _buildContent(),
          CurvedShape(),
          Container(
              margin: EdgeInsets.only(top: CURVE_HEIGHT - AVATAR_DIAMETER),
              width: double.infinity,
              height: AVATAR_DIAMETER,
              padding: EdgeInsets.all(8),
              child: Container(
                decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.deepOrangeAccent[400],
                ),
                child: Image.asset('assets/logo/logo.png'),
              ))
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Container(
      child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(16, CURVE_HEIGHT, 16, 16),
          child: Container(
            margin: EdgeInsets.only(left: 5, right: 5),
            child: new Column(
              children: [
                Row(
                  children: [
                    CardMenuItem(
                      imagen: Image.asset('assets/logo/logo.png'),
                      callback: () => gotoMenu(ShopCilinderScreen()),
                    ),
                    CardMenuItem(
                      imagen: Image.asset('assets/logo/stores.jpg'),
                      callback: () => gotoMenu(GasStoresScreen()),
                    )
                  ],
                ),
                Row(
                  children: [
                    CardMenuItem(
                      imagen: Image.asset('assets/logo/ganel.png'),
                      callback: () => gotoMenu(GranelScreen()),
                    ),
                    Column(
                      children: [
                        CardMenuItem(
                          imagen: Image.asset('assets/logo/face.png'),
                          height: 55,
                        ),
                        CardMenuItem(
                          imagen: Image.asset('assets/logo/insta.png'),
                          height: 55,
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          )),
    );
  }
}

class CurvedShape extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: CURVE_HEIGHT,
      child: CustomPaint(
        painter: _MyPainter(),
      ),
    );
  }
}

class _MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..style = PaintingStyle.fill
      ..isAntiAlias = true
      ..color = Colors.orange[700];

    Offset circleCenter = Offset(size.width / 2, size.height - AVATAR_RADIUS);

    Offset topLeft = Offset(0, 0);
    Offset bottomLeft = Offset(0, size.height * 0.65);
    Offset topRight = Offset(size.width, 0);
    Offset bottomRight = Offset(size.width, size.height * 0.65);

    Offset leftCurveControlPoint =
        Offset(circleCenter.dx * 0.5, size.height - AVATAR_RADIUS);
    Offset rightCurveControlPoint =
        Offset(circleCenter.dx * 1.6, size.height - AVATAR_RADIUS);

    final arcStartAngle = 180 / 180 * pi;
    final avatarLeftPointX =
        circleCenter.dx + AVATAR_RADIUS * cos(arcStartAngle);
    final avatarLeftPointY =
        circleCenter.dy + AVATAR_RADIUS * sin(arcStartAngle);
    Offset avatarLeftPoint =
        Offset(avatarLeftPointX, avatarLeftPointY); // the left point of the arc

    final arcEndAngle = -1 / 180 * pi;
    final avatarRightPointX =
        circleCenter.dx + AVATAR_RADIUS * cos(arcEndAngle);
    final avatarRightPointY =
        circleCenter.dy + AVATAR_RADIUS * sin(arcEndAngle);
    Offset avatarRightPoint = Offset(
        avatarRightPointX, avatarRightPointY); // the right point of the arc

    Path path = Path()
      ..moveTo(topLeft.dx,
          topLeft.dy) // this move isn't required since the start point is (0,0)
      ..lineTo(bottomLeft.dx, bottomLeft.dy)
      ..quadraticBezierTo(leftCurveControlPoint.dx, leftCurveControlPoint.dy,
          avatarLeftPoint.dx, avatarLeftPoint.dy)
      ..arcToPoint(avatarRightPoint, radius: Radius.circular(AVATAR_RADIUS))
      ..quadraticBezierTo(rightCurveControlPoint.dx, rightCurveControlPoint.dy,
          bottomRight.dx, bottomRight.dy)
      ..lineTo(topRight.dx, topRight.dy)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
