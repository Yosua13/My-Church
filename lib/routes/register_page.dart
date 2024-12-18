import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyek_akhir/models/user.dart';
import 'package:proyek_akhir/provider/user_provider.dart';
import 'package:proyek_akhir/routes/login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isPasswordVisibleP = false;
  bool _isPasswordVisibleCP = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFFE082),
              Color(0xFFFFD54F),
              Color(0xFFFFCA28),
              Color(0xFFFFC107),
              Color(0xFFFFB300),
              Color(0xFFFFA000),
              Color(0xFFFF8F00),
              Color(0xFFFF6F00),
              Color(0xFFF57C00),
              Color(0xFFEF6C00),
              Color(0xFFE65100),
              Color(0xFFDD4B00),
              Color(0xFFD84315),
              Color(0xFFBF360C),
              Color(0xFFB71C1C),
            ],
            stops: [
              0.02,
              0.07,
              0.14,
              0.21,
              0.29,
              0.36,
              0.43,
              0.47,
              0.50,
              0.57,
              0.64,
              0.71,
              0.79,
              0.86,
              1.0,
            ],
          ),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth >= 800) {
              return _buildWebLayout();
            } else {
              return _buildMobileLayout();
            }
          },
        ),
      ),
    );
  }

  Widget _buildMobileLayout() {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFFE082),
              Color(0xFFFFD54F),
              Color(0xFFFFCA28),
              Color(0xFFFFC107),
              Color(0xFFFFB300),
              Color(0xFFFFA000),
              Color(0xFFFF8F00),
              Color(0xFFFF6F00),
              Color(0xFFF57C00),
              Color(0xFFEF6C00),
              Color(0xFFE65100),
              Color(0xFFDD4B00),
              Color(0xFFD84315),
              Color(0xFFBF360C),
              Color(0xFFB71C1C),
            ],
            stops: [
              0.02,
              0.07,
              0.14,
              0.21,
              0.29,
              0.36,
              0.43,
              0.47,
              0.50,
              0.57,
              0.64,
              0.71,
              0.79,
              0.86,
              1.0,
            ],
          ),
        ),
        padding: const EdgeInsets.only(top: 54, right: 16, left: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Create Account",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Enter your personal data correctly, Churchers!",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 32),
            _buildFormContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildWebLayout() {
    return Center(
      child: Container(
        width: 600,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Create Account",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Enter your personal data correctly, Churchers!",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 32),
              _buildFormContent(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormContent() {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          // Username Field
          textField(
            controller: _usernameController,
            hint: 'Enter your username',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your username';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          // Email Field
          textField(
            controller: _emailController,
            hint: 'Enter your email address',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email address';
              }
              if (!RegExp(r"^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  .hasMatch(value)) {
                return 'Please enter a valid email address';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          // Password Field
          textField(
            controller: _passwordController,
            hint: 'Enter your password',
            obscureText: !_isPasswordVisibleP,
            suffixIcon: IconButton(
              icon: Icon(
                _isPasswordVisibleP ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () {
                setState(() {
                  _isPasswordVisibleP = !_isPasswordVisibleP;
                });
              },
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              if (value.length < 6) {
                return 'Password must be at least 6 characters';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          // Confirm Password Field
          textField(
            controller: _confirmPasswordController,
            hint: 'Confirm your password',
            obscureText: !_isPasswordVisibleCP,
            suffixIcon: IconButton(
              icon: Icon(
                _isPasswordVisibleCP ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () {
                setState(() {
                  _isPasswordVisibleCP = !_isPasswordVisibleCP;
                });
              },
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please confirm your password';
              }
              if (value != _passwordController.text) {
                return 'Passwords do not match';
              }
              return null;
            },
          ),
          const SizedBox(height: 48),

          // Register Button
          SizedBox(
            height: 50,
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF584200),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  User newUser = User(
                    username: _usernameController.text,
                    email: _emailController.text,
                    password: _passwordController.text,
                  );
                  Provider.of<UserProvider>(context, listen: false)
                      .registerUser(newUser);

                  showSuccessDialog(context, 'Register Success',
                      'Congratulations, You have successfully registered');

                  Future.delayed(const Duration(milliseconds: 1500), () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                      (route) => false,
                    );
                  });
                }
              },
              child: const Text(
                'Register',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 15),

          // Register Link with TextSpan
          Center(
            child: RichText(
              text: TextSpan(
                text: "Already have account? ",
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
                children: [
                  TextSpan(
                    text: "Login",
                    style: const TextStyle(
                      color: Color(0xFF584200),
                      fontWeight: FontWeight.bold,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // Navigate to LoginPage
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()),
                        );
                      },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget textField({
    required TextEditingController controller,
    required String hint,
    bool obscureText = false,
    Widget? suffixIcon,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5), // Shadow direction
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hint,
          labelStyle: const TextStyle(color: Colors.black),
          hintStyle: TextStyle(color: Colors.grey[500]),
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.amber),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          suffixIcon: suffixIcon,
        ),
        validator: validator,
      ),
    );
  }

  void showSuccessDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // Timer untuk menutup dialog setelah 1 detik
        Future.delayed(const Duration(seconds: 1), () {
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop();
          }
        });

        return AlertDialog(
          backgroundColor: const Color(0xFFFFE082),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          title: Row(
            children: [
              const Icon(Icons.check_circle, color: Colors.white, size: 28),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          content: Text(
            message,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
        );
      },
    );
  }
}
