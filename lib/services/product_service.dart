import 'package:home_work_one/data/db_manager.dart';
import 'package:home_work_one/models/product_model.dart';

class ProductService {
  Future<void> insertProduct(Product product) async {
    final db = await DBManager.instance.database;
    await db.insert("tbl_product", product.toMap());
  }

  Future<List<Product>> getProducts() async {
    final db = await DBManager.instance.database;
    final products = await db.query("tbl_product");

    return products.map((e) => Product.fromMap(e)).toList();
  }
}