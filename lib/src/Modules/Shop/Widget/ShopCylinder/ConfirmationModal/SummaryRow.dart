import 'package:flutter/material.dart';

TableRow summaryRow() {
  return TableRow(
    children: [
      summaryCell(text: "", textAlign: TextAlign.start),
      summaryCell(text: "Total", textAlign: TextAlign.center),
      summaryCell(text: "2,525.55", textAlign: TextAlign.end),
    ],
  );
}

TableCell summaryCell({String text, TextAlign textAlign}) {
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
