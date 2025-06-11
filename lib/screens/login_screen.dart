import 'package:flutter/material.dart';
import 'package:home_work_one/data/app_shared_preference.dart';
import 'package:home_work_one/routes/app_route.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
                _logo,
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
                const SizedBox(height: 24),
                _navigateToRegister,
                const SizedBox(height: 24),
                _socialLogin,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget get _logo {
    return Padding(
        padding: EdgeInsets.only(bottom: 16),
      child: Image.asset(
        "lib/assets/images/flutter.png",
        width: 100,
        height: 100,
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
        if(value.length >= 6){
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

  Widget get _navigateToRegister{
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: TextButton(
          onPressed: (){
            AppRoute.key.currentState?.pushNamed(AppRoute.registerScreen);
          },
          child: Text(
            "Don't have account? Register"
          ),
      ),
    );
  }

  Widget get _socialLogin {
    return Padding(
        padding: EdgeInsets.only(bottom: 16, top: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
              onPressed: (){},
              icon: Image.asset(
                "lib/assets/images/google.png",
                width: 50,
                height: 50,
              ),
          ),
          SizedBox(width: 20,),
          IconButton(
            onPressed: (){},
            icon: Image.asset(
              "lib/assets/images/facebook.png",
              width: 50,
              height: 50,
            ),
          ),
        ],
      ),
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
        onPressed: () async {
          await AppSharedPref.register("Kheav Sokhan", "sokhankheav@gmail.com", "123456");

          if (_formKey.currentState!.validate()) {
            String email = _emailController.text.trim();
            String password = _passwordController.text.trim();

            bool isValid = await AppSharedPref.login(email, password);
            if (isValid) {
              AppRoute.key.currentState!.pushReplacementNamed(AppRoute.mainScreen);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Invalid email or password")),
              );
            }
          }
        },
        child: const Text(
            "Login",
            style: TextStyle(
                fontSize: 16,
              color: Colors.white
            ),
        ),
      ),
    );
  }
}
