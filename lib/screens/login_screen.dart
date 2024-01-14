import 'package:ezcheck_app/helper/db_helper.dart';
import 'package:ezcheck_app/screens/cart_screen.dart';
import 'package:ezcheck_app/screens/terms.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    DatabaseHelper dbHelper = DatabaseHelper();

    final FocusNode emailFocus = FocusNode();
    final FocusNode passwordFocus = FocusNode();

    void login() async {
      String email = emailController.text;
      String password = passwordController.text;

      bool success = await dbHelper.loginUser(email, password);
      if (success) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => CartScreen(),
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Login Failed'),
              content: Text('Invalid username or password. Please try again.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
        print('Invalid credentials');
      }
    }

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey[300],
        ),
        child: Center(
          child: Container(
            width: 400,
            height: 475,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/EzCheckText2.png'),
                const SizedBox(height: 15),
                const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  padding: EdgeInsets.all(10),
                  child: const Text('Please log-in your account'),
                ),
                TextField(
                  controller: emailController,
                  focusNode: emailFocus,
                  textInputAction: TextInputAction.next,
                  onSubmitted: (term) {
                    emailFocus.unfocus();
                    FocusScope.of(context).requestFocus(passwordFocus);
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white.withOpacity(1.0),
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: passwordController,
                  focusNode: passwordFocus,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (term) {
                    passwordFocus.unfocus();
                    login();
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.8),
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 15),
                Container(
                  width: 400,
                  child: ElevatedButton(
                    onPressed: login,
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF31434F),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 16,
                      ),
                      child: Text(
                        'Login',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Don't have an account?",
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DataPrivacyPage(),
                      ),
                    );
                  },
                  child: const Text(
                    'Register here!',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
