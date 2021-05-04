import 'package:TropiGo/src/Modules/Shop/Bloc/ShopCylinderBloc.dart';
import 'package:TropiGo/src/Multimedia/TropiColors.dart';
import 'package:flutter/material.dart';

class Counter extends StatefulWidget {
  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  void minus() {
    shopCylinderBlocInstance.sumMinus("MINUS");
  }

  void add() {
    shopCylinderBlocInstance.sumMinus("SUM");
  }

  @override
  Widget build(BuildContext context) => Center(
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        _buttonAction(minus, Icons.remove),
        StreamBuilder(
            initialData: 1,
            stream: shopCylinderBlocInstance.count,
            builder: (BuildContext context, AsyncSnapshot snapshot) =>
                Container(
                    child: Text(snapshot.data.toString(),
                        style: TextStyle(fontSize: 22.0)))),
        _buttonAction(add, Icons.add)
      ]));

  Widget _buttonAction(VoidCallback callback, IconData icon) => FlatButton(
      onPressed: callback,
      child: Card(
          shape: RoundedRectangleBorder(
              side: BorderSide(color: TropiColors.grey, width: 1),
              borderRadius: BorderRadius.circular(5)),
          child: Icon(icon, size: 40)));
}
