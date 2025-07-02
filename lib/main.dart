import 'package:flutter/material.dart';
import 'package:home_work_one/data/db_manager.dart';
import 'package:home_work_one/routes/app_route.dart';
import 'package:home_work_one/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DBManager.instance.database;

  // await insertProduct();

  runApp(const MyApp());
}

Future<void> insertProduct() async {
  final db = await DBManager.instance.database;

  // Insert sample data
  await db.insert("tbl_product", {
    'name': 'Laptop',
    'price': 899.99,
    'quantity': 10,
  });

  await db.insert("tbl_product", {
    'name': 'Phone',
    'price': 499.50,
    'quantity': 25,
  });

  // Query and print all products
  final products = await db.query("tbl_product");
  for (var product in products) {
    print("Product: $product");
  }
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Homework App',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      initialRoute: AppRoute.splashScreen,
      onGenerateRoute: AppRoute.onGenerateRoute,
      navigatorKey: AppRoute.key,
    );
  }
}
