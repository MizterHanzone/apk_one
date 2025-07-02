class Order {
  int productId;
  String name;
  double price;
  int quantity;

  Order({
    required this.productId,
    required this.name,
    required this.price,
    required this.quantity,
  });

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      productId: map['productId'],
      name: map['name'],
      price: map['price'],
      quantity: map['quantity'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'name': name,
      'price': price,
      'quantity': quantity,
    };
  }

  @override
  String toString() {
    return '$name x$quantity - \$${(price * quantity).toStringAsFixed(2)}';
  }
}
