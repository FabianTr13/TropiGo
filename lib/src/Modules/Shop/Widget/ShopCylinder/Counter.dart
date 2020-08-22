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
  Widget build(BuildContext context) {
    return Center(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _ButtonAction(minus, Icons.remove),
          StreamBuilder(
            stream: shopCylinderBlocInstance.count,
            initialData: "0",
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return Container(
                child: Text(
                  snapshot.data,
                  style: new TextStyle(fontSize: 22.0),
                ),
              );
            },
          ),
          _ButtonAction(add, Icons.add),
        ],
      ),
    );
  }

  Widget _ButtonAction(VoidCallback callback, IconData icon) {
    return FlatButton(
      onPressed: callback,
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: TropiColors.grey,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Icon(
          icon,
          size: 40,
        ),
      ),
    );
  }
}
