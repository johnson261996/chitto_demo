// lib/screens/login_page.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/AuthNotifier.dart';


class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var authNotifier = context.read<AuthNotifier>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: (value) {
                authNotifier.phoneNumber = value;
              },
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'Phone Number',
              ),
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () async {
                await authNotifier.generateOtp(context);
                // Navigate to the next screen or perform necessary actions
              },
              child: Text('Send Verification Code'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                await authNotifier.signInWithGoogle(context);
                // Navigate to the next screen or perform necessary actions
              },
              child: Text('Sign in with Google'),
            ),
          ],
        ),
      ),
    );
  }
}
