import 'package:ezcheck_app/helper/db_helper.dart';
import 'package:ezcheck_app/models/user.dart';
import 'package:ezcheck_app/screens/onboard_screen.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key});


  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();


  final FocusNode firstNameFocus = FocusNode();
  final FocusNode lastNameFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  final FocusNode confirmPasswordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.grey[300],
          child: Center(
            child: Container(
              width: 400,
              height: 750,
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
                  Column(
                    children: [
                      Image.asset('assets/images/EzCheckText1.png'),
                    ],
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: firstNameController,
                    focusNode: firstNameFocus,
                    textInputAction: TextInputAction.next,
                    onSubmitted: (term) {
                      firstNameFocus.unfocus();
                      FocusScope.of(context).requestFocus(lastNameFocus);
                    },
                    decoration: InputDecoration(
                      labelText: 'First Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(1.0),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: lastNameController,
                    focusNode: lastNameFocus,
                    textInputAction: TextInputAction.next,
                    onSubmitted: (term) {
                      lastNameFocus.unfocus();
                      FocusScope.of(context).requestFocus(emailFocus);
                    },
                    decoration: InputDecoration(
                      labelText: 'Last Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(1.0),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: emailController,
                    focusNode: emailFocus,
                    textInputAction: TextInputAction.next,
                    onSubmitted: (term) {
                      emailFocus.unfocus();
                      FocusScope.of(context).requestFocus(passwordFocus);
                    },
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(1.0),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: passwordController,
                    focusNode: passwordFocus,
                    textInputAction: TextInputAction.next,
                    onSubmitted: (term) {
                      passwordFocus.unfocus();
                      FocusScope.of(context).requestFocus(confirmPasswordFocus);
                    },
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
                  const SizedBox(height: 10),
                  TextField(
                    controller: confirmPasswordController,
                    focusNode: confirmPasswordFocus,
                    textInputAction: TextInputAction.done,
                    onSubmitted: (term) {
                      confirmPasswordFocus.unfocus();
                      _registerUser(context);
                    },
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
                  const SizedBox(height: 15),
                  Container(
        width: 350,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(primary: Color(0xFF31434F)),
          onPressed: () async {
            if (passwordController.text == confirmPasswordController.text) {
              bool registrationSuccess = await _registerUser(context);
              if (registrationSuccess) {
                _showSuccessDialog(context);
              } else {
                _showErrorDialog(context, 'Registration failed. Please try again.');
              }
            } else {
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
                  const SizedBox(height: 10),
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
      ),
    );
  }


Future<bool> _registerUser(BuildContext context) async {

    String firstName = firstNameController.text;
    String email = emailController.text;
    String password = passwordController.text;

    User user = User(fullname: firstName, email: email, password: password);

    print('User to be registered: $user');
    DatabaseHelper dbHelper = DatabaseHelper();
    int result = await dbHelper.registerUser(user);

    print('Registration result: $result');
    return result > 0;
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Success'),
          content: Text('Registration successful!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                // Proceed to the next screen or perform any other action
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreenCheck(),
                  ),
                );
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
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
