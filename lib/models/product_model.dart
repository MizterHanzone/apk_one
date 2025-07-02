class Product {
  final int id;
  final String name;
  final double price;
  final int quantity;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
  });


  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'name': name,
      'price': price,
      'quantity': quantity,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }


  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'] as String,
      // price: map['price'] is int
      //     ? (map['price'] as int).toDouble()
      //     : map['price'] as double,
      price: map['price'] is int ? (map['price'] as int).toDouble() : map['price'],
      quantity: map['quantity'] as int,
    );
  }

  @override
  String toString() {
    return 'Product(id: $id, name: $name, price: $price, quantity: $quantity)';
  }
}
