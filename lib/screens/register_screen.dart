import 'package:ezcheck_app/helper/db_helper.dart'; // Import your database helper
import 'package:ezcheck_app/models/user.dart';
import 'package:ezcheck_app/screens/onboard1_screen.dart';
import 'package:ezcheck_app/screens/onboard_screen.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key});

  // Controller for the text fields
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey[300],
        child: Center(
          child: Container(
            width: 400,
            height: 690,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                Column(
                  children: [
                    Image.asset('assets/images/EzCheckText1.png'),
                  ],
                ),
                const SizedBox(height: 50),
                const Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
                TextField(
                  controller: fullNameController,
                  decoration: InputDecoration(
                    labelText: 'Full Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: Colors.white.withOpacity(1.0),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: Colors.white.withOpacity(1.0),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: Colors.white.withOpacity(1.0),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: confirmPasswordController,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: Colors.white.withOpacity(1),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 30),
                Container(
                  width: 350,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Color(0xFF31434F)),
                    onPressed: () async {
                      // Check if passwords match
                      if (passwordController.text ==
                          confirmPasswordController.text) {
                        // Call the registration method from the DatabaseHelper
                        await _registerUser(context);
                      } else {
                        // Show an error message if passwords don't match
                        _showErrorDialog(context, 'Passwords do not match.');
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      child: Text(
                        'Register',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account? "),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      },
                      child: const Text(
                        'Login now!',
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

Future<void> _registerUser(BuildContext context) async {
  // Get user input
  String fullName = fullNameController.text;
  String email = emailController.text;
  String password = passwordController.text;

  // Create a User object
  User user = User(fullname: fullName, email: email, password: password);

  print('User to be registered: $user');

  // Call the registration method from the DatabaseHelper
  DatabaseHelper dbHelper = DatabaseHelper();
  int result = await dbHelper.registerUser(user);

  print('Registration result: $result');

  // Check the result and navigate accordingly
  if (result > 0) {
    // Registration successful
    // You can navigate to the main screen or perform other actions
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginScreenCheck(),
      ),
    );
  } else {
    // Registration failed
    // You can show an error message or handle it accordingly
    _showErrorDialog(context, 'Registration failed. Please try again.');
  }
}


  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
