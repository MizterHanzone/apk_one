import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

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
  }

  Future<void> _loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString("username") ?? "Guest";
    setState(() {
      userName = username;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: _appBar(context),
      body: ListView(
        children: [
          _slider,
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

  // ===============

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
}
