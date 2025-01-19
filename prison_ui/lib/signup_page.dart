import 'dart:convert';

import 'package:crypto/crypto.dart'; // Import the crypto package
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'login_page.dart';
import 'models/SignUpRequest.dart'; // For formatting dates

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _ssnController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _inmateIdController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.orange,
            hintColor: Colors.orange,
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            scaffoldBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _dateOfBirthController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: [
                  const SizedBox(height: 60.0),
                  const Text(
                    "Sign up",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Create your account",
                    style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 20.0),
                  Column(
                    children: <Widget>[
                      _buildTextField(
                          hintText: "First Name",
                          icon: Icons.person,
                          controller: _firstNameController),
                      const SizedBox(height: 20),
                      _buildTextField(
                          hintText: "Last Name",
                          icon: Icons.person,
                          controller: _lastNameController),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _dateOfBirthController,
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: "Date of Birth",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide.none,
                          ),
                          fillColor: Colors.orange.withOpacity(0.1),
                          filled: true,
                          prefixIcon: const Icon(Icons.calendar_today),
                        ),
                        onTap: () => _selectDate(context),
                      ),
                      const SizedBox(height: 20),
                      _buildTextField(
                          hintText: "SSN",
                          icon: Icons.onetwothree,
                          controller: _ssnController),
                      const SizedBox(height: 20),
                      _buildTextField(
                          hintText: "Phone Number",
                          icon: Icons.numbers,
                          controller: _phoneNumberController),
                      const SizedBox(height: 20),
                      _buildTextField(
                          hintText: "Inmate ID",
                          icon: Icons.perm_identity,
                          controller: _inmateIdController),
                      const SizedBox(height: 20),
                      _buildTextField(
                          hintText: "Email",
                          icon: Icons.email,
                          controller: _emailController),
                      const SizedBox(height: 20),
                      _buildTextField(
                          hintText: "Password",
                          icon: Icons.password,
                          controller: _passwordController,
                          obscureText: true),
                      const SizedBox(height: 20),
                      _buildTextField(
                          hintText: "Confirm Password",
                          icon: Icons.password,
                          controller: _confirmPasswordController,
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'This field cannot be empty';
                            }
                            if (value != _passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          }),
                      const SizedBox(height: 20, width: 50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(width: 50.0),
                          ElevatedButton(
                            onPressed: _signup,
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orangeAccent,
                                elevation: 10,
                                shadowColor: Colors.grey.withOpacity(0.8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 16.0, horizontal: 32.0)),
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      if (_isLoading)
                        const Center(
                          child: CircularProgressIndicator(
                            color: Colors.orange, // Spinner color
                          ),
                        ),
                      const SizedBox(width: 50.0),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text("Already have an account? "),
                          TextButton(
                            onPressed: () {
                              // Navigate to the LoginPage when pressed
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginPage(),
                                ),
                              );
                            },
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                color: Colors.orangeAccent, // Hyperlink color
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String hintText,
    required IconData icon,
    bool obscureText = false,
    required TextEditingController controller,
    FormFieldValidator<String>? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
        fillColor: Colors.orangeAccent.withOpacity(0.1),
        filled: true,
        prefixIcon: Icon(icon),
      ),
      obscureText: obscureText,
      validator: validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return 'This field cannot be empty';
            }
            return null;
          },
    );
  }

  String _hashPassword(String password) {
    // Convert password to bytes
    final bytes = utf8.encode(password);
    // Hash the password using SHA-256
    final hashed = sha256.convert(bytes);
    return hashed
        .toString(); // Return the hex string representation of the hash
  }

  Future<void> _signup() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    setState(() {
      _isLoading = true;
    });
    // Hash the password before sending it to the server
    String hashedPassword = _hashPassword(_passwordController.text);

    // Create a SignupRequest instance with the hashed password
    final signupRequest = SignupRequest(
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      email: _emailController.text,
      ssn: _ssnController.text,
      dateOfBirth: DateTime.parse(_dateOfBirthController.text),
      phoneNumber: _phoneNumberController.text,
      password: hashedPassword,
      // Use hashed password here
      inmateId: int.tryParse(_inmateIdController.text) ?? 0,
    );

    // Prepare the data for the request
    final data = signupRequest.toMap();

    try {
      final response = await http
          .post(
            Uri.parse('${dotenv.env['API_URL']!}/signup'),
            headers: {'Content-Type': 'application/json'},
            body: json.encode(data),
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 201) {
        showMessageDialog("SignUp successful", "Please Login");
      } else {
        showMessageDialog("SignUp Failed", response.body);
      }
    } catch (e) {
      showMessageDialog("SignUp Failed", "Request timed out");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
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
                Navigator.pop(context); // Close the dialog
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                );
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
