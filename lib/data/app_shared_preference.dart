import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPref {
  static Future<bool> login(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final storedEmail = prefs.getString("email");
    final storedPassword = prefs.getString("password");

    print("Stored email: $storedEmail");
    print("Stored password: $storedPassword");
    print("Input email: $email");
    print("Input password: $password");

    return storedEmail == email && storedPassword == password;
  }


  static Future<void> register(String username, String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("username", username);
    prefs.setString("email", email);
    prefs.setString("password", password);
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}