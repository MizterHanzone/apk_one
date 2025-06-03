import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: _body,
    );
  }

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Text(
        "Hi, Mr. Kheav Sokhan 👋",
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
      actions: [
        _iconButton(Icons.search),
        const SizedBox(width: 8),
        _iconButton(Icons.notifications),
        const SizedBox(width: 12),
      ],
    );
  }

  Widget _iconButton(IconData icon) {
    return Container(
      margin: const EdgeInsets.only(right: 4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey.shade200,
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.black87),
        onPressed: () {},
      ),
    );
  }

  Widget get _body {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Welcome back!",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "Here's your overview for today.",
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
          // Add more widgets here (e.g., cards, stats, etc.)
        ],
      ),
    );
  }
}
