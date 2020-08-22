import 'package:flutter/material.dart';

TableRow HeadersConfirmation() {
  return TableRow(
    children: [
      header(text: "Producto", textAlign: TextAlign.start),
      header(text: "Cant.", textAlign: TextAlign.center),
      header(text: "Total", textAlign: TextAlign.end),
    ],
  );
}

TableCell header({String text, TextAlign textAlign}) {
  return TableCell(
    child: Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.grey,
        fontSize: 16,
      ),
    ),
  );
}
