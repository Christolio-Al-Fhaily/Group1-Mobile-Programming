import 'dart:async';
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:prison_ui/models/user.dart';
import 'package:prison_ui/signup_page.dart';

import 'home_page.dart';
import 'models/LogInRequest.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  // Hash the password before sending it to the server
  String _hashPassword(String password) {
    final bytes = utf8.encode(password); // Convert the password to bytes
    final digest = sha256.convert(bytes); // Hash the password with SHA-256
    return digest.toString(); // Return the hashed password
  }

  Future<void> _login() async {
    final String email = _emailController.text;
    final String password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      showMessageDialog("Error", "Please fill in all fields");
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final hashedPassword = _hashPassword(password);
    final loginRequest = LogInRequest(
      email: email,
      password: hashedPassword,
    );

    final data = loginRequest.toMap();

    try {
      final response = await http.post(
        Uri.parse('${dotenv.env['API_URL']!}/login'), // Update endpoint
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data),
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final user = User.fromMap(responseData);

        // Navigate to LawyersPage with response data
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(user: user),
            ));
      } else {
        showMessageDialog("Login Failed", "Invalid email or password");
      }
    } on TimeoutException {
      showMessageDialog("Login Failed", "Request timed out");
    }
    catch (e) {
      showMessageDialog("Error", "An error occurred: $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFFFFFFF)),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView( // Make the body scrollable
          child: Container(
            margin: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _logo(context),
                _header(context),
                const SizedBox(height: 60.0),
                _inputField(context),
                _forgotPassword(context),
                _signup(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _logo(context) {
    return Image.asset(
      'assets/logo1.png', // Replace with the path to your logo asset
      height: 300, // Adjust the height to fit your design
      width: 300,
    );
  }

  _header(context) {
    return const Column(
      children: [
        Text(
          "Welcome Back",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        Text("Enter your credential to login"),
      ],
    );
  }

  _inputField(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: _emailController,
          decoration: InputDecoration(
            hintText: "Email",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            fillColor: Colors.yellow[700]?.withOpacity(0.1),
            filled: true,
            prefixIcon: const Icon(Icons.person),
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _passwordController,
          decoration: InputDecoration(
            hintText: "Password",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            fillColor: Colors.orange.withOpacity(0.1),
            filled: true,
            prefixIcon: const Icon(Icons.password),
          ),
          obscureText: true,
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: _isLoading ? null : _login,
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: Colors.orangeAccent,
          ),
          child: _isLoading
              ? const CircularProgressIndicator(
                  color: Colors.black,
                )
              : const Text(
                  "Login",
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
        )
      ],
    );
  }

  _forgotPassword(context) {
    return TextButton(
      onPressed: () {
        showMessageDialog("Contact Christolio", "71134227");
      },
      child: const Text(
        "Any issue?",
        style: TextStyle(color: Colors.blueAccent),
      ),
    );
  }

  _signup(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account? "),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SignupPage()),
            );
          },
          child: const Text(
            "Sign Up",
            style: TextStyle(color: Colors.blueAccent),
          ),
        )
      ],
    );
  }

  showMessageDialog(String title, String content) {
    // Show failure dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text(
                'OK',
                style: TextStyle(
                  color: Colors.orangeAccent,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
