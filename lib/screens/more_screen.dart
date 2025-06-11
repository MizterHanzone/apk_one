import 'package:flutter/material.dart';
import 'package:home_work_one/data/app_shared_preference.dart';
import 'package:home_work_one/routes/app_route.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  void _logout(BuildContext context) async {
    await AppSharedPref.logout();

    // Optionally show a message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Logged out successfully')),
    );

    AppRoute.key.currentState!.pushReplacementNamed(AppRoute.loginScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('More'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: ElevatedButton.icon(
            onPressed: () => _logout(context),
            icon: const Icon(Icons.logout),
            label: const Text('Logout'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
          ),
        ),
      ),
    );
  }
}
