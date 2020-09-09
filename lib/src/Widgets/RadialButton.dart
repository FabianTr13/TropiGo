import 'package:TropiGo/src/Multimedia/TropiColors.dart';
import 'package:flutter/material.dart';

class RadialButton extends StatelessWidget {
  final Stream stream;
  final String title;
  final String value;
  final void Function(String) callback;

  const RadialButton({
    Key key,
    @required this.stream,
    @required this.title,
    @required this.value,
    @required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
      title: Text(
        this.title,
        style: TextStyle(
          color: TropiColors.white,
          fontSize: 18,
        ),
      ),
      onTap: () => callback(this.value),
      leading: StreamBuilder(
        stream: this.stream,
        initialData: this.value,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Radio(
            value: this.value,
            groupValue: snapshot.data,
            activeColor: TropiColors.orangeButons,
            onChanged: (value) {
              callback(this.value);
            },
          );
        },
      ),
    );
  }
}
