import 'package:flutter/material.dart';
import 'package:home_work_one/data/file_storage_service.dart';
import 'package:home_work_one/models/product_model.dart';
import 'package:home_work_one/services/product_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  final ProductService _productService = ProductService();
  List<Product> _products = [];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  String userName = 'Guest';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadUser();
    _loadProducts();
  }

  Future<void> _loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString("username") ?? "Guest";
    setState(() {
      userName = username;
    });
  }

  Future<void> _loadProducts() async {
    final products = await _productService.getProducts();
    setState(() {
      _products = products;
    });

    print(_products);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: _appBar(context),
      body: ListView(
        children: [
          _slider,
          _productListWidget,
          _topProductListWidget,
          _recommendPlaceWidget(_products),
        ],
      ),
    );
  }

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: _isSearching
          ? TextField(
        controller: _searchController,
        autofocus: true,
        decoration: InputDecoration(
          hintText: "Search...",
          border: InputBorder.none,
        ),
        style: const TextStyle(color: Colors.black, fontSize: 18),
        onChanged: (value) {
          // Do search logic here
        },
      )
          : Text(
        "Hi, Mr. $userName 👋", // Use the actual userName variable
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
      actions: [
        _isSearching ? IconButton(
          icon: const Icon(Icons.close, color: Colors.black87),
          onPressed: () {
            setState(() {
              _isSearching = false;
              _searchController.clear();
            });
          },
        ) : _iconButton(Icons.search, onTap: () {
          setState(() {
            _isSearching = true;
          });
        }),
        const SizedBox(width: 8),
        _iconButton(Icons.notifications, onTap: () {
          // handle notification tap
        }),
        const SizedBox(width: 12),
      ],
    );
  }

  Widget get _slider {
    return Image.asset(
      "lib/assets/images/banner1.png",
      fit: BoxFit.cover,
      height: 200,
    );
  }

  Widget _iconButton(IconData icon, {VoidCallback? onTap}) {
    return Container(
      margin: const EdgeInsets.only(right: 4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey.shade200,
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.black87),
        onPressed: onTap,
      ),
    );
  }

  Widget get _productListWidget {
    final carItems = List.generate(
      10, (items) => SizedBox(
        height: 100,
        child: Card(
          child: Image.asset("lib/assets/images/shoes.png")
        ),
      ),
    );

    return SizedBox(
      height: 120, // Set height for horizontal scroll area
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: carItems,
        ),
      ),
    );
  }

  Widget _recommendPlaceWidget(List<Product> products) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Recommended Products",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 160,
            child: products.isEmpty ? const Center(child: Text("No products found.")) : ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return Container(
                  width: 140,
                  margin: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 6,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Static image
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                        child: Image.asset(
                          'lib/assets/images/shoes.png',
                          height: 80,
                          width: 140,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name ?? "No Name",
                              style: const TextStyle(fontWeight: FontWeight.bold),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text("Price: \$${product.price}"),
                            Text("Qty: ${product.quantity}"),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget get _topProductListWidget {
    final topProducts = List.generate(
      5, (index) => StatefulBuilder(
        builder: (context, setInnerState) {
          int quantity = 1; // local quantity state

          return StatefulBuilder(
            builder: (context, setInnerState) {
              return SizedBox(
                width: 160,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Expanded(
                          child: Image.asset(
                            "lib/assets/images/shoes.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          "Top Product",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove_circle_outline),
                                onPressed: () {
                                  if (quantity > 1) {
                                    setInnerState(() {
                                      quantity--;
                                    });

                                    FileStorageService.decreaseProduct(1, 1); // Decrease by 1

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text("Quantity decreased to $quantity"),
                                        duration: const Duration(seconds: 1),
                                      ),
                                    );
                                  }
                                }
                            ),
                            Text(
                              "$quantity",
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add_circle_outline),
                              onPressed: () {
                                setInnerState(() {
                                  quantity++;
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Quantity increased to $quantity"),
                                    duration: const Duration(seconds: 1),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {
                            FileStorageService.orderProduct(1, "Top Product", 200, quantity);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Product ordered"),
                                duration: Duration(seconds: 1),
                              ),
                            );
                          },
                          child: const Text("Order"),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              "Top Products",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 280,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(children: topProducts),
            ),
          ),
        ],
      ),
    );
  }

}
