import 'package:flutter/material.dart';

class SideMenuItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback callback;

  const SideMenuItem({Key key, this.title, this.icon, this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
      child: ListTile(
          title: Container(
              child: Row(children: [
            Icon(icon, color: Colors.grey),
            Container(width: 30),
            Text(title)
          ])),
          onTap: callback));
}
