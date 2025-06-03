import 'package:flutter/material.dart';
import 'package:home_work_one/routes/app_route.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isValidMail = false;
  bool _isValidPassword = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
                const Icon(Icons.lock, size: 80, color: Colors.redAccent),
                const SizedBox(height: 24),
                Text(
                  "Login",
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 32),
                _emailField,
                const SizedBox(height: 16),
                _passwordField,
                const SizedBox(height: 24),
                _loginButton,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget get _emailField {
    return TextFormField(
      onChanged: (value){
        if(value.contains("@gmail")){
          setState(() {
            _isValidMail = true;
          });
        }else{
          setState(() {
            _isValidMail = false;
          });
        }
      },
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: "Email",
        prefixIcon: const Icon(Icons.email),
        suffix: _isValidMail ? Icon(Icons.check_circle, color: Colors.green,) : Icon(Icons.check_circle, color: Colors.grey,),
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
      onChanged: (value){
        if(value.length > 6){
          setState(() {
            _isValidPassword = true;
          });
        }else{
          setState(() {
            _isValidPassword = false;
          });
        }
      },
      controller: _passwordController,
      obscureText: true,
      decoration: InputDecoration(
        labelText: "Password",
        prefixIcon: const Icon(Icons.lock),
        suffix: _isValidPassword ? Icon(Icons.check_circle, color: Colors.green,) : Icon(Icons.check_circle, color: Colors.grey,),
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

  Widget get _loginButton {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.redAccent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            AppRoute.key.currentState!.pushReplacementNamed(AppRoute.mainScreen);
          }else{
            
          }
        },
        child: const Text("Login", style: TextStyle(fontSize: 16)),
      ),
    );
  }
}
