import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Forgot Password')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(decoration: InputDecoration(labelText: 'Email')),
            ElevatedButton(
              onPressed: () {
                // Logika reset password di sini
                Navigator.pop(context);
              },
              child: Text('Reset Password'),
            ),
          ],
        ),
      ),
    );
  }
}
