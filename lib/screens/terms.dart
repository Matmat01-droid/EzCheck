import 'package:ezcheck_app/screens/register_screen.dart';
import 'package:flutter/material.dart';

class DataPrivacyPage extends StatelessWidget {
  const DataPrivacyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 100),
          const Text(
            'Data & Privacy',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          SizedBox(height: 100),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("""
We collect data and personal information which include, but are not limited to, names,  phone numbers, email address and installed application information to improve customer service experience and other legitimate business purposes, which includes sharing the data to a third party to enable fraud-detection services to prevent fraudulenttransactions.Para tumuloy, kailangan pumayag sa aming policiesPumapayag ako sa guidelines ng Ez check Terms & Conditions. Naintindihan ko rin ang Ez Check Privacy Policy at kung paano ginagamit ang aking data para ipaganda ang aking app experience.

"""),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(primary: Color(0xFF31434F)),
                      onPressed: () {
                        // Add your logic for handling the "Agree and Continue" button
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    RegisterPage())); // Return true to indicate agreement
                      },
                      child: Text('Agree and Continue'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
