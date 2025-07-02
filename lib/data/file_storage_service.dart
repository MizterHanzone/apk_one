import 'dart:convert';
import 'dart:io';
import 'package:home_work_one/models/order_model.dart';
import 'package:path_provider/path_provider.dart';

class FileStorageService {
  static Future<String> _getFilePath() async {
    final dir = await getApplicationDocumentsDirectory();
    return '${dir.path}/cart.json';
  }

  static Future<List<Order>> getCartItems() async {
    final path = await _getFilePath();
    final file = File(path);

    if (!(await file.exists())) return [];

    final lines = await file.readAsLines();
    return lines.map((line) => Order.fromMap(jsonDecode(line))).toList();
  }

  static Future<void> _saveCart(List<Order> cart) async {
    final path = await _getFilePath();
    final file = File(path);
    final sink = file.openWrite();
    for (final item in cart) {
      sink.writeln(jsonEncode(item.toMap()));
    }
    await sink.close();
  }

  /// Add or increase product
  static Future<void> orderProduct(int productId, String name, double price, int quantity) async {
    final cart = await getCartItems();
    final index = cart.indexWhere((e) => e.productId == productId);

    if (index != -1) {
      cart[index].quantity += quantity;
    } else {
      cart.add(Order(
        productId: productId,
        name: name,
        price: price,
        quantity: quantity,
      ));
    }

    await _saveCart(cart);
  }

  /// Decrease quantity or remove
  static Future<void> decreaseProduct(int productId, int quantity) async {
    final cart = await getCartItems();
    final index = cart.indexWhere((e) => e.productId == productId);

    if (index != -1) {
      cart[index].quantity -= quantity;
      if (cart[index].quantity <= 0) {
        cart.removeAt(index);
      }
      await _saveCart(cart);
    }
  }

  static Future<void> clearCart() async {
    final path = await _getFilePath();
    final file = File(path);
    if (await file.exists()) {
      await file.writeAsString('');
    }
  }
}
