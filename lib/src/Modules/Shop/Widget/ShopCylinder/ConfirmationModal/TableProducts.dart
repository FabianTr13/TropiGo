import 'package:TropiGo/src/Modules/Shop/Bloc/ModelsBloc/Product.dart';
import 'package:TropiGo/src/Modules/Shop/Bloc/ShopCylinderBloc.dart';
import 'package:flutter/material.dart';

Widget tableProduct() {
  return StreamBuilder(
    stream: shopCylinderBlocInstance.products,
    initialData: [],
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.white),
          child: DataTable(
            dataRowHeight: 30,
            dividerThickness: 0,
            headingRowHeight: 25,
            columnSpacing: 45,
            columns: headersConfirmation(),
            rows: rowData(snapshot.data),
          ),
        ),
      );
    },
  );
}

List<DataColumn> headersConfirmation() {
  return [
    header(text: "Producto", textAlign: TextAlign.start),
    header(text: "Cant.", textAlign: TextAlign.center),
    header(text: "Total", textAlign: TextAlign.end)
  ];
}

DataColumn header({String text, TextAlign textAlign}) {
  return DataColumn(
    label: Text(
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

//RowData
List<DataRow> rowData(List<dynamic> products) {
  List<DataRow> newList = [];
  double total = 0;

  products.forEach((element) {
    Product item = (element as Product);

    if (item.isSelect != null && item.isSelect) {
      newList.add(
        new DataRow(
          cells: [
            DataCell(
              cellValues(
                text: item.nombreProducto,
                textAlign: TextAlign.start,
              ),
            ),
            DataCell(
              cellValues(
                text: item.cantidad.toString(),
                textAlign: TextAlign.start,
              ),
            ),
            DataCell(
              cellValues(
                text: item.total.toStringAsFixed(2),
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
      );

      //SummatyTotal
      total = total + item.total;
    }
  });

  //Add the summary
  newList.add(summaryRow(total));
  return newList;
}

Text cellValues(
    {String text,
    TextAlign textAlign,
    FontWeight fontWeight = FontWeight.normal}) {
  return Text(
    text,
    textAlign: textAlign,
    style: TextStyle(color: Colors.grey, fontSize: 14, fontWeight: fontWeight),
  );
}

DataRow summaryRow(double total) {
  return DataRow(
    cells: [
      DataCell(cellValues(text: "", textAlign: TextAlign.start)),
      DataCell(cellValues(
        text: "Total",
        textAlign: TextAlign.center,
        fontWeight: FontWeight.bold,
      )),
      DataCell(cellValues(
        text: total.toStringAsFixed(2),
        textAlign: TextAlign.end,
        fontWeight: FontWeight.bold,
      )),
    ],
  );
}
