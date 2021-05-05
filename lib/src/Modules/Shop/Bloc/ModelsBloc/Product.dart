class Product {
  String codProducto;
  double precio;
  String nombreProducto;
  bool isSelect;
  int cantidad;
  double total;

  factory Product(Map jsonMap) => Product.deserialize(jsonMap);

  Product.deserialize(Map jsonMap)
      : codProducto = jsonMap["codProducto"].toString(),
        precio = double.parse(jsonMap["precio"].toString()),
        nombreProducto = jsonMap["nombreProducto"].toString(),
        cantidad = int.parse(jsonMap["cantidad"].toString()),
        isSelect = false,
        total = 0;

  Map<String, dynamic> toJson() => {
        "cantidad": this.cantidad.toString(),
        "codProducto": this.codProducto,
        "excento": "1",
        "impuesto": "0",
        "nombreProducto": this.nombreProducto,
        "precio": this.precio.toString()
      };
}
