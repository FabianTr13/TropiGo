import 'package:flutter/material.dart';

class SideMenuItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget routerPage;

  const SideMenuItem({
    Key key,
    this.title,
    this.icon,
    this.routerPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        title: Container(
          child: Row(
            children: [
              Icon(icon),
              Container(
                width: 30,
              ),
              Text(title),
            ],
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => routerPage,
            ),
          );
        },
      ),
    );
  }
}
