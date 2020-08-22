import 'package:TropiGo/src/Modules/Shop/Bloc/ModelsBloc/Product.dart';
import 'package:flutter/material.dart';

TableRow rowData({Product product}) {
  return TableRow(
    children: [
      cellValues(
        text: product.description,
        textAlign: TextAlign.start,
      ),
      cellValues(
        text: product.count.toString(),
        textAlign: TextAlign.center,
      ),
      cellValues(
        text: product.total.toString(),
        textAlign: TextAlign.end,
      ),
    ],
  );
}

TableCell cellValues({String text, TextAlign textAlign}) {
  return TableCell(
    child: Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        color: Colors.grey,
        fontSize: 16,
      ),
    ),
  );
}
