import 'package:flutter/material.dart';
import 'package:home_work_one/data/app_shared_preference.dart';
import 'package:home_work_one/routes/app_route.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isValidMail = false;
  bool _isValidPassword = false;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _logo,
                const SizedBox(height: 24),
                Text(
                  "Register",
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 32),
                _usernameField,
                const SizedBox(height: 16),
                _emailField,
                const SizedBox(height: 16),
                _passwordField,
                const SizedBox(height: 16),
                _confirmPasswordField,
                const SizedBox(height: 24),
                _registerButton,
                const SizedBox(height: 24),
                _navigateToLogin,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget get _logo {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Image.asset(
        "lib/assets/images/flutter.png",
        width: 100,
        height: 100,
      ),
    );
  }

  Widget get _usernameField {
    return TextFormField(
      controller: _usernameController,
      decoration: InputDecoration(
        labelText: "Username",
        prefixIcon: const Icon(Icons.person),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter your username";
        }
        return null;
      },
    );
  }


  Widget get _emailField {
    return TextFormField(
      onChanged: (value) {
        setState(() {
          _isValidMail = value.contains("@gmail");
        });
      },
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: "Email",
        prefixIcon: const Icon(Icons.email),
        suffix: Icon(
          Icons.check_circle,
          color: _isValidMail ? Colors.green : Colors.grey,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter your email";
        }
        if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
          return "Please enter a valid email";
        }
        return null;
      },
    );
  }

  Widget get _passwordField {
    return TextFormField(
      onChanged: (value) {
        setState(() {
          _isValidPassword = value.length >= 6;
        });
      },
      controller: _passwordController,
      obscureText: true,
      decoration: InputDecoration(
        labelText: "Password",
        prefixIcon: const Icon(Icons.lock),
        suffix: Icon(
          Icons.check_circle,
          color: _isValidPassword ? Colors.green : Colors.grey,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter your password";
        }
        if (value.length < 6) {
          return "Password must be at least 6 characters";
        }
        return null;
      },
    );
  }

  Widget get _confirmPasswordField {
    return TextFormField(
      controller: _confirmPasswordController,
      obscureText: true,
      decoration: InputDecoration(
        labelText: "Confirm Password",
        prefixIcon: const Icon(Icons.lock_outline),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please confirm your password";
        }
        if (value != _passwordController.text) {
          return "Passwords do not match";
        }
        return null;
      },
    );
  }

  Widget get _registerButton {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.redAccent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            String username = _usernameController.text.trim();
            String email = _emailController.text.trim();
            String password = _passwordController.text.trim();

            await AppSharedPref.register(username, email, password);
            AppRoute.key.currentState!.pushReplacementNamed(AppRoute.mainScreen);
          }
        },
        child: const Text(
          "Register",
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }

  Widget get _navigateToLogin {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextButton(
        onPressed: () {
          AppRoute.key.currentState?.pushNamed(AppRoute.loginScreen);
        },
        child: const Text("Already have an account? Login"),
      ),
    );
  }
}
